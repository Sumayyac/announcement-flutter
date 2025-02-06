import 'package:announcement/api/complaintapi.dart';
import 'package:announcement/api/previouscomplaintsapi.dart';
import 'package:flutter/material.dart';

class TextInputPage extends StatefulWidget {
  const TextInputPage({super.key});

  @override
  _TextInputPageState createState() => _TextInputPageState();
}

class _TextInputPageState extends State<TextInputPage> {
  // TextController to manage input text in the TextField
  final TextEditingController _controller = TextEditingController();

  // List to store all submitted complaints
  
  
  // String? get complaintText => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
        foregroundColor: const Color.fromARGB(255, 250, 248, 248),
        backgroundColor: const Color.fromARGB(255, 57, 57, 59),

        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Long TextBox (TextField) for user input
            TextField(
              controller: _controller, // Assigning the controller to manage the input
              maxLines: 5, // Allow multiple lines
              decoration: InputDecoration(
                labelText: 'Enter your Feedback here',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16), // Space between the TextField and the button

            // Submit Button
            ElevatedButton(
              onPressed: ()async {
                await submitComplaint(context,_controller.text);
                // When the submit button is clicked, store the text
                await previouscomplaints();
                setState(() {

                
                });
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
              ),
              child: Text('Submit'),
            ),
            SizedBox(height: 16), // Space between the button and the complaints list

            // Text to display if no complaints are available
            Text(
              feedbackss.isEmpty ? 'No feedback submitted yet.' : 'Feedbacks:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            // List of all submitted complaints
            Expanded(
              child: feedbackss.isEmpty
                  ? Container() // Empty container if no complaints
                  : ListView.builder(
                      itemCount: feedbackss.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              feedbackss[index]['feedback'],
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
