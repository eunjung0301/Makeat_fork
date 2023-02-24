import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toonflix/screens/analysis_page.dart';
import 'package:http/http.dart' as http;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  // 파일 경로 문자열은 카메라에서는 에러 발생했다. image_picker 모듈에서 File 객체 반환.
  File? mPhoto;
  late Future<Widget> photo;

  Future<int> _uploadToSignedURL(
      {required Uint8List file, required String url}) async {
    http.Response response = await http.put(Uri.parse(url), body: file);
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    //Widget photo = (mPhoto != null) ? Image.file(mPhoto!) : const Text('EMPTY');

    return Center(
      child: Container(
        width: 350,
        height: 70,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 버튼을 제외한 영역의 가운데 출력
            // Expanded(
            //   child: Center(child: photo),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () => {
                          photo = onPhoto(ImageSource.gallery),

                          photo.then((val) {
                            // 데이터가 나오면 해당 값을 출력
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AnaPage(mPhoto: val)));
                            // _uploadToSignedURL(
                            //     file: val, url: '1'); //버킷에 업로드 어케 함?
                          }).catchError((error) {
                            // error가 해당 에러를 출력
                            print('error: $error');
                          }),
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => AnaPage(mPhoto: photo)))
                        },
                    child: const Text('갤러리에서 가져오기',
                        style: TextStyle(fontSize: 20, color: Colors.black87))),
                TextButton(
                    onPressed: () {
                      photo = onPhoto(ImageSource.camera);

                      photo.then((val) {
                        // 데이터가 나오면 해당 값을 출력
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AnaPage(mPhoto: val)));
                      }).catchError((error) {
                        // error가 해당 에러를 출력
                        print('error: $error');
                      });

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => AnaPage(mPhoto: photo)));
                    },
                    child: const Text('촬영하기',
                        style: TextStyle(fontSize: 20, color: Colors.black87)))
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 앨범과 카메라 양쪽에서 호출. ImageSource.gallery와 ImageSource.camera 두 가지밖에 없다.
  Future<Widget> onPhoto(ImageSource source) async {
    // await 키워드 때문에 setState 안에서 호출할 수 없다.
    // pickImage 함수 외에 pickVideo 함수가 더 있다.
    XFile? f = await ImagePicker().pickImage(source: source);
    mPhoto = File(f!.path);

    Future<Uint8List> sendPhoto = mPhoto!.readAsBytes();

    ///// 여기 고쳐야 함 ㅜㅜ
    // Future<File> writeImageTemp(String base64Image, String imageName) async {
    //   final dir = await getTemporaryDirectory();
    //   await dir.create(recursive: true);
    //   final tempFile = File(path.join(dir.path, imageName));
    //   await tempFile.writeAsBytes(base64.decode(base64Image));
    //   return tempFile;
    // }

    sendPhoto.then((val) {
      Future<int> data = _uploadToSignedURL(
          file: val, //val,
          url:
              'https://makeat.s3.amazonaws.com/3.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA37IAGAIXQ52EVAUK%2F20230224%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20230224T044146Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=4c2038c1c2e64589295642eccd3a9acef9ee1889d3aa751cd7af570657b603a8');
      print('전송 성공');

      data.then((value) => print('이유는 $value'));
    }).catchError((error) {
      print('Faliure to 사진전송');
    });

    Widget photo = (mPhoto != null) ? Image.file(mPhoto!) : const Text('EMPTY');
    return photo;
    //setState(() => mPhoto = File(f!.path));
  }
}
