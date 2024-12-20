import 'package:announcement/complaint.dart';
import 'package:announcement/notification_page.dart';
import 'package:announcement/profile_edit.dart';
import 'package:flutter/material.dart';
import 'annoucment.dart';

class HomeScreen extends StatelessWidget {
  final String name = "name: John Doe";  // Example name
  final String department = "dep: Software Engineering";  // Example department

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
        backgroundColor:Colors.blueAccent,
        actions: [
          // Custom Heart-shaped Notification Button on the top right
          GestureDetector(
            onTap: () {
              // Navigate to the NotificationPage when the heart-shaped icon is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.favorite_outline,
                color: const Color.fromARGB(255, 11, 11, 11),
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Color(0XFFFF9966), // Set the background color to blue
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile Picture Section (with GestureDetector for navigation)
            GestureDetector(
              onTap: () {
                // Navigate to the EditProfilePage when the image is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: CircleAvatar(
                radius: 50, // The radius of the circle
                backgroundImage: NetworkImage(
                  'https://www.example.com/profile_picture.jpg', // Replace with a valid image URL
                ),
              ),
            ),
            SizedBox(height: 16),

            // Name and Department
            Text(
              name, // Display Name
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Text color white for contrast
              ),
            ),
            SizedBox(height: 8),
            Text(
              department, // Display Department
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[300], // Light grey for department text
              ),
            ),
            SizedBox(height: 32),

            // Buttons for Announcement and Complaint
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Announcement Button
                ElevatedButton(
                  onPressed: () {
                    // Action for Announcement button
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AnnouncementPage()),
                    );
                  },
                  child: Text('ANNOUNCEMENT'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0CCCF2), // Button color
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    textStyle: TextStyle(fontSize: 28),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Makes the button rectangular
                    ),
                  ),
                ),
                // Feedback Button
                ElevatedButton(
                  onPressed: () {
                    // Action for Complaint button
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TextInputPage()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Complaint button clicked!')),
                    );
                  },
                  child: Text('FEEDBACK'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 4, 250, 229),
                    foregroundColor: Colors.black, // Button color
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    textStyle: TextStyle(fontSize: 28),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Makes the button rectangular
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
