import 'dart:io';

import 'package:flutterapp_zorinos/GENERATE_PDF_INVOICE/model/invoice.dart';
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


    return File("");


  }

  static buildHeader(Invoice invoice) {}

  static buildInvoice(Invoice invoice) {}

  static buildTitle(Invoice invoice) {}

  static buildTotal(Invoice invoice) {}
  static buildFooter(Invoice invoice) {}



}