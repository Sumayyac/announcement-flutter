import 'package:announcement/api/loginapi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeScreenService {
  final Dio _dio = Dio();
  // Replace with your actual API URL

  Future<Map<String, dynamic>> fetchHomeScreenData(BuildContext context) async {
    try {
      Response response = await _dio.get(
        baseUrl,
        options: Options(headers: {'Accept': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return response.data; // Return fetched data
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to load home data: ${response.statusMessage}")),
        );
        return {};
      }
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching data: ${e.message}")),
      );
      return {};
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An unexpected error occurred.")),
      );
      return {};
    }
  }
}
