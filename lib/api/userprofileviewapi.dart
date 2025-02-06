

import 'package:announcement/api/loginapi.dart';
import 'package:dio/dio.dart';


final dio = Dio();

Future<Map<String,dynamic>>userprofileview() async {
  try {
    final response = await dio.post('$baseUrl/userprofile?lid=$lid&usertype=$usertype');
    // Print the response data
    print('Response data: ${response.data}');
    
    if (response.statusCode == 200 || response.statusCode == 201) {
List<dynamic> resData=response.data;
 List<Map<String,dynamic>>finalStatus= resData.map((item) => item as Map<String, dynamic>).toList();
return finalStatus[0];
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('send successfully'),
      //     duration: Duration(seconds: 2), // Adjust the duration as needed
      //   ),
      // );
      // // Navigate to the home page
      //   Navigator.push(context,MaterialPageRoute(builder: (context) => MyWidget()),);
    }
     
    else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Failed to send feedback'),
      //     duration: Duration(seconds: 2),
      //   ),
      // );
      return {};
    }
  } catch (e) {
    
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('Error: $e'),
    //     duration: Duration(seconds: 2),
    //   ),
    // );
    print(e);
    return {};
  }
}
