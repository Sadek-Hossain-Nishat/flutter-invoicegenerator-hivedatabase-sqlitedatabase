import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main(){
  runApp(FutureAgeApp());
}

class FutureAgeApp extends StatelessWidget {
  const FutureAgeApp({super.key});

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

      home: FutureAgeAppHome(),
    );
  }
}


class FutureAgeAppHome extends StatefulWidget {
  const FutureAgeAppHome({super.key});

  @override
  State<FutureAgeAppHome> createState() => _FutureAgeAppHomeState();
}

class _FutureAgeAppHomeState extends State<FutureAgeAppHome> {

  final ImagePicker picker = ImagePicker();
// Pick an image.
  XFile? image ;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  Future<void> loadFuture() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {

    });

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text('Flutter Aging App'),
        centerTitle: true,
      ),


      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [


          image?.path!=null? Image.file(File(image!.path)):Text('No File is choosen',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,
          color: Colors.blue),),




          ElevatedButton(onPressed: loadFuture, child: Text('Pick Image',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,
              color: Colors.blue),))

          
        ],
      ),
    ));
  }
}

