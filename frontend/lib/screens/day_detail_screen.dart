import 'package:flutter/material.dart';

class DayDetailScreen extends StatelessWidget {
  final String tittle, thumb, id;

  const DayDetailScreen({
    super.key,
    required this.tittle,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          '2023/01/28',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(children: [
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: id,
              child: Container(
                width: 150,
                height: 150,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: [
                  //   BoxShadow(
                  //     blurRadius: 10,
                  //     offset: const Offset(10, 10),
                  //     color: Colors.black.withOpacity(0.3),
                  //   )
                  // ],
                ),
                child: Image.network(
                  thumb,
                  fit: BoxFit.cover,
                ), // network :  URL 필요)
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          '''
          총 섭취 칼로리 : 00kcal
          단백질 : 00g
          탄수화물 : 00g
          지방 : 00g
          나트륨 : 00mg

          한줄평 : 어쩌구저쩌구
          ''',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ]),
    );
  }
}
