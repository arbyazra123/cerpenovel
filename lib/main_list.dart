import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'main.dart' as Main;
import 'config/database.dart';
import 'detail_ebook.dart';

class Main_Book_List extends StatefulWidget {
  @override
  _Main_Book_ListState createState() => _Main_Book_ListState();
}

class _Main_Book_ListState extends State<Main_Book_List> {
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();
  List dataJson;
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

  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['books', 'library', 'education'],
    contentUrl: 'https://flutter.io',
    birthday: DateTime.now(),
    childDirected: false,
    designedForFamilies: false,
    gender:
        MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
    testDevices: <String>[], // Android emulators are considered test devices
  );

  InterstitialAd myInterstitial = InterstitialAd(
    // Replace the testAdUnitId with an ad unit id from the AdMob dash.
    // https://developers.google.com/admob/android/test-ads
    // https://developers.google.com/admob/ios/test-ads
    adUnitId: "ca-app-pub-6095652561516356/6410965762",
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("InterstitialAd event is $event");
    },
  );

  BannerAd myBanner = BannerAd(
    // Replace the testAdUnitId with an ad unit id from the AdMob dash.
    // https://developers.google.com/admob/android/test-ads
    // https://developers.google.com/admob/ios/test-ads
    adUnitId: "ca-app-pub-6095652561516356/9936536989",
    size: AdSize.banner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("BannerAd event is $event");
    },
  );
  List<Container> CardView;

  Future<String> ambilData() async {
    this.setState(() {
      _load = true;
    });
    http.Response R = await http.get(
        Uri.encodeFull(
            "http://smeandigitallibrary.000webhostapp.com/ebooks/read.php"),
        headers: {"Accept": "application/json"});

    dataJson = jsonDecode(R.body);
    this.setState(() {
      _load = false;
    });
  }

  @override
  void initState() {
    super.initState();

    this.ambilData();
    FirebaseAdMob.instance
        .initialize(appId: 'ca-app-pub-6095652561516356~7811623442');
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
      body: _load == true
          ? new Container(
              child: Center(child: new CircularProgressIndicator()),
            )
          : new Container(
              color: Colors.grey[100],
              child: new ListView.builder(
                itemCount: dataJson == null ? 0 : dataJson.length,
                itemBuilder: (context, i) {
                  return new Card(
                    elevation: 4.0,
                    margin: EdgeInsets.only(
                        top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                    child: new GestureDetector(
                        onTap: () {
                          myInterstitial
                            ..load()
                            ..show();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new DetailDart(
                                        judul_buku: dataJson[i]['judul_buku'],
                                        penulis_buku: dataJson[i]
                                            ['penulis_buku'],
                                        penerbit_buku: dataJson[i]
                                            ['penerbit_buku'],
                                        genre_buku: dataJson[i]['genre_buku'],
                                        tanggal_terbit: dataJson[i]
                                            ['terbit_buku'],
                                        link_buku: dataJson[i]['link_buku'],
                                        kode_buku: dataJson[i]['kode_buku'],
                                        foto_buku: dataJson[i]['foto_buku'],
                                      )));
                        },
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
                                    image: dataJson[i]['foto_buku'],
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
                                          child: dataJson[i]['judul_buku'].length >=20 ? new Text(
                                        dataJson[i]['judul_buku'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10.0,
                                        ),
                                      ):
                                      new Text(
                                        dataJson[i]['judul_buku'],
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
                                              dataJson[i]['penulis_buku'])),
                                      new Padding(
                                        padding: EdgeInsets.all(10.0),
                                      ),
                                      new Center(
                                          child: Text(
                                              dataJson[i]['terbit_buku'])),
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
            ),
    );
  }
}
