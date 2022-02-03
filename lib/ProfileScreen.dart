import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:electronic_id/TopAppBar.dart';
import 'package:electronic_id/NavBar.dart';
import 'global.dart' as global;

var respondsBody;
var demail, dfname, dclass, ddop, ddep, dworkarea, dmobile,dunique_id,dDOB,dAdharcard,dofficer_address1,dj_date;

class ProfileScreen extends StatelessWidget {
// Creating String Var to Hold sent Email.
  final String email;

// Receiving Email using Constructor.
  ProfileScreen({Key key, @required this.email}) : super(key: key);

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
    dDOB = respondsBody[0]['DOB'];
    dAdharcard = respondsBody[0]['Adharcard'];
    dofficer_address1 = respondsBody[0]['officer_address1'];
    dj_date = respondsBody[0]['j_date'];
    global.dfname = dfname;
    global.dunique_id = dunique_id;
    return respondsBody;
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays ([]);
    global.sizeP = 35;
    global.sizeD = 24;
    global.sizeN = 24;
    global.colorN = Colors.grey;
    global.colorD = Colors.grey;
    global.colorP = Colors.white;
    global.colorQ = Colors.grey;


    Future<bool> _onBackPressed() async {
      return showDialog(
          context: context,
          builder: (context)=> AlertDialog(
            title: Text('Confirm'),
            content: Text('Do you want to exit the App'),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () =>
                    Navigator.of(context).pop(false), //Will not exit the App

              ),
              FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    //SystemChannels.platform.invokeMethod<void>(
                    SystemNavigator.pop(); //');
                    // return true ;//Will exit the App
                  }
              )
            ],


          )
      );
    }

    return
      WillPopScope(
          onWillPop: _onBackPressed, //() async {

          child: Scaffold(
            backgroundColor: Colors.indigo,
            appBar: topAppBar,
            bottomNavigationBar:
            NavBar(),
            body: FutureBuilder(
                future: getMethod(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {

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

                                            //elevation: 5.0,
                                            // borderRadius: BorderRadius.circular(10.0),
                                            // shadowColor: Colors.black,
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
                                          //margin: new EdgeInsets.symmetric(vertical: 10.0),
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
                              //SizedBox(height: 5.0),
                              Container(
                                child: Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          height: animatorState.value,
                                          child: _newwidget('Date of Birth:',dDOB),
                                        ),
                                      ),
                                      //SizedBox(width: 5.0),
                                      Expanded(
                                        child: Container(
                                          height: animatorState.value,
                                          child: _newwidget('Address:',dofficer_address1),

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
                                          child: _newwidget('Department:','Forest'),

                                        ),
                                      ),
                                      //SizedBox(width: 5.0),
                                      Expanded(
                                        child: Container(
                                          height: animatorState.value,
                                          child: _newwidget('Aadhaar Card:',dAdharcard),

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
                                            child:_newwidget('Date of Joining:',dj_date)

                                        ),
                                      ),

                                    ],

                                  ),
                                ),
                              ),
                              Container(
                                child: Expanded(
                                  child: Container(
                                    // height: animatorState.value,
                                    width: animatorState.value*3,
                                    child: _newwidget('Email ID:',demail ),

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