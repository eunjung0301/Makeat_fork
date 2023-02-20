class KakaoModel {
  final String title, thumbnail, id;

  KakaoModel.fromjson(Map<String, dynamic> json)
      : title = json['title'],
        thumbnail = json['thumb'],
        id = json['id'];
}
