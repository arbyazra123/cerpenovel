import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'main_list.dart' as Main_List;
import 'category_e.dart' as Cat;
import 'config/database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'toolbar_setup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/services.dart';


void main(){
  runApp(new MaterialApp(
    // builder: (BuildContext context,Widget child) {
    //     var mQuery = MediaQuery.of(context).orientation;
    //     double pBottom = 50.0;
    //     if(mQuery==Orientation.landscape){
    //       pBottom = 0.0;
    //     }

    //     return new Padding(
    //       child:child,
    //       padding:  EdgeInsets.only(bottom: pBottom));
    //   }, 
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.red[700],
        accentColor: Colors.red
      ),
    title: "CERPENOVEL",
    home: new MainActivity(),
    routes: <String,WidgetBuilder> {
      "/Main" : (BuildContext context) => new MainActivity(),
      "/Fav_List" : (BuildContext context) => new Cat.CatView(),
    },
  ));
}

class MainActivity extends StatefulWidget {
  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  final GlobalKey<ScaffoldState> _scaffoldState = new GlobalKey<ScaffoldState>();
   final dbHelper = DatabaseHelper.instance;
  @override
  void initState(){
    
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, 
      DeviceOrientation.portraitUp ,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldState,

      appBar: AppBar(
        
        title: Text("Home"),
      ),
      drawer: DrawerWidget(),
      body:Main_List.Main_Book_List(),
      
      
    );
  }
}

class webView extends StatelessWidget {
  webView({this.link_buku,this.nama_buku});
  final String link_buku; 
  final String nama_buku; 
  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: link_buku == null ? Navigator.pushNamed(context, '/Main') : link_buku,
      appBar: AppBar(
        title: Text(nama_buku),
      ),
      
    );
  }
}


