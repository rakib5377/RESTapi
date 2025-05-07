import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ttb_restapi/models/usersModel.dart';
import 'package:http/http.dart' as client;

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<UsersModel> usersList = [];
  Future<List<UsersModel>> getUserApi() async {
    final response = await client.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        usersList.add(UsersModel.fromJson(i));
      }
      return usersList;
    } else {
      return usersList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users"), centerTitle: true),
      body: FutureBuilder(
        future: getUserApi(),
        builder: (context,AsyncSnapshot<List<UsersModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
              itemCount: usersList.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ReusableRow(title: "Name", value: snapshot.data![index].name.toString()),
                        ReusableRow(title: "UserName", value: snapshot.data![index].username.toString()),
                        ReusableRow(title: "Email", value: snapshot.data![index].email.toString()),
                        ReusableRow(title: "Address", value: snapshot.data![index].address!.city.toString()),
                        ReusableRow(title: "Address", value: snapshot.data![index].address!.geo!.lat.toString()),
                        ReusableRow(title: "Company", value: snapshot.data![index].company!.name.toString()),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
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

