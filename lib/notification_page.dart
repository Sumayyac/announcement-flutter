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
        backgroundColor: const Color.fromARGB(255, 70, 70, 70),
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
                final status = notification['status'];

                // Set the color based on the status
                Color statusColor = status == 'accepted' ? Colors.green : Colors.red;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: statusColor, width: 2),
                  ),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    title: Text(
                      title ?? 'No title',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                    subtitle: Text(
                      'Time: $time',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    trailing: Icon(
                      status == 'accepted' ? Icons.check_circle : Icons.cancel,
                      color: statusColor,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
