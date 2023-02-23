import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/Analysis_widget.dart';
import 'package:http/http.dart' as http;

class AnaPage extends StatelessWidget {
  final Widget mPhoto;
  AnaPage({super.key, required this.mPhoto});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  Future<int> _uploadToSignedURL(
      {required Widget file, required String url}) async {
    http.Response response = await http.put(Uri.parse(url), body: file);
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 30,
          onPressed: () {},
        ),
        elevation: 2,
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "분석 결과",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: 400,
                height: 200,
                child: mPhoto //Image.asset('images/testimage.jpg'),
                ),
            Container(
              child: Text(
                '음식 목록',
                style: TextStyle(
                    color: Colors.black.withOpacity(0.9), fontSize: 25),
              ),
            ),
            Container(
              width: 400,
              height: 200,
              color: Colors.green,
              child: FutureBuilder(
                future: webtoons,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        // expanded : 화면의 남는 공간을 차지하는 위젯 > listVeiw의 높이 제한> 오류 해결
                        Expanded(child: foodList(snapshot)),
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              // ListView로 인식한 음식 목록
            ),
            Container(
              child: Column(
                children: [
                  const Text('총 칼로리: 329 kcal'),
                  Text(
                    '탄수화물 73g, 지방 0.3g, 단백질 6.3g',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 8,
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('취소'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('저장하기'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
//   FutureBuilder<Widget> showImage() {
//     return FutureBuilder(
//         future: mPhoto,
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
//           if (snapshot.hasData == false) {
//             return const CircularProgressIndicator();
//           }
//           //error가 발생하게 될 경우 반환하게 되는 부분
//           else if (snapshot.hasError) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'Error: ${snapshot.error}',
//                 style: const TextStyle(fontSize: 15),
//               ),
//             );
//           }
//           // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
//           else {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 snapshot.data,
//                 style: const TextStyle(fontSize: 15),
//               ),
//             );
//           }
//         });
//   }
// }

ListView foodList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
  return ListView.separated(
    itemCount: snapshot.data!.length,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    // itmbuilder: 최적화. 유저가 보고 있는 아이템만 build
    itemBuilder: (context, index) {
      print(index);
      var webtoon = snapshot.data![index];

      // ListView.seperated 내의 component, 위젯은 분리 (webtoon_widget)
      return Analysis(
        tittle: webtoon.title,
        thumb: webtoon.thumbnail,
        id: webtoon.id,
      );
    },
    separatorBuilder: (context, index) => const SizedBox(width: 40),
  );
}
