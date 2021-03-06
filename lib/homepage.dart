import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker imagePicker = ImagePicker();

  List<XFile>? imageFileList = [];

  void selectImagesfromGallery() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      setState(() {
        imageFileList!.addAll(selectedImages);
      });
    }
  }

  void getImagesFromCamera() async {
    final XFile? images =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (images != null) {
      setState(() {
        imageFileList!.add(images);
      });
    }
  }

  void removeSelectedImage(XFile image) {
    setState(() {
      imageFileList!.remove(image);
    });
  }

  void uploadImages() async {
    Dio dio = Dio(); // create a new instance
    final List<String> filePaths = imageFileList!
        .map((XFile file) => file.path)
        .toList(); // get file paths
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Image Picker Example"),
        ),
        body: Center(
          child: Column(
            children: [
              Column(
                children: [
                  MaterialButton(
                      color: Colors.blue,
                      child: const Text("Pick Images from Gallery",
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold)),
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
                              color: Colors.white70,
                              fontWeight: FontWeight.bold)),
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
                              color: Colors.white70,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        uploadImages();
                      }),
                ],
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    itemCount: imageFileList!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.file(File(imageFileList![index].path),
                                fit: BoxFit.cover),
                          ),
                          Positioned(
                            left: 5,
                            top: 5,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 10,
                                    offset: Offset(0, 10),
                                  )
                                ],
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: IconButton(
                                  iconSize: 24,
                                  onPressed: () {
                                    removeSelectedImage(imageFileList![index]);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    }),
              ))
            ],
          ),
        ));
  }
}
