import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      'https://webtoon-crawler.nomadcoders.workers.dev';
  static const String today = "today";

  // api 에 요청 call , make a request, fetch our API 다 같은말
  // http 패키지 설치해야 함

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url); // 서버 메모리나 유저 네트워크 때문에 늦어질  수 있음
    // 그래서 응답 반환을 기다려야 함 - 비동기 처리
    // 위의 함수처럼 async 와 await 을 입력하면 됨

    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);

      for (var webtoon in webtoons) {
        final toon = WebtoonModel.fromjson(webtoon);
        webtoonInstances.add(toon);
      }

      return webtoonInstances;
    }
    throw Error();
  }

  // 반환한 json 을 콘솔에프린트
}
