import 'package:flutter/material.dart';

class MonthPage extends StatelessWidget {
  const MonthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: const [
                Text('date'),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(Icons.arrow_drop_up),
                Icon(Icons.arrow_drop_down),
              ],
            ),
            Column(
              children: const [
                Icon(Icons.circle_outlined, size: 100),
              ],
            ),
          ],
        ),
      ),
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360, minHeight: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Text(selectionColor: Colors.red, 'Sun'),
            Text('Mon'),
            Text('Tue'),
            Text('Wed'),
            Text('Thu'),
            Text('Fri'),
            Text('Sat'),
          ],
        ),
      ),
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700, minHeight: 400),
        child: Wrap(
          children: [
            for (num i = 1; i < 32; i++)
              const Padding(
                padding: EdgeInsets.fromLTRB(
                    1, 5, 1, 5), //성민휴대폰 화면에 아이콘비율 맞춰놓은거 확인(한줄에 7개씩 아이콘 띄우기 조절)
                child: Icon(
                  Icons.circle,
                  size: 48,
                  color: Colors.amber,
                ),
              ),
          ],
        ),
      )
    ]);
  }
}
