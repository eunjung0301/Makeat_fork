import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toonflix/screens/analysis_page.dart';
import 'package:toonflix/screens/calender_screen.dart';
import 'package:toonflix/screens/camera_screen.dart';
import 'package:toonflix/screens/profile_screen.dart';

void getImage({required ImageSource source}) async {
  final file = await ImagePicker().pickImage(
      source: source, maxWidth: 640, maxHeight: 280, imageQuality: 100 //0-100
      );
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '23-02-13',
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: (() {
                      showDialog(
                          context: context,
                          builder: (context) => const CalenderScreen());
                    }),
                    icon: const Icon(Icons.calendar_month_sharp, size: 40)),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileScreen()));
                    },
                    icon: const Icon(Icons.person_sharp, size: 40))
              ],
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black26,
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            RecordCircle(data: '단백질'),
            RecordCircle(data: '탄수화물'),
            RecordCircle(data: '지방'),
            RecordCircle(data: '나트륨'),
            RecordCircle(data: 'Kcal')
          ],
        ),
      ),
      const Text('오늘 하루 어떤 음식을 드셨나요? ',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          )),
      const SizedBox(height: 15),
      Column(
        children: [
          Container(
              width: 200,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(60)),
              child: const Image(image: AssetImage('images/test_food.jpg'))),
          Transform.scale(
            scale: 2,
            child: Transform.translate(
                offset: const Offset(60, -20),
                child: IconButton(
                  onPressed: () {
                    //getImage(source: ImageSource.camera);

                    showDialog(
                        context: context,
                        builder: (context) => const CameraScreen());

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const CameraScreen()));
                  },
                  icon: const Icon(
                    Icons.add_circle_rounded,
                    size: 30,
                  ),
                )),
          ),
        ],
      ),
      Row(
        children: [
          const Text('오늘의 기록  '),
          Container(
            height: 1.0,
            width: 200,
            color: Colors.black26,
          ),
        ],
      ),
      SizedBox(
          height: 60,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (context, index) {
              var image = [
                const Image(image: AssetImage('images/test_food.jpg')),
                const Image(image: AssetImage('images/test_food.jpg')),
                const Image(image: AssetImage('images/test_food.jpg')),
                const Image(image: AssetImage('images/test_food.jpg')),
                const Image(image: AssetImage('images/test_food.jpg')),
                const Image(image: AssetImage('images/test_food.jpg')),
                const Image(image: AssetImage('images/test_food.jpg')),
              ];

              var img = image[index];
              return img;
            },
            separatorBuilder: (context, index) => const SizedBox(
              width: 20,
            ),
          )),
    ]);
  }
}

class RecordCircle extends StatelessWidget {
  final String data;

  const RecordCircle({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(data,
            style: const TextStyle(
              fontSize: 20,
            )),
        const Icon(Icons.pie_chart_rounded, size: 70)
      ],
    );
  }
}
