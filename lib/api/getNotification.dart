
// ignore_for_file: depend_on_referenced_packages

// import 'package:bussafety/Api/profileupdateapi.dart';
import 'package:announcement/api/loginapi.dart';
import 'package:dio/dio.dart';


final dio = Dio();

Future<List<Map<String,dynamic>>>getNotificationapi() async {
  try {

    Response response = await dio.get('$baseUrl/get_notifications',);
   

    // Response response = await dio.post('${apidata}/login?email=${email},password=${Password}');
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200) {
     print('success');
     
return List<Map<String,dynamic>>.from(response.data);
    } else { 
      return [];
      
    }
  } catch (e) {
    print(e.toString());
     return [];
  }
}
