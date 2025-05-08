import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image;
  final _image = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    final pickedImage = await _image.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if(pickedImage != null){
      image = File(pickedImage.path);
      setState(() {

      });
    }else{
      toastmessage("No Image Selected");
    }
  }
  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });

    var stream = new http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();

    var uri = Uri.parse('https://fakestoreapi.com/products');

    var request = new http.MultipartRequest('POST', uri);
    request.fields['title'] = "Static title";

    var multipart = new http.MultipartFile('image', stream, length);

    request.files.add(multipart);

    var response = await request.send();

    if(response.statusCode == 200){
      toastmessage("Image Uploaded Successfully");
      setState(() {
        showSpinner =  false;
      });
    }else{
      toastmessage("Failed to upload");
      setState(() {
        showSpinner = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload image"),),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){getImage();},
              child: Center(
                child: image == null ? Center(child: Text("No Image. click to pick one"),)
                : Center(
                  child: Image.file(
                    File(image!.path).absolute,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),

              ),
            ),
            SizedBox(height: 100,),
            GestureDetector(
              onTap: (){uploadImage();},
              child: Container(
                height: 50,
                width: 200,
                color: Colors.teal,
                child: Center(child: Text("Upload"),),
              ),
            )
          ],
        ),
      ),
    );
  }
  void toastmessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
