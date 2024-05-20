import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getapiinone/Models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiExampleThree extends StatefulWidget {
  const ApiExampleThree({super.key});

  @override
  State<ApiExampleThree> createState() => _ApiExampleThreeState();
}

class _ApiExampleThreeState extends State<ApiExampleThree> {
  @override
  List<UserModel> userModel = [];
  Future<List<UserModel>> getUserModelApi() async {
    try {
      final response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        for (Map<String, dynamic> i in data) {
          userModel.add(UserModel.fromJson(i));
        }
        return userModel;
      } else {
        return userModel;
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Api Example Three"),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder<List<UserModel>>(
                  future: getUserModelApi(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text("No data is available"),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: ((context, index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ReusableRaw(title: "Name", value: snapshot.data![index].name.toString()),
                                    ReusableRaw(title: "UserName", value: snapshot.data![index].username.toString()),
                                    ReusableRaw(title: "Email", value: snapshot.data![index].email.toString()),
                                    ReusableRaw(title: "Address", value: snapshot.data![index].address!.city.toString()+ "  " + 
                                    snapshot.data![index].address!.geo!.lat.toString()
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }));
                    }
                  })))
        ],
      ),
    );
  }
}

class ReusableRaw extends StatelessWidget {
  String title, value;
  ReusableRaw({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
