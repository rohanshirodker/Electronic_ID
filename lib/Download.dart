import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'NavBar.dart';
import 'global.dart' as global;
import 'package:electronic_id/TopAppBar.dart';
import 'package:animate_do/animate_do.dart';

class Download extends StatefulWidget {
  @override
  _DownloadState createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  getMethod() async {
    String theUrl = 'http://192.168.0.123/electronicid/getDownloads.php';
    var res = await http
        .get(Uri.encodeFull(theUrl), headers: {"Accept": "application/json"});
    var respondsBody = json.decode(res.body);
    return respondsBody;
  }

  @override
  Widget build(BuildContext context) {
    global.sizeP = 24;
    global.sizeD = 40;
    global.sizeN = 24;
    global.colorN = Colors.grey;
    global.colorD = Colors.white;
    global.colorP = Colors.grey;
    global.colorQ = Colors.grey;
    SystemChrome.setEnabledSystemUIOverlays([]);
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popUntil((route) {
          return route.settings.name == 'ProfileScreen';
        });
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: topAppBar,
        bottomNavigationBar: NavBar(),
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
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                return ListView.builder(
                  itemCount: snap.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 200,
                      height: 80,
                      margin: new EdgeInsets.symmetric(vertical: 2.0),
                      child:FlipInY(
                        child: Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.blue,

                          child: ListTile(
                            title: Text(
                              " ${snap[index]['gaz_name']} ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'description: ${snap[index]['gaz_description']}'),
                                  Text('${snap[index]['date']}')
                                ]),
                            leading: Container(
                              child: ClipRRect(
                                //borderRadius:  new BorderRadius.circular(20.0),
                                child: Image(
                                  image: AssetImage(
                                    'assets/pdf.png',
                                  ),
                                ),
                              ),
                            ),
                            trailing: Icon(
                              Icons.download_outlined,
                              size: 40,
                              color: Colors.blue,
                            ),
                            onTap: () async {
                              final status = await Permission.storage.request();
                              if (status.isGranted) {
                                final externalDir =
                                    await getExternalStorageDirectory();
                                print(externalDir.path);
                                FlutterDownloader.enqueue(
                                  url:
                                      "http://192.168.0.123/electronicid/assets/uploads/${snap[index]['filename']}",
                                  savedDir: externalDir.path,
                                  fileName: "${snap[index]['filename']}",
                                  showNotification: true,
                                  openFileFromNotification: true,
                                );
                              } else {
                                print("permission dened");
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
