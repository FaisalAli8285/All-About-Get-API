// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class APiExampleFour extends StatefulWidget {
//   const APiExampleFour({super.key});

//   @override
//   State<APiExampleFour> createState() => _APiExampleFourState();
// }

// class _APiExampleFourState extends State<APiExampleFour> {
//   var data;

//   Future<void> getUserApis() async {
//     try {
//       final response = await http
//           .get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

//       if (response.statusCode == 200) {
//         data = jsonDecode(response.body.toString());
//         print("data fetched syccessfuly");
//       } else {
//         print('Failed to load data');
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("API EXAMPLE FOUR"),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: FutureBuilder(
//               future: getUserApis(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (snapshot.hasError) {
//                   return Center(
//                     child: Text(snapshot.error.toString()),
//                   );
//                 } else if (!snapshot.hasData || data == null || data!.isEmpty) {
//                   return Center(
//                     child: Text("No data available"),
//                   );
//                 } else {
//                   return ListView.builder(
//                     itemCount: data!.length,
//                     itemBuilder: (context, index) {
//                       return Card(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             children: [
//                               ReusableRow(
//                                 title: "Name",
//                                 value: data![index]["name"].toString(),
//                               ),
//                               ReusableRow(
//                                 title: "Username",
//                                 value: data![index]["username"].toString(),
//                               ),
//                               ReusableRow(
//                                 title: "Email",
//                                 value: data![index]["email"].toString(),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ReusableRow extends StatelessWidget {
//   final String title, value;
//   ReusableRow({super.key, required this.title, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(title),
//         Text(value),
//       ],
//     );
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFour extends StatefulWidget {
  const ExampleFour({Key? key}) : super(key: key);

  @override
  _ExampleFourState createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {
  var data;
  Future<void> getUserApis() async {
    try {
      final response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

      if (response.statusCode == 200) {
        data = jsonDecode(response.body.toString());
        print("data fetched syccessfuly");
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print(e.toString());
    }
    // var data ;
    // Future<void> getUserApi ()async{
    //   final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    //   if(response.statusCode == 200){
    //     data = jsonDecode(response.body.toString());
    //   }else {

    //   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Api Course'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApis(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (data==null) {
                  return Center(
                    child: Text("No data available"),
                  );
                } else {
                  return ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ReusableRow(
                                title: "Name",
                                value: data![index]["name"].toString(),
                              ),
                              ReusableRow(
                                title: "Username",
                                value: data![index]["username"].toString(),
                              ),
                              ReusableRow(
                                title: "Email",
                                value: data![index]["email"].toString(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],
    );
  }
}
//        Column(
//         children: [
//           Expanded(
//             child: FutureBuilder(
//               future: getUserApis(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Text('Loading');
//                 } else {
//                   return ListView.builder(
//                       itemCount: data.length,
//                       itemBuilder: (context, index) {
//                         return Card(
//                           child: Column(
//                             children: [
//                               ReusbaleRow(
//                                 title: 'name',
//                                 value: data[index]['name'].toString(),
//                               ),
//                               ReusbaleRow(
//                                 title: 'Username',
//                                 value: data[index]['username'].toString(),
//                               ),
//                               ReusbaleRow(
//                                 title: 'address',
//                                 value:
//                                     data[index]['address']['street'].toString(),
//                               ),
//                               ReusbaleRow(
//                                 title: 'Lat',
//                                 value: data[index]['address']['geo']['lat']
//                                     .toString(),
//                               ),
//                               ReusbaleRow(
//                                 title: 'Lat',
//                                 value: data[index]['address']['geo']['lng']
//                                     .toString(),
//                               ),
//                             ],
//                           ),
//                         );
//                       });
//                 }
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class ReusbaleRow extends StatelessWidget {
//   String title, value;
//   ReusbaleRow({Key? key, required this.title, required this.value})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title),
//           Text(value),
//         ],
//       ),
//     );
//   }
// }
