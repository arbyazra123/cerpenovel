import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'main.dart' as Main;
import 'config/database.dart';
import 'detail_ebook.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Main_Book_List extends StatefulWidget {
  @override
  _Main_Book_ListState createState() => _Main_Book_ListState();
}

class _Main_Book_ListState extends State<Main_Book_List> {
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();
  bool _load = false;

  final dbHelper = DatabaseHelper.instance;

// _fetchData() async {
//     setState(() {
//       _load = true;
//     });
//     final response =
//         await http.get("http://smeandigitallibrary.000webhostapp.com/ebooks/read.php");
//     if (response.statusCode == 200) {
//       list = json.decode(response.body) ;
//       setState(() {
//         _load = false;
//       });
//     } else {
//       throw Exception('Failed to load photos');
//     }
//   }


static double highBotom = 0;

  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['books', 'library', 'education','game','epub'],
    contentUrl: 'https://flutter.io',
    birthday: DateTime.now(),
    designedForFamilies: false,
    // or MobileAdGender.female, MobileAdGender.unknown
     // Android emulators are considered test devices
  );

InterstitialAd myInterstitial = InterstitialAd(
    // Replace the testAdUnitId with an ad unit id from the AdMob dash.
    // https://developers.google.com/admob/android/test-ads
    // https://developers.google.com/admob/ios/test-ads
    adUnitId: "ca-app-pub-8855503199362242/4110349481",
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("InterstitialAd event is $event");
      
    },
  );

  BannerAd myBanner = BannerAd(
    // Replace the testAdUnitId with an ad unit id from the AdMob dash.
    // https://developers.google.com/admob/android/test-ads
    // https://developers.google.com/admob/ios/test-ads
    adUnitId: "ca-app-pub-8855503199362242/1446681215",
    size: AdSize.banner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("BannerAd event is $event");
      if(event!= MobileAdEvent.failedToLoad){
        highBotom=50.0;
      }
    },
  );
  List<Container> CardView;


  @override
  void initState() {
    super.initState();

//    this.ambilData();
    FirebaseAdMob.instance
        .initialize(appId: 'ca-app-pub-8855503199362242~1638252901');
    myBanner
      ..load()
      ..show();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    myInterstitial.dispose();
    myBanner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldState,
      body: StreamBuilder(
        stream: Firestore.instance.collection("book_library").snapshots(),
        builder:(context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.data==null)return Center(child: CircularProgressIndicator(),);
          if(snapshot.data.documents.length==0)return Center(child: Text("Data Kosong"),);
          return Container(
                color: Colors.grey[100],
                child: new ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, i) {
                    var curData = snapshot.data.documents[i];
                    return InkWell(
                      onTap: () {
                        myInterstitial
                          ..load()
                          ..show();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new DetailDart(
                                  id: curData.documentID,
                                  judul_buku: curData.data['title'],
                                  penulis_buku: curData.data['writer'],
                                  genre_buku: curData.data['category'],
                                  tanggal_terbit: curData.data['published_year'],
                                  link_buku: curData.data['link'],
                                  foto_buku: curData.data['cover'],
                                )));
                      },
                      child: new Card(

                        elevation: 4.0,
                        margin: EdgeInsets.only(
                            top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                        child: new Container(
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.all(2.0),
                          child: new Row(
                            children: <Widget>[
                              new Flexible(
                                  flex: 1,
                                  child: new FadeInImage.assetNetwork(
                                    fadeInDuration: Duration(seconds: 1),
                                    fadeOutDuration: Duration(seconds: 1),
                                    placeholder: "assets/loading.gif",
                                    image: curData.data['cover'],
                                    width: 70.0,
                                  )),
                              new Flexible(
                                flex: 3,
                                child: new Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Container(
                                          child: curData['title'].length >=20 ? new Text(
                                            curData['title'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10.0,
                                        ),
                                      ):
                                      new Text(
                                        curData['title'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.0,
                                        ),
                                      )
                                      ),
                                      new Padding(
                                        padding: EdgeInsets.all(10.0),
                                      ),
                                      new Center(
                                          child: Text(
                                              curData['writer'])),
                                      new Padding(
                                        padding: EdgeInsets.all(10.0),
                                      ),
                                      new Center(
                                          child: Text(
                                              curData['published_year'])),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ),
                    );
                  },
                ),
              );
        }
      ),
    );
  }
}
