import 'package:announcement/api/loginapi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<void> _submitAnnouncement(context) async {


  Map<String, dynamic> announcementData = {
    // 'title': "",
    // 'message': "",
    // 'departments': _multiDropDownController.dropDownValueList!
    //     .map((e) => e.name)
    //     .toList(),
    // 'time': '${selectedTime.hour}:${selectedTime.minute}',
  };

  try {
    Response response = await dio.post(
      "$baseUrl/hkhckhc",
      options: Options(headers: {'Content-Type': 'application/json'}),
      data: announcementData,
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Server error: ${e.response?.data}")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to submit announcement. Check your connection.")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("An unexpected error occurred.")),
    );
  }
}
