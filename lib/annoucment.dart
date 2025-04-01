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

// import 'dart:io';
// // import 'package:audioplayers/audioplayers.dart';
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

// // final audioPlayer =AudioPlayer();

//   stt.SpeechToText _speech = stt.SpeechToText();
//   bool _isListening = false;
//   File? pickedfile;

//   FlutterTts _flutterTts = FlutterTts();

//   String selectedLanguage = "en"; // Default language set to English

//   // Function to start the microphone and record the voice message
//   void _startRecording() async {
//     var status = await Permission.microphone.request();
//     if (status.isGranted) {
//       bool available = await _speech.initialize(
//         onStatus: (status) => print('Status: $status'),
//         onError: (error) => print('Error: $error'),
//       );

//       if (available) {
//         // Handle language based on the selected language
//         if (selectedLanguage == "en") {
//           await _speech.listen(
//             localeId: 'en_US',
//             onResult: (result) {
//               setState(() {
//                 messageController.text = result.recognizedWords;
//               });
//             },
//           );
//         } else if (selectedLanguage == "ml") {
//           await _speech.listen(
//             localeId: 'ml_IN',
//             onResult: (result) {
//               setState(() {
//                 messageController.text = result.recognizedWords;
//               });
//             },
//           );
//         }

//         setState(() => _isListening = true);
//       } else {
//         print("Speech recognition not available");
//       }
//     } else {
//       print("Microphone permission denied");
//     }
//   }

//   // Function to stop recording
//   void _stopRecording() {
//     setState(() => _isListening = false);
//     _speech.stop();
//   }

//   // Function to convert text to speech
//   void _speakMessage() async {
//     String message = messageController.text;
//     if (message.isNotEmpty) {
//       // Set the TTS language based on selected language
//       if (selectedLanguage == "en") {
//         await _flutterTts.setLanguage("en_US"); // English
//       } else if (selectedLanguage == "ml") {
//         await _flutterTts.setLanguage("ml_IN"); // Malayalam
//       }
//       await _flutterTts.speak(message);
//     } else {
//       print("Message is empty, cannot convert to speech");
//     }
//   }

//   // Function to pick a file (optional feature)
//   void _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//     if (result != null) {
//       pickedfile = File(result.files.single.path!);
//       setState(() {});
//     } else {
//       // User canceled the picker
//     }
//   }

//   // Function to pick time
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

//   @override
//   void dispose() {
//     _multiDropDownController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//   }

//   // Function to handle the submit button click
//   void _handleSubmit() async {
//     String message = messageController.text;

//     if (message.isNotEmpty) {
//       // If the message is a text message, convert to speech and play it
//       await _flutterTts.speak(message);

//       // Simulate sending the message (You can replace this with your logic to send it to a server)
//       print("Sending message: $message");
//     } else if (pickedfile != null) {
//       // If a file (audio) was picked, we will simulate sending the audio file
//       print("Sending audio file: ${pickedfile!.path}");

//       // Add your file sending logic here
//       // Example: Upload the file to a server
//     } else {
//       print("No message or file to send.");
//     }
//     setState(() {
//       // Clear the controllers
//       titleController.clear();
//       messageController.clear();

//       // Reset the dropdown selection
//       _multiDropDownController.clearDropDown();

//       // Reset the time picker
//       selectedTime = TimeOfDay.now();

//       // Reset file picker
//       pickedfile = null;

//       // Reset listening state
//       _isListening = false;
//     });
//   }

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
//             DropdownButton<String>(
//               value: selectedLanguage,
//               onChanged: (String? newValue) {
//                 setState(() {
//                   selectedLanguage = newValue!;
//                 });
//               },
//               items: <String>['en', 'ml']
//                   .map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value == 'en' ? 'English' : 'Malayalam'),
//                 );
//               }).toList(),
//             ),
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
//                         onPressed: _isListening ? _stopRecording : _startRecording,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: _isListening
//                               ? Colors.red // Change to red when recording
//                               : Color.fromARGB(255, 180, 213, 240),
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                         ),
//                         child: Icon(_isListening ? Icons.stop : Icons.mic),
//                       ),
//                       Positioned(
//                         bottom: 5,
//                         right: 5,
//                         child: GestureDetector(
//                           onTap: _pickFile,
//                           child: Container(
//                             height: 40,
//                             width: 55,
//                             decoration: BoxDecoration(color: Colors.green),
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
//             if (pickedfile != null) Text('File name: ${pickedfile!.path}'),
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
//             // SizedBox(height: 16),

//             Spacer(),
//             Center(
//               child: ElevatedButton(
//                 onPressed: _handleSubmit, // Submit button logic
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
import 'package:announcement/api/announcmentapi.dart';
import 'package:announcement/previous.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart'; // Import audioplayers package
import 'package:flutter_sound/flutter_sound.dart';

class AnnouncementPage extends StatefulWidget {
  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  TimeOfDay selectedTime = TimeOfDay.now();
  MultiValueDropDownController _multiDropDownController =
      MultiValueDropDownController();

  final List<DropDownValueModel> departmentOptions = [
    DropDownValueModel(name: "All", value: "All"),
    DropDownValueModel(name: "BA History", value: "BA History"),
    DropDownValueModel(name: "BA English", value: "BA English"),
    DropDownValueModel(
        name: "BSc Computer Science", value: "BSc Computer Science"),
    DropDownValueModel(name: "BSc Chemistry", value: "BSc Chemistry"),
    DropDownValueModel(name: "BSc Mathematics", value: "BSc Mathematics"),
    DropDownValueModel(name: "BSc Botany", value: "BSc Botany"),
    DropDownValueModel(name: "BSc Home Science", value: "BSc Home Science"),
    DropDownValueModel(
        name: "Bcom Computer Application", value: "Bcom Computer Application"),
    DropDownValueModel(name: "Bcom Co-operation", value: "BSC Co-operation"),
  ];

  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  File? pickedfile;

  FlutterTts _flutterTts = FlutterTts();
  AudioPlayer _audioPlayer = AudioPlayer(); // Initialize AudioPlayer

  String selectedLanguage = "en"; // Default language set to English
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  bool _isRecording = false;
  bool _isPlaying = false;
  String? _filePath;
  DateTime? selecteddate;

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
  // void _speakMessage() async {
  //   String message = messageController.text;
  //   if (message.isNotEmpty) {
  //     // Set the TTS language based on selected language
  //     if (selectedLanguage == "en") {
  //       await _flutterTts.setLanguage("en_US"); // English
  //     } else if (selectedLanguage == "ml") {
  //       await _flutterTts.setLanguage("ml_IN"); // Malayalam
  //     }
  //     await _flutterTts.speak(message);
  //   } else {
  //     print("Message is empty, cannot convert to speech");
  //   }
  // }

  // Function to pick a file (optional feature)
  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'png', 'jpg'],
    );
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

  // Function to handle file play
// void _playRecordedFile() async {
//   if (pickedfile != null) {
//     // Create an AudioSource from the local file path
//     final audioSource = DeviceFileSource(pickedfile!.path);

//     // Play the audio
//     await _audioPlayer.play(audioSource);
//     print("Audio is playing...");
//   } else {
//     print("No file to play");
//   }
// }

  @override
  void dispose() {
    _multiDropDownController.dispose();
    _audioPlayer.dispose(); // Dispose the player when done
    _recorder?.closeRecorder(); // Null check added
    _player?.closePlayer(); // Null check added
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _recorder = FlutterSoundRecorder();
    _player = FlutterSoundPlayer();
    openRecorder();
    openPlayer();
  }

  // Function to handle the submit button click
  void _handleSubmit() async {
    String message = messageController.text;
    List<String> dep = [];
    print('rrrrrrrrrrrrrr');
    _multiDropDownController.dropDownValueList?.forEach((value) {
      print(value.name);
      dep.add(value.name);
      print(dep.toString());
    });
    if (message.isNotEmpty) {
      // If the message is a text message, convert to speech and play it
      // await _flutterTts.speak(message);
      print('eeeeeeeeeeeeeeeeeeeeeeeeeee');
      await submitAnnouncement(
          context,
          selecteddate!.toIso8601String(),
          messageController.text,
          pickedfile ?? null,
          _filePath ?? null,
          dep.join(", "),
          '${selectedTime.hour}:${selectedTime.minute}:00');

      // Simulate sending the message (You can replace this with your logic to send it to a server)
      print("Sending message: $message");
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

  //

  // Open recorder
  Future<void> openRecorder() async {
    await _recorder?.openRecorder(); // Use null-aware operator
  }

  // Open player
  Future<void> openPlayer() async {
    await _player?.openPlayer(); // Use null-aware operator
  }

  // Toggle recording (start/stop)
  Future<void> toggleRecording() async {
    if (_isRecording) {
      await stopRecording();
    } else {
      await startRecording();
    }
  }

  Future<String> getAudioFilePath() async {
    // Get the app's document directory to store the file
    final directory = await getApplicationDocumentsDirectory();
    String filePath =
        '${directory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.wav';
    return filePath;
  }

  // Start recording
  Future<void> startRecording() async {
    String filePath = await getAudioFilePath(); // Get a valid file path

    try {
      await _recorder?.startRecorder(
        toFile: filePath, // Save to the correct file path
        codec: Codec.pcm16WAV,
      );
      setState(() {
        _isRecording = true;
        _filePath = filePath; // Save the file path
      });
    } catch (e) {
      print("Error while starting the recording: $e");
    }
  }

  // Stop recording
  Future<void> stopRecording() async {
    if (_isRecording) {
      await _recorder?.stopRecorder();
      setState(() {
        _isRecording = false;
      });
      print("Recording stopped and saved to $_filePath");
    }
  }

  // Play or pause the recorded audio
  Future<void> togglePlaying() async {
    if (_isPlaying) {
      await stopPlaying();
    } else {
      await startPlaying();
    }
  }

  // Start playing the recorded audio
  Future<void> startPlaying() async {
    if (_filePath != null) {
      try {
        await _player?.startPlayer(
          fromURI: _filePath,
          codec: Codec.aacADTS,
          whenFinished: () {
            setState(() {
              _isPlaying = false;
            });
          },
        );
        setState(() {
          _isPlaying = true;
        });
      } catch (e) {
        print("Error while playing the audio: $e");
      }
    }
  }

  // Stop playing the recorded audio
  Future<void> stopPlaying() async {
    if (_isPlaying) {
      await _player?.stopPlayer();
      setState(() {
        _isPlaying = false;
      });
      print("Audio stopped playing");
    }
  }

  //

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
              MaterialPageRoute(builder: (context) => PreviousPage()),
            ),
            child: Text(
              "Previous",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        selecteddate = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            initialDate: DateTime.now() ,
                            lastDate: DateTime.now().add(Duration(days: 100)));
                      },
                      child: Text('Pick Date'))
                ],
              ),
              SizedBox(height: 16),
              Text("Message:"),
              // DropdownButton<String>(
              //   value: selectedLanguage,
              //   onChanged: (String? newValue) {
              //     setState(() {
              //       selectedLanguage = newValue!;
              //     });
              //   },
              //   items: <String>['en', 'ml']
              //       .map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value == 'en' ? 'English' : 'Malayalam'),
              //     );
              //   }).toList(),
              // ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: TextField(
                        controller: messageController,
                        maxLines: null,
                        expands: true,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
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
                          onPressed:
                              _isListening ? _stopRecording : _startRecording,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isListening
                                ? Colors.red // Change to red when recording
                                : Color.fromARGB(255, 180, 213, 240),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
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
                              child: Icon(Icons.add,
                                  size: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              if (pickedfile != null)
                Text('Selected file: ${pickedfile!.path.split('/').last}'),
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

              SizedBox(height: 16),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: toggleRecording,
                      child: Icon(
                          _isRecording ? Icons.mic : Icons.mic_off_outlined),
                    ),
                    SizedBox(height: 20),
                    // Only show the Play button if audio exists (i.e., _filePath is not null)
                    if (_filePath != null)
                      ElevatedButton(
                        onPressed: togglePlaying,
                        child:
                            Icon(!_isPlaying ? Icons.play_arrow : Icons.pause),
                      ),
                  ],
                ),
              ),
              // Spacer(),
              SizedBox(
                height: 100,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: _handleSubmit, // Submit button logic
                  child: Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 250, 248, 248),
                    backgroundColor: const Color.fromARGB(255, 70, 70, 70),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
