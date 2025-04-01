import 'package:announcement/homepage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final dio = Dio();
int? lid;
String? usertype;
String? loginstatus;
String baseUrl = 'http://192.168.43.252:5000';

Future<void> loginapi(String Username, String password, BuildContext context) async {
  
  try {
    print('sdfggsgg');
    final response = await dio.post('$baseUrl/logincheck?email=$Username&Password=$password');
    print(response.data);

    // Corrected: Use 'statusCode' (lowercase 's')
    int? res = response.statusCode;
    print(res);

    if (res == 200 && response.data['task'] == 'success') {
      // Store user type from the response
      usertype = response.data['type'];
     
      lid = response.data['lid'];

      // Check usertype and navigate accordingly
      if (usertype != null) {
        if (usertype == 'Teacher') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => HomeScreen())); // Replace with your Teacher Home screen
        } else if (usertype == 'Union') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => HomeScreen())); // Replace with your Union Home screen
        } else if (usertype == 'REP') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => HomeScreen())); // Replace with your Rep Home screen
        } else if (usertype == 'Teacher') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => HomeScreen())); // Replace with your Staff Home screen
        } 
        } else if (usertype == 'staff') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => HomeScreen())); // Replace with your Staff Home screen
        } else {
          print('Unknown user type');
        }
      }
     else {
      print('Login failed or invalid credentials');
    }
  } catch (e) {
    print('Error occurred: $e');
  }
}
