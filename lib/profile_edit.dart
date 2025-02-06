import 'package:announcement/api/loginapi.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> userData;
  

  const ProfilePage({required this.userData,super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        
        title: Text('Profile Page'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            // Center(
            //   child: CircleAvatar(
            //     radius: 50,
            //     backgroundImage: NetworkImage(
            //       'https://www.example.com/profile_picture.jpg',
            //     ),
            //   ),
            // ),
            SizedBox(height: 16),

            Text(
              "Name: ${userData['name']}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
if(usertype=='REP'||usertype=='UNION'||usertype=='Teacher')
            Text(
              "Department: ${userData['department']}",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),

            Text(
              "Qualification: ${userData['qualification']}",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),

            Text(
              "Phone: ${userData['phone']}",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),

            Text(
              "Email: ${userData['email']}",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            if(usertype=='REP'||usertype=='UNION')
             Text(
              "Semester: ${userData['semester']}",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}


