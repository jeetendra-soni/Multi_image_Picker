import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Multi Image Picker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final ImagePicker _imagePicker = ImagePicker();
  List<XFile> imageFileList = [];

  void selectImages() async{
    if(imageFileList.length ==0 || imageFileList.length<5){
      final List<XFile> selectedImages = await _imagePicker.pickMultiImage();
      if(selectedImages!.isNotEmpty){
        imageFileList.addAll(selectedImages);
      }
      setState(() {

      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text("You can select multiple images", style: TextStyle(fontSize: 25),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        selectImages();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        elevation: 5,
                      ),
                      icon: const Icon(Icons.file_copy,
                          color: Colors.amber),
                      label: Text('Select Image'),
                    ),
                    SizedBox(width: 20,),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          imageFileList.length --;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        elevation: 5,
                      ),
                      icon: const Icon(Icons.delete_forever,
                          color: Colors.red),
                      label: Text('Delete Image'),
                    ),
                  ],
                ),
              ],
          )),

          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 200,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1.5
                ),
                itemCount: imageFileList!.length,
                itemBuilder: (BuildContext context, int index){
                  return Image.file(File(imageFileList[index].path), fit: BoxFit.cover,);
                }
              ),
            ),
          )
        ]

      ),
    );
  }
}
