//import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
//import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/screens/start_screen.dart';

void main() async {
  //final cameras = await availableCameras();
  //final firstCamera = cameras.first;

  KakaoSdk.init(nativeAppKey: 'f45727db99556f6478557903fb593e95');

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StartScreen(),
    );
  }
}
