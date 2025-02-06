import 'dart:io';
import 'package:announcement/api/loginapi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<void> uploadImage(BuildContext context) async {
 
 
  final ImagePicker picker = ImagePicker();

  try {
    // Pick an image from the gallery
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No image selected.")),
      );
      return;
    }

    File imageFile = File(pickedImage.path);

    // Prepare the image for upload
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imageFile.path, filename: pickedImage.name),
    });

    Response response = await dio.post(
      '$baseUrl/jjjc:UsersHPDesktop\flutter Apipreviouscomplaintsapi.dart',
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Image uploaded successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Upload failed: ${response.data}")),
      );
    }
  } on DioException catch (e) {
    if (e.response != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Server error: ${e.response?.data}")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to upload image. Check your connection.")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("An unexpected error occurred.")),
    );
  }
}
