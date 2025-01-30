// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:dropdown_textfield/dropdown_textfield.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'previous.dart';
// import 'package:permission_handler/permission_handler.dart';

// class AnnouncementPage extends StatefulWidget {
//   @override
//   _AnnouncementPageState createState() => _AnnouncementPageState();
// }

// class _AnnouncementPageState extends State<AnnouncementPage> {
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController messageController = TextEditingController();

//   TimeOfDay selectedTime = TimeOfDay.now();
//   MultiValueDropDownController _multiDropDownController = MultiValueDropDownController();

//   final List<DropDownValueModel> departmentOptions = [
//     DropDownValueModel(name: "All", value: "All"),
//     DropDownValueModel(name: "BSC CS", value: "BSC CS"),
//     DropDownValueModel(name: "BA History", value: "BA History"),
//   ];

//   stt.SpeechToText _speech = stt.SpeechToText();
//   bool _isListening = false;
//   File? pickedfile;

//   FlutterTts _flutterTts = FlutterTts();

//   void _pickTime() async {
//     TimeOfDay? time = await showTimePicker(
//       context: context,
//       initialTime: selectedTime,
//     );
//     if (time != null) {
//       setState(() {
//         selectedTime = time;
//       });
//     }
//   }

//   void _speakMessage() async {
//     String message = messageController.text;
//     if (message.isNotEmpty) {
//       await _flutterTts.speak(message);
//     } else {
//       print("Message is empty, cannot convert to speech");
//     }
//   }


// void _startListening() async {
//   var status = await Permission.microphone.request();
//   if (status.isGranted) {
//     bool available = await _speech.initialize(
//       onStatus: (status) => print('Status: $status'),
//       onError: (error) => print('Error: $error'),
//     );

//     if (available) {
//       setState(() => _isListening = true);
//       _speech.listen(
//         onResult: (result) {
//           setState(() {
//             messageController.text = result.recognizedWords;
//           });
//         },
//       );
//     } else {
//       print("Speech recognition not available");
//     }
//   } else {
//     print("Microphone permission denied");
//   }
// }


//   void _stopListening() {
//     setState(() => _isListening = false);
//     _speech.stop();
//   }

//   @override
//   void dispose() {
//     _multiDropDownController.dispose();
//     super.dispose();
//   }
//   @override
// void initState() {
//   super.initState();
//   _speech = stt.SpeechToText();
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Announcement"),
//         foregroundColor: Colors.white,
//         backgroundColor: Color.fromARGB(255, 57, 57, 59),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           ElevatedButton(
//             onPressed: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Previouspage()),
//             ),
//             child: Text(
//               "Previous",
//               style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Text("Title:"),
//                 SizedBox(
//                   height: 40,
//                   width: 300,
//                   child: TextField(
//                     controller: titleController,
//                     decoration: InputDecoration(border: OutlineInputBorder()),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             Text("Message:"),
//             Row(
//               children: [
//                 Expanded(
//                   child: SizedBox(
//                     height: 100,
//                     child: TextField(
//                       controller: messageController,
//                       maxLines: null,
//                       expands: true,
//                       decoration: InputDecoration(border: OutlineInputBorder()),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 SizedBox(
//                   height: 100,
//                   width: 60,
//                   child: Stack(
                    
//                     children: [
//                       ElevatedButton(
//                         onPressed: _isListening ? _stopListening : _startListening,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: _isListening
//                               ? Colors.red // Change to red when recording
//                               : Color.fromARGB(255, 180, 213, 240),
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                         ),
//                         child: Icon(_isListening ? Icons.stop : Icons.mic),
//                       ),
//                       SizedBox(height: 30,),
//                       Positioned(
//                         bottom: 5,
//                         right: 5,
//                         child: GestureDetector(
//                           onTap: () async{


//                             FilePickerResult? result = await FilePicker.platform.pickFiles();
//                             if (result != null) {
//    pickedfile = File(result.files.single.path!);
//    setState(() {
     
//    });
// } else {
//   // User canceled the picker
// }

//                             // File addition logic
//                           },
                          
//                           child: Container(
//                             height: 40,width: 55,
//                             decoration: BoxDecoration(color: Colors.green, ),
//                             padding: EdgeInsets.all(4),
//                             child: Icon(Icons.add, size: 16, color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             if(pickedfile!=null)
//             Text('File name: ${pickedfile!.path}'),
//             DropDownTextField.multiSelection(
//               controller: _multiDropDownController,
//               dropDownList: departmentOptions,
//               textFieldDecoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: "Select Departments",
//               ),
//             ),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 Text("Time: ${selectedTime.format(context)}"),
//                 SizedBox(width: 10),
//                 ElevatedButton(
//                   onPressed: _pickTime,
//                   child: Text("Pick Time"),
//                 ),
//               ],
//             ),
//             Spacer(),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   print("Selected Departments: ${_multiDropDownController.dropDownValueList!.map((e) => e.name).toList()}");
//                 },
//                 child: Text("Submit"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color.fromARGB(255, 27, 108, 3),
//                   foregroundColor: Colors.black,
//                   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                   textStyle: TextStyle(fontSize: 20),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'previous.dart';
import 'package:permission_handler/permission_handler.dart';

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

  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  File? pickedfile;

  FlutterTts _flutterTts = FlutterTts();

  String selectedLanguage = "en"; // Default language set to English

  // Function to start the microphone and record the voice message
  void _startRecording() async {
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      bool available = await _speech.initialize(
        onStatus: (status) => print('Status: $status'),
        onError: (error) => print('Error: $error'),
      );

      if (available) {
        // Handle language based on the selected language
        if (selectedLanguage == "en") {
          await _speech.listen(
            localeId: 'en_US',
            onResult: (result) {
              setState(() {
                messageController.text = result.recognizedWords;
              });
            },
          );
        } else if (selectedLanguage == "ml") {
          await _speech.listen(
            localeId: 'ml_IN',
            onResult: (result) {
              setState(() {
                messageController.text = result.recognizedWords;
              });
            },
          );
        }

        setState(() => _isListening = true);
      } else {
        print("Speech recognition not available");
      }
    } else {
      print("Microphone permission denied");
    }
  }

  // Function to stop recording
  void _stopRecording() {
    setState(() => _isListening = false);
    _speech.stop();
  }

  // Function to convert text to speech
  void _speakMessage() async {
    String message = messageController.text;
    if (message.isNotEmpty) {
      // Set the TTS language based on selected language
      if (selectedLanguage == "en") {
        await _flutterTts.setLanguage("en_US"); // English
      } else if (selectedLanguage == "ml") {
        await _flutterTts.setLanguage("ml_IN"); // Malayalam
      }
      await _flutterTts.speak(message);
    } else {
      print("Message is empty, cannot convert to speech");
    }
  }

  // Function to pick a file (optional feature)
  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      pickedfile = File(result.files.single.path!);
      setState(() {});
    } else {
      // User canceled the picker
    }
  }

  // Function to pick time
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
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  // Function to handle the submit button click
  void _handleSubmit() async {
    String message = messageController.text;

    if (message.isNotEmpty) {
      // If the message is a text message, convert to speech and play it
      await _flutterTts.speak(message);

      // Simulate sending the message (You can replace this with your logic to send it to a server)
      print("Sending message: $message");
    } else if (pickedfile != null) {
      // If a file (audio) was picked, we will simulate sending the audio file
      print("Sending audio file: ${pickedfile!.path}");

      // Add your file sending logic here
      // Example: Upload the file to a server
    } else {
      print("No message or file to send.");
    }
    setState(() {
      // Clear the controllers
      titleController.clear();
      messageController.clear();

      // Reset the dropdown selection
      _multiDropDownController.clearDropDown();

      // Reset the time picker
      selectedTime = TimeOfDay.now();

      // Reset file picker
      pickedfile = null;

      // Reset listening state
      _isListening = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Announcement"),
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 57, 57, 59),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Previouspage()),
            ),
            child: Text(
              "Previous",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
                  width: 300,
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text("Message:"),
            DropdownButton<String>(
              value: selectedLanguage,
              onChanged: (String? newValue) {
                setState(() {
                  selectedLanguage = newValue!;
                });
              },
              items: <String>['en', 'ml']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value == 'en' ? 'English' : 'Malayalam'),
                );
              }).toList(),
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 100,
                    child: TextField(
                      controller: messageController,
                      maxLines: null,
                      expands: true,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  height: 100,
                  width: 60,
                  child: Stack(
                    children: [
                      ElevatedButton(
                        onPressed: _isListening ? _stopRecording : _startRecording,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isListening
                              ? Colors.red // Change to red when recording
                              : Color.fromARGB(255, 180, 213, 240),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Icon(_isListening ? Icons.stop : Icons.mic),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: _pickFile,
                          child: Container(
                            height: 40,
                            width: 55,
                            decoration: BoxDecoration(color: Colors.green),
                            padding: EdgeInsets.all(4),
                            child: Icon(Icons.add, size: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (pickedfile != null) Text('File name: ${pickedfile!.path}'),
            DropDownTextField.multiSelection(
              controller: _multiDropDownController,
              dropDownList: departmentOptions,
              textFieldDecoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Select Departments",
              ),
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
            // SizedBox(height: 16),
            
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: _handleSubmit, // Submit button logic
                child: Text("Submit"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 27, 108, 3),
                  foregroundColor: Colors.black,
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
