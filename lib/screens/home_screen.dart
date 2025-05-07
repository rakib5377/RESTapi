import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ttb_restapi/models/PostModel.dart';
import 'package:ttb_restapi/screens/photos.dart';
import 'package:ttb_restapi/screens/users_screen.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> postList = [];
  Future<List<PostModel>> getPostApi() async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      postList.clear();
      for(Map i in data){
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    }else{
      return postList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post Api"),centerTitle: true,actions: [
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>UsersScreen()));
          },
          child: Container(height: 20,width:50,decoration: BoxDecoration(color: Colors.blueGrey,borderRadius: BorderRadius.circular(5)),
              child: Text("Users",style: TextStyle(color: Colors.white),)),
        ),
        SizedBox(width: 10,),
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>Photos()));
          },
          child: Container(height: 20,width:50,decoration: BoxDecoration(color: Colors.blueGrey,borderRadius: BorderRadius.circular(5)),
              child: Text("Photos",style: TextStyle(color: Colors.white),)),
        ),
        SizedBox(width: 10,)
      ],),
      body: FutureBuilder(future: getPostApi(), builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }else{
          return ListView.builder(
            itemCount: postList.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                color: Colors.grey.shade200,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Title",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      Text(postList[index].title.toString()),
                      SizedBox(height: 10,),
                      Text("Description",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),

                      Text(postList[index].body.toString()),
                    ],
                  ),
                )
              );
            },);
        }
      },),
    );
  }
}
