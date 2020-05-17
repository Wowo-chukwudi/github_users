import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List githubUsers;
  fetchGitHubUsers()async{
    http.Response response= await http.get('https://api.github.com/users?language=flutter');
    setState(() {
      githubUsers = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    fetchGitHubUsers();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index){
      return Container(
        height: 120,
        child: Row(
          children: <Widget>[
            Image.network(githubUsers[index]['avatar_url'], height: 30,),
            Text(githubUsers[index]['login'])
          ],
        ),
      );
    },
    itemCount: githubUsers==null?0:githubUsers.length,);
  }
}
