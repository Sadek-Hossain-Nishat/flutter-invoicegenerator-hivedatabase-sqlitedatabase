import 'dart:io';
import 'dart:math';


import 'package:flutterapp_zorinos/GENERATE_PDF_INVOICE/api/pdf_api.dart';
import 'package:flutterapp_zorinos/GENERATE_PDF_INVOICE/model/customer.dart';
import 'package:flutterapp_zorinos/GENERATE_PDF_INVOICE/model/invoice.dart';
import 'package:flutterapp_zorinos/GENERATE_PDF_INVOICE/model/supplier.dart';
import 'package:flutterapp_zorinos/GENERATE_PDF_INVOICE/utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;



class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async{

    final pdf = Document();
    pdf.addPage(MultiPage(build: (context)=>[
      buildHeader(invoice),
      SizedBox(height: 3*PdfPageFormat.cm),
      buildTitle(invoice),
      buildInvoice(invoice),
      Divider(),
      buildTotal(invoice)
    ],


    footer: (context)=>buildFooter(invoice)));


    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);


  }

  static Widget buildHeader(Invoice invoice) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1*PdfPageFormat.cm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            buildSupplierAddress(invoice.supplier),
            Container(
              height: 50,
              width: 50,
              child: BarcodeWidget(data: invoice.info.number, barcode:Barcode.qrCode())
            )
          ]
        ),
        SizedBox(height: 1*PdfPageFormat.cm),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildCustomerAddress(invoice.customer),
            buildInvoiceInfo(invoice.info)
          ]

        )
      ]

    );
  }

  static buildInvoice(Invoice invoice) {

    final headers =[
      'Description',
      'Date',
      'Quantity',
      'Unit Price',
      'Vat',
      'Total'
    ];

    final data = invoice.items.map((item){

      final total= item.unitPrice*item.quantity*(1+item.vat);

      return [
        item.description,
        Utils.formatDate(item.date),
        '${item.quantity}',
        '\$ ${item.unitPrice}',
        '${item.vat} %',
        '\$ ${total.toStringAsFixed(2)}'
      ];

    }).toList();

    return TableHelper.fromTextArray(data: data,headers: headers,
    border: null,
    headerStyle: TextStyle(fontWeight: FontWeight.bold),
    headerDecoration:  BoxDecoration(color: PdfColors.grey300),
    cellHeight: 30,
    cellAlignments: {
      0: Alignment.centerLeft,
      1: Alignment.centerRight,
      2: Alignment.centerRight,
      3:Alignment.centerRight,
      4:Alignment.centerRight,
      5:Alignment.centerRight
    });
  }

  static buildTitle(Invoice invoice) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('INVOICE',
        style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
        SizedBox(height: 0.8*PdfPageFormat.cm),
        Text(invoice.info.description),
        SizedBox(height: 0.8*PdfPageFormat.cm)
      ]
    );
  }

  static buildTotal(Invoice invoice) {
    final netTotal = invoice.items.map((item)=>item.unitPrice*item.quantity)
        .reduce((item1,item2)=>item1+item2);
    final vatPercent = invoice.items.first.vat;
    final vat = netTotal*vatPercent;
    final total = netTotal+vat;
    return Container(
      alignment:  Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildText(title: 'Net total', value: Utils.formatPrice(vat),
              unite: true),
              Divider(),
              buildText(title: 'Total amount due',titleStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold
              ), value:Utils.formatPrice(total),
              unite: true),
              SizedBox(height:  2*PdfPageFormat.mm),
              Container(height: 1,color: PdfColors.grey400),
              SizedBox(height: 0.5*PdfPageFormat.mm),
              Container(height: 1,color: PdfColors.grey400)
            ]
          ),flex: 4)
        ]
      )
    );
  }
  static buildFooter(Invoice invoice) {


    return Column(


      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Divider(),
        SizedBox(height: 2*PdfPageFormat.mm),
        buildSimpleText(title:'Address',value: invoice.supplier.address),
        SizedBox(height: 1*PdfPageFormat.mm),
        buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo)
      ]
    );
  }


  static buildSimpleText({required String title, required String value}){

    final style = TextStyle(fontWeight: FontWeight.bold);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title,style: style),
        SizedBox(width: 2*PdfPageFormat.mm),
        Text(value)
      ]
    );

}

  static Widget buildCustomerAddress(Customer customer)

  {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        Text(customer.name,style: TextStyle(fontWeight: FontWeight.bold)),
        Text(customer.address)

      ]

    );
  }

  static Widget buildInvoiceInfo(InvoiceInfo info){
    final paymentTerms = '${info.dueDate.difference(info.date).inDays} days';
    final titles =<String>[
      'Invoice Number:',
      'Invoice Date:',
      'Payment Terms:',
      'Due Date:'
    ];

    final data = <String>[
      info.number,
      Utils.formatDate(info.date),
      paymentTerms,
      Utils.formatDate(info.dueDate)

    ];
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index){
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value,width: 200);
      })
    );
  }
  static Widget buildSupplierAddress(Supplier supplier)


 {


   return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       Text(supplier.name,style: TextStyle(fontWeight: FontWeight.bold),),
       SizedBox(height: 1*PdfPageFormat.mm,),
       Text(supplier.address)
     ],
   );
  }


  static buildText({required String title,
  required String value,
  double width = double.infinity,
  TextStyle? titleStyle,
  bool unite = false}) {

    final style = titleStyle??TextStyle(fontWeight: FontWeight.bold);
    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title,style: style)),
          Text(value,style: unite?style:null)
        ]
      )
    );

  }
}