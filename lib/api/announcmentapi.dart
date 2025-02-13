import 'dart:io'; // To use File class
import 'package:announcement/api/loginapi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';






Future<void> submitAnnouncement(
  BuildContext context,
  String title,
  String description,
  File doc,
  String audio,
  String department,
  String time,
) async {
  // Prepare FormData to send
//  String convertedAudioPath = await convertAacToMp3(audio);

FormData formData = FormData.fromMap({
  'userid': lid,
  'title': title,
  'description': description,
  'department': department,
  'time': time,
  'doc': await MultipartFile.fromFile(doc.path, filename: doc.uri.pathSegments.last),
  'audio': await MultipartFile.fromFile(audio, filename: '${audio.split('/').last}'),
});

  try {
    Response response = await dio.post(
      "$baseUrl/upload", // Change this to your actual API endpoint
      options: Options(
        headers: {'Content-Type': 'multipart/form-data'}, // This tells Dio to send multipart data
      ),
      data: formData,
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Announcement submitted successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${response.data}")),
      );
    }
  } on DioException catch (e) {
    if (e.response != null) {
      print(e.response!.data);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Server error: ${e.response?.data}")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to submit announcement. Check your connection.")),
      );
    }
  } catch (e) {
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("An unexpected error occurred.")),
    );
  }
}
