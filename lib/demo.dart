import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerDisplay extends StatefulWidget {
  const ImagePickerDisplay({super.key});

  @override
  State<ImagePickerDisplay> createState() => _ImagePickerDisplayState();
}

class _ImagePickerDisplayState extends State<ImagePickerDisplay> {
  final ImagePicker picker = ImagePicker();

  File? image;
  File? imageTemp;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
          imageTemp = File(image.path);
        setState(() {
          debugPrint('$imageTemp');
        });
      }
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text('Image from Gallery'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Center(
            child: Text(
              'Image Picked From Gallery',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          imageTemp != null
              ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Image.file(
                    imageTemp!,
                    fit: BoxFit.cover,
                  ),
                )
              : const Text(' No Image Preview'),
          ElevatedButton(
            onPressed: (){
              setState(() {
                pickImage();
              });
            },
            child: const Text('Image capture'),
          ),
        ],
      ),
    );
  }
}


