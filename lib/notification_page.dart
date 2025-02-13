import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key, this.notifi});
  
  final List<Map<String, dynamic>>? notifi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
         foregroundColor: const Color.fromARGB(255, 250, 248, 248),
        backgroundColor:const Color.fromARGB(255, 70, 70, 70),
      ),
      body: notifi == null || notifi!.isEmpty
          ? Center(child: Text('No notifications available.'))
          : ListView.builder(
              itemCount: notifi!.length,
              itemBuilder: (context, index) {
                // Extracting data for each notification
                final notification = notifi![index];
                final title = notification['title'];
                final time = notification['time'];

                return Card(
                  child: ListTile(
                    title: Text(title ?? 'No title'),
                    subtitle: Text('Time: $time'),
                  ),
                );
              },
            ),
    );
  }
}
