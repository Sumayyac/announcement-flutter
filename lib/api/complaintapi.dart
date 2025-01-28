import 'package:announcement/api/loginapi.dart'; // Ensure this file contains valid `dio`, `baseUrl`, and `lid`.
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<void> submitComplaint(BuildContext context, String complaintText) async {
  // Validate the complaint text
  if (complaintText.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please enter a complaint before submitting.")),
    );
    return;
  }

  // Prepare complaint data
  Map<String, dynamic> complaintData = {
    'complaint': complaintText,
    'submitted_at': DateTime.now().toIso8601String(),
  };

  try {
    print('*******************');
    print(complaintText);
    
    // Make the POST request
    Response response = await dio.post(
      '$baseUrl/sendfeedback?lid=$lid&feedback=$complaintText',
      options: Options(headers: {'Content-Type': 'application/json'}),
      
     
    );

    // Check response status
    if (response.statusCode == 201 || response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Complaint submitted successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${response.data}")),
      );
    }
  } on DioException catch (e) {
    // Handle server-side or connection errors
    if (e.response != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Server error: ${e.response?.data}")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to submit complaint. Check your connection.")),
      );
    }
  } catch (e) {
    // Handle unexpected errors
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("An unexpected error occurred.")),
    );
  }
}
