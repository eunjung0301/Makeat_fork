import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('프로필'),
          centerTitle: true,
          elevation: 2,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        backgroundColor: Colors.white,
        body: Center(
            child: Column(children: [
          Row(
            children: [
              const Icon(Icons.person_pin),
              Column(
                children: const [
                  Text('하성민'),
                  Text('x22z@naver.com'),
                ],
              )
            ],
          ),
          Column(
            children: [
              Row(
                children: const [Text('나이 :'), Text('19')],
              ),
              Row(
                children: const [Text('키 :'), Text('181')],
              ),
              Row(
                children: const [Text('몸무게 :'), Text('80')],
              ),
              Row(
                children: const [Text('BMI :'), Text('100')],
              ),
              Row(
                children: const [Text('목표 :'), Text('벌크업')],
              ),
              Row(
                children: const [Text('권장 일일 칼로리 :'), Text('2600 kcal')],
              ),
              TextButton(onPressed: (() => {}), child: const Text('수정하기'))
            ],
          ),
          OutlinedButton(onPressed: (() => {}), child: const Text('문의하기')),
          OutlinedButton(onPressed: (() => {}), child: const Text('개인정보보호 약관')),
          TextButton(onPressed: (() => {}), child: const Text('로그아웃')),
          TextButton(onPressed: (() => {}), child: const Text('회원탈퇴')),
        ])));
  }
}
