import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp_zorinos/GENERATE_PDF_INVOICE/page/pdf_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  runApp(InvoiceGeneratorApp());
}

class InvoiceGeneratorApp extends StatelessWidget {
  const InvoiceGeneratorApp({super.key});


  static final String title = "Invoice";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,

      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
        )
      ),

      home: PdfPage()
      // InvoiceGeneratorHomePage(),
    );
  }
}

class InvoiceGeneratorHomePage extends StatelessWidget {
  const InvoiceGeneratorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text("Invoice Generator App"),


      centerTitle: true,),
    ));
  }
}

