import 'package:announcement/addNoticeScreen.dart';
import 'package:announcement/api/getNotification.dart';
import 'package:announcement/api/previouscomplaintsapi.dart';
import 'package:announcement/api/userprofileviewapi.dart';
import 'package:announcement/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:announcement/complaint.dart';
import 'package:announcement/notification_page.dart';
import 'package:announcement/profile_edit.dart';
import 'annoucment.dart';

class HomeScreen extends StatelessWidget {
  final String name = "John Doe";
  final String department = "Software Engineering";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text('Home Page'),
        foregroundColor: const Color.fromARGB(255, 250, 248, 248),
        backgroundColor: const Color.fromARGB(255, 70, 70, 70),
        actions: [
          GestureDetector(
            onTap: ()async {
              List<Map<String,dynamic>> notifi=await getNotificationapi();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage(notifi:notifi)),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.notifications_active_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
        
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Column(
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => ProfilePage(userData)),
                        // );
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      department,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
             ListTile(
  leading: Icon(Icons.person, color: Colors.black),
  title: Text(
    'Profile',
    style: TextStyle(color: Colors.black),
  ),
  onTap: () async {
 
      // Ensure you declare `profiledata` properly
      Map<String, dynamic> profileData = await userprofileview(); // Corrected variable name to camelCase for consistency
     
       
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(userData: profileData),
          ),
        );
     
   
  },
),

              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.black),
                title: Text('Logout'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Logout Confirmation'),
                        content: Text('Are you sure you want to log out?'),
                        actions: [
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                          ),
                          TextButton(
                            child: Text('Logout'),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow.shade100, Colors.brown.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Announcement Card
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AnnouncementPage()),
                    );
                  },
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      width: 155,
                      height: 180,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [Colors.teal.shade400, Colors.teal.shade800],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdm2bOTvE2vzBM16qsVWI-sPN4D2JVNw-EiA&s",
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Announcement',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Feedback Card
                GestureDetector(
                  onTap: () async{
                   await previouscomplaints();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TextInputPage()),
                    );
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text('Feedback button clicked!')),
                    // );
                  },
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      width: 150,
                      height: 180,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [Colors.teal.shade400, Colors.teal.shade800],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.feedback, size: 50, color: Colors.white),
                          SizedBox(height: 10),
                          Text(
                            'Feedback',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20,),
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               GestureDetector(
                  onTap: () async{
                   await previouscomplaints();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NoticeScreen()),
                    );
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text('Feedback button clicked!')),
                    // );
                  },
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      width: 150,
                      height: 180,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [Colors.teal.shade400, Colors.teal.shade800],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.notification_add_rounded, size: 50, color: Colors.white),
                          SizedBox(height: 10),
                          Text(
                            'Add notice',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),




 GestureDetector(
                  onTap: () async{
                   await previouscomplaints();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen(),
                      ),(route) => false,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('logout')),
                    );
                  },
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      width: 150,
                      height: 180,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [Colors.brown.shade500, Colors.brown.shade800],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout, size: 50, color: Colors.white),
                          SizedBox(height: 10),
                          Text(
                            'Log Out',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),


            ],)
          ],
        ),
      ),
    );
  }
}
