import 'package:announcement/api/loginapi.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For picking image
import 'dart:io'; // For file handling
import 'package:dio/dio.dart'; // For Dio package to handle HTTP requests

class NoticeScreen extends StatefulWidget {
  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  TextEditingController _titleController = TextEditingController();
  File? _pickedImage; // Variable to store the picked image

  // Function to pick an image
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    }
  }

  // Function to send notice to the server
Future<void> _sendNotice() async {
  String title = _titleController.text;

  if (title.isEmpty || _pickedImage == null) {
    // Display an error if title or image is missing
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please enter a title and choose an image')),
    );
    return;
  }

  try {
    // Prepare data to be sent in the form of FormData
    FormData formData = FormData.fromMap({
      'title': title,
      'image': await MultipartFile.fromFile(_pickedImage!.path, filename: 'notice_image.jpg'),
      'lid': lid, // You might want to ensure `lid` is defined elsewhere
    });

    // Print the form data (you need to loop over the formData to print the values)
    print('/////////////');
    formData.fields.forEach((field) {
      print('${field.key}: ${field.value}');
    });
    print('/////////////');

    // Send POST request using Dio
    Dio dio = Dio();
    Response response = await dio.post(
      'http://192.168.43.171:5001/submit_notice', // Replace with your actual API endpoint
      data: formData,
    );

    if (response.statusCode == 200) {
      // If the request is successful, clear the fields and show success message
      setState(() {
        _titleController.clear();
        _pickedImage = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Notice sent successfully')),
      );
    } else {
      // Handle non-200 responses
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send notice. Please try again.')),
      );
    }
  } catch (e) {
    // Handle errors such as network issues
    print('Error sending notice: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error sending notice. Please try again.')),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Notice'),
        backgroundColor: const Color.fromARGB(255, 70, 70, 70),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Input Field
            Text('Notice Title:', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter title',
                filled: true,
                fillColor: Colors.grey[200],
              ),
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),

            // Image Picker
            Text('Choose Image:', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: _pickedImage == null
                    ? Center(
                        child: Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
                      )
                    : Image.file(
                        _pickedImage!,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            SizedBox(height: 16),

            // Send Button
            Center(
              child: ElevatedButton(
                onPressed: _sendNotice,
                style: ElevatedButton.styleFrom(
                   foregroundColor: const Color.fromARGB(255, 250, 248, 248),
                   backgroundColor: const Color.fromARGB(255, 70, 70, 70),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(fontSize: 20),
                ),
                child: Text('Send Notice'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
