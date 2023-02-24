import 'package:flutter/material.dart';
import 'package:toonflix/models/kakao_model.dart';
import 'package:toonflix/screens/day_page.dart';
import 'package:toonflix/screens/home_page.dart';
import 'package:toonflix/screens/month_page.dart';

class HomeScreen extends StatelessWidget {
  final int userId;
  const HomeScreen({super.key, required this.userId});

  //final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons(); 나중에 API 받을 때 수정

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyStatefulWidget(),
    );
  }
}

/// Global variables
/// * [GlobalKey<NavigatorState>]

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  /// Global variables
  /// * [GlobalKey<NavigatorState>]

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    DayPage(),
    const MonthPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text('Makeat'),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            //버튼을 둥글게 처리
            borderRadius: BorderRadius.circular(0),
            side: const BorderSide(color: Colors.white)),

        foregroundColor: Colors.black,
        title: SizedBox(width: 40, child: Image.asset('images/logo.png')),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_camera_outlined),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_size_select_actual_outlined),
            label: 'Day',
            backgroundColor: Colors.green,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.calendar_month_outlined),
          //   label: 'Month',
          //   backgroundColor: Colors.purple,
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

// Scaffold(
//   backgroundColor: Colors.white,
//   appBar: AppBar(
//     centerTitle: true,
//     elevation: 2,
//     backgroundColor: Colors.white,
//     foregroundColor: Colors.black,
//     title: SizedBox(width: 40, child: Image.asset('images/logo.png')),
//   ),
// body: FutureBuilder(
//   //future: webtoons, 받은 api 를 쓸때
//   builder: (context, snapshot) {
//     if (snapshot.hasData) {
//       return Column(
//         children: [
//           const SizedBox(
//             height: 50,
//           ),
//           Expanded(child: makeList(snapshot)),
//         ],
//       );
//     }
//     return const Center(child: CircularProgressIndicator());
//   },
// ),
// );

ListView makeList(AsyncSnapshot<List<KakaoModel>> snapshot) {
  return ListView.separated(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    scrollDirection: Axis.horizontal,
    itemCount: snapshot.data!.length,
    itemBuilder: (context, index) {
      print(index);
      var webtoon = snapshot.data![index];
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      offset: const Offset(0, 0),
                      color: Colors.black.withOpacity(0.5))
                ]),
            width: 250,
            clipBehavior: Clip.hardEdge,
            child: Image.network(webtoon.thumbnail),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(webtoon.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              )),
        ],
      );
    },
    separatorBuilder: (context, index) => const SizedBox(width: 40),
  );
}
