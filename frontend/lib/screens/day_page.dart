import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/Day_widget.dart';

class DayPage extends StatelessWidget {
  DayPage({super.key});

// 할일1
  // 리스트를 백엔드에서 가져온 데이터로 변경
  // webtoon thumb> 찍은 사진, tittle>날짜로 생각하고 짬

// 할일2
  // 비율별로 크기 조정

// 할일4
  // 만약 날짜 같으면 표시ㄴ if문 자기

// 할일5
  // 날짜 이동
  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "식단기록",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month_outlined),
            iconSize: 30,
            onPressed: () => _showDialog(context),
          ),
        ],
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),

                // expanded : 화면의 남는 공간을 차지하는 위젯 > listVeiw의 높이 제한> 오류 해결
                Expanded(child: makeList(snapshot)),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  GridView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 5,
        crossAxisSpacing: 10,
        childAspectRatio: 1 / 1.3,
      ),
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),

      // itmbuilder: 최적화. 유저가 보고 있는 아이템만 build
      itemBuilder: (context, index) {
        // print(index);
        var webtoon = snapshot.data![index];

        // ListView.seperated 내의 component, 위젯은 분리 (webtoon_widget)
        return Webtoon(
          tittle: webtoon.title,
          thumb: webtoon.thumbnail,
          id: webtoon.id,
        );
      },
    );
  }
}

// 날짜 입력 팝업
// API에 있는 showDialog 함수와 이름이 같아서 밑줄(_) 접두사(private 함수)
void _showDialog(BuildContext context) {
  // 경고창을 보여주는 가장 흔한 방법.
  showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('이동할 날짜를 입력하세요.'),
          content: TextFormField(
            decoration: const InputDecoration(
              // icon: Icon(Icons.)
              hintText: 'ex) 20230221',
            ),
          ),
          // content: Text(' 항목을 선택했습니다.'),
          actions: [
            Center(
              child: TextButton(
                  child: const Text('확인'),
                  onPressed: () => Navigator.pop(context)),
            )
          ],
        );
      });
}
