import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserScreenWithoutModel extends StatefulWidget {
  const UserScreenWithoutModel({super.key});

  @override
  State<UserScreenWithoutModel> createState() => _UserScreenWithoutModelState();
}

class _UserScreenWithoutModelState extends State<UserScreenWithoutModel> {
  var data;
  Future<void> getUserApi() async {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if(response.statusCode == 200){
      data = jsonDecode(response.body.toString());
    }
    else{

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users"), centerTitle: true),
      body: FutureBuilder(future: getUserApi(), builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }else{
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                child: Column(
                children: [
                  ReusableRow(title: "Name", value: data[index]['name'].toString()),
                  ReusableRow(title: "UserName", value: data[index]['username'].toString()),
                  ReusableRow(title: "Address", value: data[index]['address']['city'].toString()),
                  ReusableRow(title: "Geo", value: data[index]['address']['geo']['lat'].toString()),
                ],
              ),);
            },);

        }
      },),
    );
  }
}
class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value)
        ],
      ),
    );
  }
}

