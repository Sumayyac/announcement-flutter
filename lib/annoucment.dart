import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'previous.dart';

class AnnouncementPage extends StatefulWidget {
  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  TimeOfDay selectedTime = TimeOfDay.now();
  MultiValueDropDownController _multiDropDownController = MultiValueDropDownController();

  final List<DropDownValueModel> departmentOptions = [
    DropDownValueModel(name: "All", value: "All"),
    DropDownValueModel(name: "BSC CS", value: "BSC CS"),
    DropDownValueModel(name: "BA History", value: "BA History"),
  ];

  void _pickTime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  @override
  void dispose() {
    _multiDropDownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Announcement"),
       foregroundColor: const Color.fromARGB(255, 250, 248, 248),
        backgroundColor: const Color.fromARGB(255, 57, 57, 59),

        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Navigate to the previous screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Previouspage()),
              );
            },
            child: Text(
              "Previous",
              style: TextStyle(
                color: const Color.fromARGB(255, 14, 14, 14),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Title:"),
                SizedBox(
                  height: 40,
                  width: 300, // Custom height and width
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text("Message:"),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 100,
                    child: TextField(
                      controller: messageController,
                      maxLines: null,
                      expands: true, // Makes the text field fill the height
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10), // Add space between the fields
                SizedBox(
                  height: 100,
                  width: 60, // Height and width of the button box
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Voice Button
                      ElevatedButton(
                        onPressed: () {
                          // Voice Button Logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 180, 213, 240),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Icon(Icons.mic),
                      ),
                      // Plus Icon
                      Positioned(
                        bottom: 5, // Position the plus icon at the bottom
                        right: 5,
                        child: GestureDetector(
                          onTap: () {
                            // File addition logic
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(4), // Padding inside the plus icon
                            child: Icon(
                              Icons.add,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            
            DropDownTextField.multiSelection(
              controller: _multiDropDownController,
              dropDownList: departmentOptions,
              
              textFieldDecoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Select Departments",
              ),
              // onChanged: () {
              //   // // Handle selection changes
              //   // print("Selected Departments: ${selectedValues.map((e) => e.name).toList()}");
              // },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text("Time: ${selectedTime.format(context)}"),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _pickTime,
                  child: Text("Pick Time"),
                ),
              ],
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Submit Button Logic
                  print("Selected Departments: ${_multiDropDownController.dropDownValueList!.map((e) => e.name).toList()}");
                },
                child: Text("Submit"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 27, 108, 3),
                  foregroundColor: Colors.black, // Button color
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
