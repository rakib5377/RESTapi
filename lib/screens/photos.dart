import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ttb_restapi/models/photoModel.dart';
import 'package:http/http.dart' as http;
class Photos extends StatefulWidget {
  const Photos({super.key});

  @override
  State<Photos> createState() => _PhotosState();
}

class _PhotosState extends State<Photos> {
  List<PhotoModel> photoList = [];
  Future<List<PhotoModel>> getPhotos() async {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      photoList.clear();
      for (Map i in data){
        PhotoModel photoModel = PhotoModel(title: i['title'], url: i['url'],id: i['id']);
        photoList.add(photoModel);
      }
      return photoList;
    }else{
      return photoList;
    }
  }
  @override
  Widget build(BuildContext context) {
String hardImage = "https://cdn.pixabay.com/photo/2024/05/26/10/15/bird-8788491_1280.jpg";
    return Scaffold(
      appBar: AppBar(title: Text("Photos"),centerTitle: true,),
      body: FutureBuilder(future: getPhotos(), builder: (context, AsyncSnapshot<List<PhotoModel>> snapshot){
       if(!snapshot.hasData){
         return Center(child: CircularProgressIndicator());
       }
       else{
         return ListView.builder(
           itemCount: 100,
           itemBuilder: (context, index) {
             return Card(
               elevation: 5,
               child: ListTile(
                 leading: CircleAvatar(backgroundImage: NetworkImage(hardImage),),
                 title: Text(snapshot.data![index].title.toString()),
               ),
             );
           },);
       }
      })
    );
  }
}
