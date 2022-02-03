import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:electronic_id/TopAppBar.dart';
import 'QR_Scanner.dart';
import 'global.dart' as global;


var respondsBody;
var demail, dfname, dclass, ddop, ddep, dworkarea, dmobile,dunique_id,dDOB,dAdharcard,dofficer_address1,dj_date;

class Profile_QR_Screen extends StatelessWidget {
// Creating String Var to Hold sent Email.
  final String email;

// Receiving Email using Constructor.
  Profile_QR_Screen({Key key, @required this.email}) : super(key: key);

  getMethod() async {
    String theUrl = 'http://192.168.0.123/electronicid/getData.php';
    var data = {'email': email};

    // Starting Web API Call.
    var res = await http.post(theUrl, body: json.encode(data));


    respondsBody = json.decode(res.body);
    print(respondsBody);

    demail = respondsBody[0]['email'];
    dfname = respondsBody[0]['fname'];
    dclass = respondsBody[0]['classofficer'];
    ddop = respondsBody[0]['p_date'];
    dunique_id = respondsBody[0]['unique_id'];
    dworkarea = respondsBody[0]['c_posting'];
    dmobile = respondsBody[0]['mobile'];
    print(global.dfname);

    return respondsBody;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays ([]);


    return  WillPopScope(
        onWillPop: ()async {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QR_Scanner() ),);
          return false;

        },
          child: Scaffold(
            backgroundColor: Colors.indigo,
            appBar: topAppBar,
           // bottomNavigationBar: NavBar(),
            body: FutureBuilder(
                future: getMethod(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // List snap = snapshot.data;

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
                  //return id_card();
                  return Padding(
                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    child: Animator<double>(
                      tween: Tween<double>(
                          begin: 60, end: MediaQuery.of(context).size.height / 3),
                      cycles: 1,
                      builder: (context, animatorState, child) => Center(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(

                                child: Expanded(


                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[

                                      Expanded(
                                        child: Container(

                                          height: animatorState.value,
                                          // color: Colors.lightBlue,

                                          child: Material(

                                            color: Colors.white,

                                            child: FittedBox(

                                              child: Container(
                                                margin: new EdgeInsets.symmetric(
                                                    vertical: 2.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: <Widget>[

                                                    CircleAvatar(
                                                      backgroundImage: AssetImage(
                                                        'assets/img_avatar.png',
                                                      ),

                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //SizedBox(height: 5.0),
                              Container(
                                child: Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          height: animatorState.value,
                                          child: _newwidget( 'Name:', dfname),
                                        ),
                                      ),
                                      //SizedBox(width: 5.0),
                                      Expanded(
                                        child: Container(
                                          height: animatorState.value,
                                          child: _newwidget('Unique-ID:', dunique_id ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Container(
                                child: Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          height: animatorState.value,
                                          child: _newwidget('Phone No.:',dmobile),
                                        ),
                                      ),
                                      //SizedBox(width: 5.0),
                                      Expanded(
                                        child: Container(
                                            height: animatorState.value,
                                            child:_newwidget('Class of Officer:', dclass)
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //SizedBox(height: 5.0),
                              Container(
                                child: Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          height: animatorState.value,
                                          child: _newwidget('Date of Posting:',ddop ),
                                        ),
                                      ),
                                      //SizedBox(width: 5.0),
                                      Expanded(
                                        child: Container(
                                          height: animatorState.value,
                                          child: _newwidget('Department:','Forest'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
            ),
          ));

  }

}

Widget _newwidget(String field, String data) {
  return Material(
    color: Colors.white,

    child: FittedBox(
      fit: BoxFit.contain,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(field,
                style: TextStyle(
                  color: Colors.black,

                )),
            SizedBox(height: 10.0),
            Text(data,
                style: TextStyle(
                  color: Colors.indigo,

                  fontWeight: FontWeight.bold,

                )),

          ],

        ),
      ),
    ),
  );
}