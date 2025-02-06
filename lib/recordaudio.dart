import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class AudioRecordingPage extends StatefulWidget {
  @override
  _AudioRecordingPageState createState() => _AudioRecordingPageState();
}

class _AudioRecordingPageState extends State<AudioRecordingPage> {
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  bool _isRecording = false;
  bool _isPlaying = false;
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _player = FlutterSoundPlayer();
    openRecorder();
    openPlayer();
  }

  // Open recorder
  Future<void> openRecorder() async {
    await _recorder?.openRecorder(); // Use null-aware operator
  }

  // Open player
  Future<void> openPlayer() async {
    await _player?.openPlayer(); // Use null-aware operator
  }

  // Start recording
  Future<void> startRecording() async {
    if (!_isRecording) {
      _filePath = 'audio_${DateTime.now().millisecondsSinceEpoch}.aac'; // Set file path
      try {
        await _recorder?.startRecorder(
          toFile: _filePath,
          codec: Codec.aacADTS,
        );
        setState(() {
          _isRecording = true;
        });
      } catch (e) {
        print("Error while starting the recording: $e");
      }
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

  // Start playing the recorded audio
  Future<void> startPlaying() async {
    if (!_isPlaying && _filePath != null) {
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
    } else {
      print("File path is null or already playing.");
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

  @override
  void dispose() {
    super.dispose();
    _recorder?.closeRecorder(); // Null check added
    _player?.closePlayer(); // Null check added
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Recording and Playback'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: startRecording,
              child: Text(_isRecording ? 'Recording...' : 'Start Recording'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: stopRecording,
              child: Text('Stop Recording'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: startPlaying,
              child: Text(_isPlaying ? 'Playing...' : 'Play Recorded Audio'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: stopPlaying,
              child: Text('Stop Playing'),
            ),
          ],
        ),
      ),
    );
  }
}
