import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class GetInfoScreen extends StatefulWidget {
  final int userId;

  const GetInfoScreen({super.key, required this.userId});

  @override
  State<GetInfoScreen> createState() => _GetInfoScreenState();
}

class _GetInfoScreenState extends State<GetInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  final ageTextEditController = TextEditingController();
  final tallTextEditController = TextEditingController();
  final weightTextEditController = TextEditingController();
  final goalTextEditController = TextEditingController();

  @override
  void dispose() {
    ageTextEditController.dispose();
    tallTextEditController.dispose();
    weightTextEditController.dispose();
    goalTextEditController.dispose();

    super.dispose();
  }

  // 포스트 코드 작성하다가 말았음

  void _postRequest({
    required double age,
    String gender = 'M',
    required double tall,
    required double weight,
  }) async {
    Uri url = Uri.parse('http://192.168.45.46:8080/users/info/$widget.userId');
    double bmi = (weight / pow(tall / 100, 2));

    print(
      <String, String>{
        "age": '$age',
        "gender": gender,
        "height": '$tall',
        "weight": '$weight',
        'bmi': '$bmi',
      },
    );

    http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          <String, String>{
            "age": '$age',
            "gender": gender,
            "height": '$tall',
            "weight": '$weight',
            'bmi': '$bmi',
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: SizedBox(width: 40, child: Image.asset('images/logo.png')),
      ),
      body: Column(
        children: [
          Center(
            child: Form(
              key: _formKey,
              child: SizedBox(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      height: 50,
                    ),
                    const Text(textAlign: TextAlign.center, '정보를 입력해 주세요'),
                    const SizedBox(
                      width: double.infinity,
                      height: 50,
                    ),
                    DataForm(
                      name: '나이',
                      isNumber: true,
                      data: ageTextEditController,
                    ),
                    DataForm(
                      name: '키',
                      isNumber: true,
                      data: tallTextEditController,
                    ),
                    DataForm(
                      name: '체중',
                      isNumber: true,
                      data: weightTextEditController,
                    ),
                    DataForm(
                      name: '목표',
                      isNumber: true,
                      data: goalTextEditController,
                    ),
                    // DataForm(
                    //   name: '몸무게',
                    //   isNumber: true,
                    //   data: '0',
                    // ),
                    // DataForm(
                    //   name: '목표',
                    //   isNumber: false,
                    //   data: '0',
                    // ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            height: 70,
            color: Colors.black54,
            child: TextButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  print('here is data');
                  print(ageTextEditController.text);
                  print(tallTextEditController.text);
                  print(weightTextEditController.text);
                  print(goalTextEditController.text);

                  //var age = double.parse(ageTextEditController.text);
                  //var tall = double.parse(tallTextEditController.text);
                  //var weight = double.parse(weightTextEditController.text);
                  //var goal = double.parse(goalTextEditController.text);

                  _postRequest(
                    age: double.parse(ageTextEditController.text),
                    weight: double.parse(weightTextEditController.text),
                    tall: double.parse(tallTextEditController.text),
                  );

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             HomeScreen(userId: widget.userId)));

                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('환영합니다!')),
                  // );
                }
              },
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(style: TextStyle(color: Colors.white), '시작하기'),
            ),
          ),
        ],
      ),
    );
  }
}

class DataForm extends StatelessWidget {
  final String name;
  final bool isNumber;
  final TextEditingController data;

  const DataForm({
    Key? key,
    required this.name,
    required this.isNumber,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('$name :   '),
        SizedBox(
          width: 200,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: TextField(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              keyboardType:
                  isNumber ? TextInputType.number : TextInputType.text,
              controller: data,
              // inputFormatters: [
              //   FilteringTextInputFormatter.allow(RegExp('[0-9]'))
              // ],
            ),
          ),
        ),
      ]),
    );
  }
}
