import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'NavBar.dart';
import 'global.dart' as global;
import 'package:electronic_id/TopAppBar.dart';
import 'package:animate_do/animate_do.dart';

class Notifications extends StatelessWidget {

  getMethod() async {
    String theUrl = 'http://192.168.0.123/electronicid/getNotifications.php';
    var res = await http.get(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"});
    var respondsBody = json.decode(res.body);
   // print(respondsBody);
    return respondsBody;
  }


  @override
  Widget build(BuildContext context) {
    global.sizeP = 24;
    global.sizeD = 24;
    global.sizeN = 40;
    global.colorN = Colors.white;
    global.colorD = Colors.grey;
    global.colorP = Colors.grey;
    global.colorQ = Colors.grey;
    SystemChrome.setEnabledSystemUIOverlays ([]);
    return  WillPopScope(
      onWillPop: ()async {
        Navigator.of(context).popUntil((route){
          return route.settings.name == 'ProfileScreen';
        });
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: topAppBar,
        bottomNavigationBar:NavBar(),
        body: Padding(
          padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
          child: FutureBuilder(
              future: getMethod(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                List snap = snapshot.data;

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error fetching Data"),
                  );
                }
                return ListView.builder(
                  itemCount: snap.length,
                  itemBuilder: (context, index) {

                    return FlipInY(
                      child: Card(

                          child: ListTile(
                            title: Text("${snap[index]['not_cont']}",
                               // maxLines:1
                            ),
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text('${snap[index]['not_date'] }')]),

                            leading: Icon(Icons.message_rounded,size: 30,color: Colors.blue),
                            onTap: ()=>null,
                          ),
                        ),
                    );
                  },
                );
              }
          ),
        ),
      ),
    );
  }
}