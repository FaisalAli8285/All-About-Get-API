import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiExampleTwo extends StatefulWidget {
  const ApiExampleTwo({super.key});

  @override
  State<ApiExampleTwo> createState() => _ApiExampleTwoState();
}

class _ApiExampleTwoState extends State<ApiExampleTwo> {
  List<Photos> photoList = [];
  Future<List<Photos>> getPhotosApi() async {
    try {
      final response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        for (Map<String, dynamic> i in data) {
          Photos photos = Photos(title: i["title"], url: i["url"], id: i["id"]);
          photoList.add(photos);
        }
        return photoList;
      } else {
        return photoList;
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("API EXAMPLE TWO"),
      ),
      body: Column(
        children: [
          // Expanded(
          //     child: FutureBuilder(
          //         future: getPhotosApi(),
          //         builder: (context, snapshot) {
          //           if (snapshot.connectionState == ConnectionState.waiting) {
          //             return CircularProgressIndicator();
          //           } else if (snapshot.hasError) {
          //             return Text("Error : " + snapshot.error.toString());
          //           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          //             return Text("No data is avaialable");
          //           } else {
          //             return ListView.builder(
          //                 itemCount: photoList.length,
          //                 itemBuilder: ((context, index) {
          //                   return Column(
          //                     children: [
          //                       Text(photoList[index].title.toString()),
          //                       Text(photoList[index].url.toString())
          //                     ],
          //                   );
          //                 }));
          //           }
          //         })),
          Expanded(
              child: FutureBuilder(
                  future: getPhotosApi(),
                  builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text("Error : " + snapshot.error.toString());
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text("No data is avaialable");
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: ((context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    snapshot.data![index].url.toString()),
                              ),
                              title: Text("Title : \n" +
                                  snapshot.data![index].title.toString()),
                              subtitle: Text("ID : \n" +
                                  snapshot.data![index].id.toString()),
                            );
                          }));
                    }
                  })),
        ],
      ),
    );
  }
}

class Photos {
  String title;
  String url;
  int id;
  Photos({required this.title, required this.url, required this.id});
}
