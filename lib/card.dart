import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:sigma_task/prov.dart';

class CardPage extends StatefulWidget {
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  void initState() {
    super.initState();
    datasearch();
  }

  List datafetched = [];
  List showdata = [];

  datasearch() async {
    /* SharedPreferences prefs = await SharedPreferences.getInstance();
    var lfavrt = prefs.getString('carddata');
    var data = jsonDecode(lfavrt);*/

    var data = await Provider.of<ProvData>(context, listen: false).datafetched;
    print(data['tags']);
    for (int i = 0; i < data['tags'].length; i++) {
      List l = [
        data['tags'][i]['displayName'],
        data['tags'][i]['description'],
        data['tags'][i]['meta']
      ];
      setState(() {
        datafetched.add(l);
      });
    }
  }

  TextEditingController textcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {},
                    controller: textcontroller,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Search ',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFF0B0B0B),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF0B0B0B),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          showdata.clear();
                        });
                        for (int i = 0; i < datafetched.length; i++) {
                          if ((datafetched[i][0].toString().contains(RegExp(
                                      textcontroller.text,
                                      caseSensitive: false)) ||
                                  datafetched[i][1].toString().contains(RegExp(
                                      textcontroller.text,
                                      caseSensitive: false))) &&
                              textcontroller.text.isEmpty == false) {
                            setState(() {
                              showdata.add(datafetched[i]);
                            });
                          }
                        }
                      },
                      icon: Icon(Icons.search),
                    ),
                  ],
                ),
              ],
            ),

            Expanded(
              child: showdata.isEmpty
                  ? Text('Not found')
                  : ListView.builder(
                      itemCount: showdata.length,
                      itemBuilder: (BuildContext context, int index) {
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFEEEEEE),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${showdata[index][0]}', //${showdata[0]}',
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
                                      '${showdata[index][1]}', //${showdata[0][0]}',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Text(
                                      '${showdata[index][2]}', //${showdata[0][1]}',
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

                        // }
                      },
                    ),
            ),
            //   ],
            /**/
            // ),
            //   ),
          ],
          //  ),
          // ),
          //],
        ),
      ),
      //  ),
    );
  }
}
