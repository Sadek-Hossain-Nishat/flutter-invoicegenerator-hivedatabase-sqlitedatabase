import 'package:flutter/material.dart';
import 'package:flutterapp_zorinos/GENERATE_PDF_INVOICE/widget/button_widget.dart';
import 'package:flutterapp_zorinos/GENERATE_PDF_INVOICE/widget/title_widget.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Invoice Generator App"),
        centerTitle: true,
      ),

      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleWidget(icon: Icons.picture_as_pdf, text:  'Generate Invoice'),

              SizedBox(height: 48,),
              ButtonWidget(text: "Invoice Pdf", onClicked: () async{
                final date = DateTime.now();
                final dueDate = date.add(Duration(days: 7));

                // final invoice =
              })
            ],

          ),
        ),
      ),
    );
  }
}
