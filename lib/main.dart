import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

// Written by Kunalpal215

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    dynamic result = FutureBuilder<dynamic>(
      future: getUrl(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final meme = snapshot.data;
          return Image.network("$meme");
        } else if (snapshot.hasError) {
          return Text('Error in obtaining meme !');
        }
        return CircularProgressIndicator();
      },
    );
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Watch COOL MEMES!',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            backgroundColor: Colors.yellowAccent,
            centerTitle: true,
          ),
          body: ListView(
            scrollDirection: Axis.vertical,
            children: [
              SizedBox(height: 15,),
              Center(
                child: result,
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    result = FutureBuilder<dynamic>(
                      future: getUrl(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final meme = snapshot.data;
                          return Image.network("$meme");
                        } else if (snapshot.hasError) {
                          return Text('Error in obtaining meme !');
                        }
                        return CircularProgressIndicator();
                      },
                    );
                  });
                },
                child: Text('Click for next meme!',style: TextStyle(color: Colors.white,fontSize: 30, fontWeight: FontWeight.bold),),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(15),
                    backgroundColor: Colors.black),
              ),
            ],
          )),
    );
  }
}

Future<String> getUrl() async {
  final url = "https://meme-api.herokuapp.com/gimme";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final needJson = jsonDecode(response.body);
    String imgUrl = needJson["url"];
    return imgUrl;
  } else {
    throw Exception();
  }
}
