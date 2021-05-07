import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<dynamic> futurecard;
  @override
  void initState() {
    super.initState();
    futurecard = apiget();
  }

  savedataonsf(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('carddata', data);
  }

  TextEditingController textcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CardPage(),
              ));
          //  print(Provider.of<CardPage>(context, listen: false).onlinecards);
        },
      ),
      key: scaffoldKey,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: FutureBuilder<dynamic>(
            future: futurecard,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data['tags'].length);
                return ListView.builder(
                  itemCount: 5, //snapshot.data['tags'].length,
                  itemBuilder: (BuildContext context, index) {
                    /*  for (int i = 0; i < snapshot.data['tags'].length; i++) {
                      context.read<CardPage>().addcard(CardData(
                          displayname: snapshot.data['tags'][0]['displayName'],
                          desc: snapshot.data['tags'][0]['description'],
                          tags: snapshot.data['tags'][0]['meta']));
                    }*/

                    return Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 1),
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Color(0xFFF5F5F5),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                  color: Color(0xFFEEEEEE),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    '${snapshot.data['tags'][index]['displayName']}',
                                    //textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFFDB389B),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                  '${snapshot.data['tags'][index]['description']}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                  '${snapshot.data['tags'][index]['meta']}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFFF03DEE),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<dynamic> apiget() async {
    String _baseUrl = "https://sigmatenant.com/mobile/tags";
    final response = await http.get(
      _baseUrl,
    );
    if (response.statusCode == 200) {
      savedataonsf(response.body);
      var snapshot = jsonDecode(response.body);

      return snapshot;
    } else {
      throw Exception('Failed to load json data');
    }
  }
}

class CardData {
  final String displayname;
  final String desc;
  final String tags;

  CardData(
      {@required this.displayname, @required this.desc, @required this.tags});

  factory CardData.fromJson(Map<String, dynamic> json) {
    return CardData(
      displayname: json['displayname'],
      desc: json['desc'],
      tags: json['tags'],
    );
  }
}
