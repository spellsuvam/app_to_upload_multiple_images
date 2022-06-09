import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker imagePicker = ImagePicker();

  List<XFile>? imageFileList = [];

  void selectImagesfromGallery() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
  }

  void uploadImages()async {
    Dio dio = Dio(); // create a new instance
    imageFileList = imageFileList!.toSet().toList();  // remove duplicates
    final List<String> filePaths =
        imageFileList!.map((XFile file) => file.path).toList(); // get file paths
    for (XFile image in imageFileList!) { 
      print("Image Paths");
      print(image.path);
    }
  FormData formData = FormData(); 
    for (var file in filePaths) { 
      formData.files.addAll([
        MapEntry("assignment", await MultipartFile.fromFile(file)),
      ]);
    }
    print("total images:-");
    print(formData.files.length);
  }

  void getImagesFromCamera()async {
    final XFile? images=await imagePicker.pickImage(source: ImageSource.camera);
    if(images!=null){
      imageFileList!.add(images);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Image Picker Example"),
        ),
        body: Center(
          child: Column(
            children: [
              MaterialButton(
                  color: Colors.blue,
                  child: const Text("Pick Images from Gallery",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    selectImagesfromGallery();
                  }),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                  color: Colors.blue,
                  child: const Text("Pick Images from Camera",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    getImagesFromCamera();
                  }),
                  const SizedBox(
                height: 20,
              ),
              MaterialButton(
                  color: Colors.blue,
                  child: const Text("Upload Images",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    uploadImages();
                  }),

              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    itemCount: imageFileList!.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return Image.file(File(imageFileList![index].path),
                          fit: BoxFit.cover);
                    }),
              ))
            ],
          ),
        ));
  }
}
