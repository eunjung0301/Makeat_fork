import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(
        source: source, maxWidth: 640, maxHeight: 280, imageQuality: 100 //0-100
        );

    if (file?.path != null) {
      setState(() {
        //_selectedFiles.clear();
      });
    }
  }
  // XFile? _image;
  // final ImagePicker _picker = ImagePicker();

  // Future getImageFromCam() async {
  // // Pick an image
  // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  // // Capture a photo
  // setState(() {
  //   _image = image;
  // });
  // }

//   Future getImageFromCam() async {
//   var image = await ImagePicker.platform.pickImage(source: ImageSource.camera);
//   setState(() {
//     _image = image!;
//   });
// }

//   Future getImageFromGallery() async {
//   var image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
//   setState(() {
//     _image = image!;
//   });
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              FloatingActionButton(
                onPressed: () =>
                    getImage(source: ImageSource.camera), //getImageFromCam,
                child: const Icon(Icons.camera_alt_outlined),
              ),
              ElevatedButton(
                child: const Text('Pick Image'),
                onPressed: () => getImage(source: ImageSource.camera),
              ),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   height: 100,
              //   child: Center(child: _image == null ? Text('No image') : Image.file(File(_image!.path))),
              //   ),
            ],
          ),
        ));
  }
}
