import 'package:flutter/material.dart';

void main(){
  runApp(InvoiceGeneratorApp());
}

class InvoiceGeneratorApp extends StatelessWidget {
  const InvoiceGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        )
      ),

      home: InvoiceGeneratorHomePage(),
    );
  }
}

class InvoiceGeneratorHomePage extends StatefulWidget {
  const InvoiceGeneratorHomePage({super.key});

  @override
  State<InvoiceGeneratorHomePage> createState() => _InvoiceGeneratorHomePageState();
}

class _InvoiceGeneratorHomePageState extends State<InvoiceGeneratorHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text("Invoice Generator App"),
      centerTitle: true,),
    ));
  }
}

