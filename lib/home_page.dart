import 'dart:convert';
// import 'dart:html';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_application_1/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Welcome> welcome = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: welcome.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    height: 25,
                    color: const Color.fromARGB(255, 244, 245, 244),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text(
                        //   'User id : ${welcome[index].albumId} ',
                        //   style: TextStyle(fontSize: 18),
                        // ),
                        // Text(
                        //   'Id : ${welcome[index].id}',
                        //   style: TextStyle(fontSize: 18),
                        // ),

                        Flexible(
                          // child: Image.network(
                          //   "${welcome[index].url}.jpg",
                          //   fit: BoxFit.fill,
                          //   errorBuilder: (context, error, stackTrace) {
                          //     return const Icon(Icons.error);
                          //   },
                          // ),
                          child: CachedNetworkImage(
                              imageUrl: "${welcome[index].thumbnailUrl}.jpg",
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) {
                                return const Icon(Icons.error);
                              }),
                        ),
                        // Text(
                        //   'Url: ${welcome[index].url} ',
                        //   maxLines: 1,
                        //   style: TextStyle(fontSize: 18),
                        // ),
                        // Image.network(
                        //     'https://jsonplaceholder.typicode.com/photos.jpg'),
                        // print(Image.network);
                        // Image.network(
                        //     'https://via.placeholder.com/150/92c952.jpg'),

                        Text(
                          welcome[index].title,
                          style: const TextStyle(fontSize: 18),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                        // Container(
                        //   height: 90,
                        //   width: 90,
                        //   decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //       image: NetworkImage(
                        //           'https://via.placeholder.com/150/92c952.jpg'),
                        //       //whatever image you can put here
                        //       fit: BoxFit.fill,
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Image.network(welcome[index].url),
                        // ),
                        // Text(
                        //   'Url: ${welcome[index].thumbnailUrl} ',
                        //   maxLines: 1,
                        //   style: TextStyle(fontSize: 18),
                        // ),
                      ],
                    ),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Future<List<Welcome>> getData() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        welcome.add(Welcome.fromJson(index));
        // Image.network(
        //   'https://jsonplaceholder.typicode.com/photos',
        // );
      }
      print(response);
      return welcome;
    } else {
      return welcome;
    }
  }
}
