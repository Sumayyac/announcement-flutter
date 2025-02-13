import 'package:announcement/api/loginapi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:announcement/api/getAnnouncements.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

class PreviousPage extends StatefulWidget {
  const PreviousPage({super.key});

  @override
  State<PreviousPage> createState() => _PreviousPageState();
}

class _PreviousPageState extends State<PreviousPage> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  List<Map<String, dynamic>> announcements = [];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer(); // Initialize the audio player
    fetchAnnouncements();
  }

  // Fetch announcements from the server or API
  void fetchAnnouncements() async {
    try {
      List<Map<String, dynamic>> fetchedAnnouncements = await getAnnouncementapi();
      setState(() {
        announcements = fetchedAnnouncements;
        print('Fetched Announcements: $announcements');
      });
    } catch (e) {
      print('Error fetching announcements: $e');
    }
  }

  // Play or stop audio
  Future<void> startPlaying(String audioUrl) async {
    try {
      await _audioPlayer.setUrl(audioUrl);
      await _audioPlayer.play();
      setState(() {
        _isPlaying = true;
      });
    } catch (e) {
      print("Error while playing audio: $e");
    }
  }

  // Stop playing audio
  Future<void> stopPlaying() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();  // Dispose of the audio player when done
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previous Messages'),
        backgroundColor: const Color.fromARGB(255, 70, 70, 70),
      ),
      body: announcements.isEmpty
          ? Center(child: CircularProgressIndicator())  // Show a loading indicator while fetching data
          : ListView.builder(
              itemCount: announcements.length,
              itemBuilder: (context, index) {
                final announcement = announcements[index];
                String? audioPath = '$baseUrl/static/audio_uploads/${announcement['audio']}';
                String? pdfPath = '$baseUrl/static/uploads/${announcement['file']}';
                String? description = announcement['description'];
                String? title = announcement['title'];
print(audioPath);
                return Card(
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title ?? 'No Title',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(description ?? 'No Description', style: TextStyle(fontSize: 14)),
                        SizedBox(height: 8),
                        if (pdfPath != null && pdfPath.isNotEmpty)
                        InkWell(
                          onTap: (){
 Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PDFViewerPage(pdfPath),
                                ),
                
                              );
                          },
                          child: Icon(Icons.file_present_rounded,color: Colors.red,size: 60,)),
                        
                        SizedBox(height: 8),
                        if (audioPath != null && audioPath.isNotEmpty)
                          ElevatedButton(
                            onPressed: () {
                              if (_isPlaying) {
                                stopPlaying();
                              } else {
                                startPlaying(audioPath);
                              }
                            },
                            child: Text(_isPlaying ? 'Stop Audio' : 'Play Audio'),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}







class PDFViewerPage extends StatefulWidget {
  final String url;

  PDFViewerPage(this.url);

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  String filePath='';

  @override
  void initState() {
    super.initState();
    downloadPDF(widget.url);  // Download the PDF when the page is created
  }

  // Download the PDF from the network
  Future<void> downloadPDF(String url) async {
    try {
      Dio dio = Dio();
      var dir = await getApplicationDocumentsDirectory(); // Get a directory for storage
      filePath = '${dir.path}/downloaded_file.pdf'; // Save the file as a PDF in the app's directory

      await dio.download(url, filePath); // Download the PDF
      setState(() {}); // Refresh the UI after downloading the PDF
    } catch (e) {
      print("Error downloading PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: filePath.isEmpty
          ? Center(child: CircularProgressIndicator()) // Show loading indicator while downloading
          : PDFView(
              filePath: filePath, // Path to the downloaded file
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: false,
              backgroundColor: Colors.grey,
              onError: (error) {
                print(error.toString());
              },
              onPageError: (page, error) {
                print('$page: ${error.toString()}');
              },
            ),
    );
  }
}
