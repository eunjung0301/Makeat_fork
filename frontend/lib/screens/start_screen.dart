import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:toonflix/screens/getinfo_screen.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:toonflix/screens/home_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  //final Future<List<KakaoModel>> tokens = ApiService.getKakaoToken();

  void _get_user_info() async {
    try {
      User user = await UserApi.instance.me();

      // print('사용자 정보 요청 성공'
      //     '\n전부 : $user'
      //     '\n회원번호: ${user.id}'
      //     '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');

      print('여기까지 잘됨');
      final url = Uri.parse('http://192.168.45.46:8080/users/login/${user.id}');
      final response = await http.get(url);
      print('여기까지도 잦ㄹ됨');

      print(response.body);
      print('Response status: ----------------- ${response.statusCode}');
      print('Response body: $response');

      //var response = await httpClient.get(Uri.parse('http://192.168.45.46:8080/users/login/${user.id}'));

    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }

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
              onPressed: (() async {
                // launchUrl(
                //   Uri.parse(
                //       'https://kauth.kakao.com/oauth/authorize?client_id=c9b86f5811b4189e82cc4d3bd36f74d1&redirect_uri=http://192.168.45.46:8080/users/kakao&response_type=code'),
                // ),
                if (await isKakaoTalkInstalled()) {
                  try {
                    await UserApi.instance.loginWithKakaoTalk();
                    print('카카오톡으로 로그인 성공 - 1');

                    User user = await UserApi.instance.me();
                    final url = Uri.parse(
                        'http://192.168.45.46:8080/users/login/${user.id}');
                    final response = await http.get(url);
                    if (response.body == 'true') {
                      Navigator.pop(context);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(userId: user.id)));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  GetInfoScreen(userId: user.id)));
                    }

                    //_get_user_info();
                  } catch (error) {
                    print('카카오톡으로 로그인 실패 $error');
                    // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                    try {
                      await UserApi.instance.loginWithKakaoAccount();
                      print('카카오계정으로 로그인 성공 - 2');

                      User user = await UserApi.instance.me();
                      final url = Uri.parse(
                          'http://192.168.45.46:8080/users/login/${user.id}');
                      final response = await http.get(url);
                      if (response.body == 'true') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen(userId: user.id)));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    GetInfoScreen(userId: user.id)));
                      }
                    } catch (error) {
                      print('카카오계정으로 로그인 실패 $error');
                    }
                  }
                } else {
                  try {
                    await UserApi.instance.loginWithKakaoAccount();
                    print('카카오계정으로 로그인 성공 - 3');

                    User user = await UserApi.instance.me();
                    final url = Uri.parse(
                        'http://192.168.45.46:8080/users/login/${user.id}');
                    final response = await http.get(url);
                    if (response.body == 'true') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(userId: user.id)));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  GetInfoScreen(userId: user.id)));
                    }

                    //_get_user_info();
                  } catch (error) {
                    print('카카오계정으로 로그인 실패 $error');
                  }
                }
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const GetInfoScreen()));
              }),
              child: Image.asset('images/kakao_login_medium_wide.png')),
        ])));
  }
}
