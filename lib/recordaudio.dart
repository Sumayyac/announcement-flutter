import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerWidget extends StatefulWidget {
  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  Future<void> startPlaying(String audioUrl) async {
    try {
      await _audioPlayer.setUrl(audioUrl);
      _audioPlayer.play();
      setState(() {
        _isPlaying = true;
      });
    } catch (e) {
      print("Error while playing audio: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();  // Don't forget to dispose the player
  }

  @override
  Widget build(BuildContext context) {
    String audioUrl = 'http://192.168.1.12:8000/static/audio_1739338928561.wav';

    return Scaffold(
      appBar: AppBar(
        title: Text("Audio Player"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => startPlaying(audioUrl),
          child: Text(_isPlaying ? 'Stop Audio' : 'Play Audio'),
        ),
      ),
    );
  }
}
