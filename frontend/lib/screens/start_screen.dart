import 'package:flutter/material.dart';
import 'package:toonflix/screens/getinfo_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  //final Future<List<KakaoModel>> tokens = ApiService.getKakaoToken();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // const SizedBox(
          //   height: 150,
          // ),
          SizedBox(width: 300, child: Image.asset('images/logo_title.png')),
          const SizedBox(
            height: 100,
          ),
          TextButton(
              onPressed: (() => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GetInfoScreen()))
                  }),
              child: Image.asset('images/kakao_login_medium_wide.png')),
        ])));
  }
}
