//import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
//import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/screens/start_screen.dart';

void main() async {
  //final cameras = await availableCameras();
  //final firstCamera = cameras.first;

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartScreen(),
    );
  }
}
