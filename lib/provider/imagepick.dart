import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Imagepick extends StatefulWidget {
  const Imagepick({super.key});

  @override
  State<Imagepick> createState() => _ImagepickState();
}

class _ImagepickState extends State<Imagepick> {
  File? _pickedImageFile;

  void _pickImage() async {
    final XFile? pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 150, imageQuality: 50);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage:_pickedImageFile == null? null: FileImage(_pickedImageFile!),
        ),
        TextButton.icon(
          onPressed:_pickImage,
          icon: Icon(Icons.image),
          label: Text(
            'Add Image',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        )
      ],
    );
  }
}