import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/kakao_model.dart';

class ApiService {
  static const String baseUrl =
      'https://webtoon-crawler.nomadcoders.workers.dev'; // 우리가 접근할 링크 - 바꿔야 함
  static const String users = "users";

  // api 에 요청 call , make a request, fetch our API 다 같은말
  // http 패키지 설치해야 함

  static Future<List<KakaoModel>> getKakaoToken() async {
    List<KakaoModel> kakaoinstances = [];
    final url = Uri.parse('$baseUrl/$users');
    final response = await http.get(url); // 서버 메모리나 유저 네트워크 때문에 늦어질  수 있음
    // 그래서 응답 반환을 기다려야 함 - 비동기 처리
    // 위의 함수처럼 async 와 await 을 입력하면 됨

    if (response.statusCode == 200) {
      final List<dynamic> tokens = jsonDecode(response.body);

      for (var token in tokens) {
        final toon = KakaoModel.fromjson(token);
        kakaoinstances.add(toon);
      }

      return kakaoinstances;
    }
    throw Error();
  }

  // 반환한 json 을 콘솔에프린트
}
