import 'package:flutter/material.dart';

class TextInputPage extends StatefulWidget {
  @override
  _TextInputPageState createState() => _TextInputPageState();
}

class _TextInputPageState extends State<TextInputPage> {
  // TextController to manage input text in the TextField
  final TextEditingController _controller = TextEditingController();

  // List to store all submitted complaints
  List<String> complaints = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaints Submission'),
        backgroundColor: const Color.fromARGB(255, 234, 110, 15),
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
                labelText: 'Enter your complaint here',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16), // Space between the TextField and the button

            // Submit Button
            ElevatedButton(
              onPressed: () {
                // When the submit button is clicked, store the text
                setState(() {
                  if (_controller.text.isNotEmpty) {
                    complaints.add(_controller.text); // Add the complaint to the list
                    _controller.clear(); // Clear the text field after submission
                  }
                });
              },
              child: Text('Submit'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 16), // Space between the button and the complaints list

            // Text to display if no complaints are available
            Text(
              complaints.isEmpty ? 'No complaints submitted yet.' : 'All Complaints:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            // List of all submitted complaints
            Expanded(
              child: complaints.isEmpty
                  ? Container() // Empty container if no complaints
                  : ListView.builder(
                      itemCount: complaints.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              complaints[index],
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
