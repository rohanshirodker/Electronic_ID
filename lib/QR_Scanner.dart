import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Profile_QR_Screen.dart';
import 'QR_Screen.dart';
import 'global.dart' as global;
import 'package:electronic_id/TopAppBar.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
class QR_Scanner extends StatefulWidget {
  @override
  State<StatefulWidget>createState() => _QRScanState();
}


  class _QRScanState extends State<QR_Scanner>{
final qrkey = GlobalKey( debugLabel: 'OR');
QRViewController controller;
@override
void reassemble() async{
  super.reassemble();

  if (Platform.isAndroid){
    await controller.resumeCamera();
  }
}

  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIOverlays ([]);
    return  WillPopScope(
      onWillPop: ()async {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QR_Screen() ),);
        return false;

      },
      child: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: topAppBar,
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildQrView(context),
          ],
        ),
      ),
    );
  }



  Widget buildQrView(BuildContext context) => QRView(
    key: qrkey,
    onQRViewCreated: onQRViewCreated,
    overlay: QrScannerOverlayShape(
      borderColor: Colors.indigo,
      borderRadius: 10,
      borderLength: 15,
      borderWidth: 10,
      cutOutSize: MediaQuery.of(context).size.width*0.7,
    ),
  );

  void onQRViewCreated(QRViewController controller){
    setState(()=> this.controller = controller);
    bool scanned = false;
    controller.scannedDataStream.listen((scanData) {

      String fbarcode= scanData.code;
      controller.pauseCamera();
      Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Profile_QR_Screen(email: fbarcode ) ),);
    }
    );

  }
    @override
    void dispose(){
      controller.dispose();
      super.dispose();
    }

}





