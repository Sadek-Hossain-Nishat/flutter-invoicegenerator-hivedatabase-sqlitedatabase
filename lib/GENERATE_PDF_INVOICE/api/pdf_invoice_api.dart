import 'dart:io';


import 'package:flutterapp_zorinos/GENERATE_PDF_INVOICE/api/pdf_api.dart';
import 'package:flutterapp_zorinos/GENERATE_PDF_INVOICE/model/customer.dart';
import 'package:flutterapp_zorinos/GENERATE_PDF_INVOICE/model/invoice.dart';
import 'package:flutterapp_zorinos/GENERATE_PDF_INVOICE/model/supplier.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';



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

  static buildInvoice(Invoice invoice) {}

  static buildTitle(Invoice invoice) {}

  static buildTotal(Invoice invoice) {}
  static buildFooter(Invoice invoice) {}

  static Widget buildCustomerAddress(Customer customer)

  {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

      ]

    );
  }

  static Widget buildInvoiceInfo(InvoiceInfo info){
    return Column();
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
}