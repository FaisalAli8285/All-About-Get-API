import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getapiinone/Models/products_model.dart';
import 'package:http/http.dart' as http;

class ApiExampleFive extends StatefulWidget {
  const ApiExampleFive({super.key});

  @override
  State<ApiExampleFive> createState() => _ApiExampleFiveState();
}

class _ApiExampleFiveState extends State<ApiExampleFive> {
  Future<ProductsModel> getProductsApi() async {
    final response = await http.get(
        Uri.parse("https://webhook.site/ffcd98c6-7b16-451b-ac51-cc9d926aac15"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductsModel.fromJson(data);
    } else {
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("API EXAMPLE FIVE"),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder<ProductsModel>(
                  future: getProductsApi(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (!snapshot.hasData ||
                        snapshot.data!.data!.isEmpty) {
                      return Center(
                        child: Text("No data is available"),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                      title: Text(snapshot
                                          .data!.data![index].shop!.name
                                          .toString()),
                                      subtitle: Text(snapshot
                                          .data!.data![index].shop!.shopemail
                                          .toString()),
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(snapshot
                                            .data!.data![index].shop!.image
                                            .toString()),
                                      )),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height * .3,
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot
                                          .data!.data![index].images!.length,
                                      itemBuilder: (context, position) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .25,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(snapshot
                                                        .data!
                                                        .data![index]
                                                        .images![position]
                                                        .url
                                                        .toString()))),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Icon(snapshot.data!.data![index].inWishlist==false ?Icons.favorite:Icons.favorite_border_outlined)
                                ],
                                
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
