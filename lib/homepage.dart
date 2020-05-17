import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:githubusers/panels/users.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List githubUsers;
  fetchGithubUsers() async {
    http.Response response =
        await http.get('https://api.github.com/users?language=flutter');
    setState(() {
      githubUsers = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    fetchGithubUsers();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('GitHub Users'),
          backgroundColor: Colors.blueGrey[900],
        ),
        body: githubUsers == null
            ? CircularProgressIndicator()
            : ListView.builder(
                shrinkWrap: true,
                itemCount: githubUsers == null ? 0 : githubUsers.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      height: 100,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                  githubUsers[index]['avatar_url'],
                                  height: 60)),
                          Text(
                            githubUsers[index]['login'],
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              launch(githubUsers[index]['html_url']);
                            },
                            child: Container(
                              height: 30,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.blueGrey[900])),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'View Profile',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  Image.asset(
                                    'images/github.png',
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ));
  }
}
