import 'package:flutter/material.dart';
import 'package:toonflix/screens/Day_detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String tittle, thumb, id;
  const Webtoon({
    super.key,
    required this.tittle,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //GestureDetector : 사용자의 동작 감지
      onTap: () {
        // route : DetailScreen 같은 StatelessWidget을 애니메이션 효과로 감사써 스크린처럼 보이도록 하는 것
        // materialpageroute : 애니메이션 효과 이용해서 유저가 다른 페이지로 왔다고 느끼게 해주는 기능 > 실제론 또 다른 statelesswidget을 렌더했을 뿐
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DayDetailScreen(tittle: tittle, thumb: thumb, id: id),
            // 애니메이션 효과 옵션 ( 옆에서가 아닌 아래에선 올라오게 )
            fullscreenDialog: true,
          ),
        );
      },

      child: Column(
        children: [
          Text(
            tittle,
            style: const TextStyle(fontSize: 15),
          ),
          Hero(
            // 한 화면에 위젯의 id를 태그로 가진 hero 만듦
            tag: id,
            child: Stack(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.network(
                    thumb,
                    fit: BoxFit.cover,
                  ), // network :  URL 필요)
                ),
                Container(
                  width: 150,
                  height: 150,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text(
                      '7:30',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 1.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
