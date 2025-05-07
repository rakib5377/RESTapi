import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ttb_restapi/models/ProductModel.dart';

class Productscreencomplexjson extends StatefulWidget {
  const Productscreencomplexjson({super.key});

  @override
  State<Productscreencomplexjson> createState() => _ProductscreencomplexjsonState();
}

class _ProductscreencomplexjsonState extends State<Productscreencomplexjson> {
  //List<ProductModel> productList = [];
  Future<ProductModel> getProductApi() async {
    final response = await http.get(Uri.parse("https://webhook.site/081c11c6-d9d1-43a2-aadf-ae0746e8182d"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      //productList.add(ProductModel.fromJson(data));
      return ProductModel.fromJson(data);
    }else{
      return ProductModel.fromJson(data);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product List"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(future: getProductApi(), builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data?.data?.length,
              itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .3,
                    width: MediaQuery.of(context).size.width * 1,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.data![index].images!.length,
                      itemBuilder: (context, positioned) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .25,
                          width: MediaQuery.of(context).size.width * .5,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(snapshot.data!.data![index].images![positioned].url.toString()),fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      );
                    },),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: ListTile(
                      title: Text(snapshot.data!.data![index].title.toString()),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snapshot.data!.data![index].shop!.shopemail.toString()),
                          Text(snapshot.data!.data![index].shop!.description.toString()),
                        ],
                      ),
                      leading: CircleAvatar(
                          radius: 30,backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),),
                      trailing: Text(snapshot.data!.data![index].shop!.name.toString(),style: TextStyle(fontSize: 16),),
                    ),
                  )
                ],
              );
            },);
          }else{
            return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Colors.teal,),
                SizedBox(height: 10,),
                Text("Loading MotherFucker"),
              ],
            ));
          }
        },),
      ),
    );
  }
}