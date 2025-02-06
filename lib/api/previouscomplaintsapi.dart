

import 'package:announcement/api/loginapi.dart';
import 'package:dio/dio.dart';

final dio = Dio();
List<Map<String, dynamic>> feedbackss = [];
Future<void> previouscomplaints() async {
  try {
    final response = await dio.get('$baseUrl/viewfeedbacks', queryParameters: {'lid': lid});
    if (response.statusCode == 200) {
      print(response.data);
      List<dynamic> data = response.data;  // Make sure you're accessing the correct key
      feedbackss=List<Map<String, dynamic>>.from(response.data);
    } else {
      print('Failed to load complaints, status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
  