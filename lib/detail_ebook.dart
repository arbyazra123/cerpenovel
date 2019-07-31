import 'package:flutter/material.dart';
import 'config/database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'main.dart';
import 'package:flutter/services.dart';

class DetailDart extends StatefulWidget {
  DetailDart(
      {Key key,
      @required this.judul_buku,
      @required this.penulis_buku,
      @required this.tanggal_terbit,
      @required this.genre_buku,
      @required this.penerbit_buku,
      @required this.link_buku,
      @required this.kode_buku,
      @required this.foto_buku})
      : super(key: key);
  final String judul_buku;
  final String kode_buku;
  final String penulis_buku;
  final String tanggal_terbit;
  final String genre_buku;
  final String penerbit_buku;
  final String foto_buku;
  final String link_buku;
  @override
  _DetailDartState createState() => _DetailDartState();
}

class _DetailDartState extends State<DetailDart> {
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();
  final dbHelper = DatabaseHelper.instance;
  bool _loadFav = false;
  Future<String> _statusFav() async {
    final r = await dbHelper.search(widget.kode_buku);
    if (r == true) {
      setState(() {
        _loadFav = true;
      });
    } else {
      setState(() {
        _loadFav = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _statusFav();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: widget.kode_buku,
      DatabaseHelper.columnName: widget.judul_buku,
      DatabaseHelper.columnCat: widget.genre_buku,
      DatabaseHelper.columnDate: widget.tanggal_terbit,
      DatabaseHelper.columnLink: widget.link_buku,
      DatabaseHelper.columnPict: widget.foto_buku,
      DatabaseHelper.columnWriter: widget.penulis_buku,
      DatabaseHelper.columnPub: widget.penerbit_buku,
      DatabaseHelper.columnFav: widget.kode_buku
    };
    return new Scaffold(
      key: _scaffoldState,
      floatingActionButton: FloatingActionButton(
          child: Text("BACA"),
          onPressed: () {
            Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => new webView(
                  link_buku: widget.link_buku,
                  nama_buku: widget.judul_buku,
                )));
          },
        ),
      appBar: AppBar(
        title: Text(widget.judul_buku ?? 'Judul Buku'),
      ),
      body: new SingleChildScrollView(
          child: new SizedBox(
            height: 500.0,
            child: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new SizedBox(
          height: 300.0,
          child: new Stack(
            children: <Widget>[
              new Container(
                decoration: new BoxDecoration(color: Colors.grey[800]),
              ),
              new Center(
                child: new SizedBox(
                  height: 300.0,
                  child:new Material(
                      child: new InkWell(
                        child: new Image.network(widget.foto_buku,
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                  
                ),
              )
            ],
          ),
        ),
        new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.all(5.0),
            ),
            new Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      new Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                      ),
                      new Text(widget.judul_buku,
                          style: new TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0)),
                      new Text(widget.penulis_buku,
                          style: new TextStyle(
                              fontSize: 15.0, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            new Row(
              children: <Widget>[
                new GestureDetector(
                    onTap: () async {
                      await dbHelper.search(widget.kode_buku ?? '') ==
                              true
                          ? _scaffoldState.currentState
                              .showSnackBar(new SnackBar(
                              
                              content: Text(
                                  "Double Tap to delete as favorite"),
                              duration: Duration(seconds: 1),
                            ))
                          : _scaffoldState.currentState
                              .showSnackBar(new SnackBar(
                              content:
                                  Text("Double Tap to add as favorite"),
                            ));
                    },
                    onDoubleTap: () async {
                      await dbHelper.search(widget.kode_buku) == true
                          ? {
                              await dbHelper.delete(widget.kode_buku),
                              this.setState(() {
                                _loadFav = false;
                              }),
                              _scaffoldState.currentState
                                  .showSnackBar(new SnackBar(
                                content: Text(widget.judul_buku +
                                    " Deleted as Favorite E-book"),
                                duration: Duration(seconds: 2),
                                action: SnackBarAction(
                                  label: "UNDO",
                                  onPressed: () async {
                                    await dbHelper.insert(row);
                                    this.setState(() {
                                      _loadFav = true;
                                    });
                                    _scaffoldState.currentState
                                        .showSnackBar(new SnackBar(
                                      content: Text(widget.judul_buku +
                                          " Added as Favorite E-book"),
                                      duration: Duration(seconds: 2),
                                    ));
                                  },
                                ),
                              ))
                            }
                          : {
                              await dbHelper.insert(row),
                              this.setState(() {
                                _loadFav = true;
                              }),
                              _scaffoldState.currentState
                                  .showSnackBar(new SnackBar(
                                content: Text(widget.judul_buku +
                                    " Added as Favorite E-book"),
                                duration: Duration(seconds: 2),
                                action: SnackBarAction(
                                  label: "UNDO",
                                  onPressed: () async {
                                    await dbHelper
                                        .delete(widget.kode_buku);
                                    this.setState(() {
                                      _loadFav = false;
                                    });
                                    _scaffoldState.currentState
                                        .showSnackBar(new SnackBar(
                                            content: Text(widget
                                                    .judul_buku +
                                                " Deleted as Favorite E-book"),
                                            duration:
                                                Duration(seconds: 2)));
                                  },
                                ),
                              )),
                            };
                    },
                    child: _loadFav == true
                        ? new Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 30.0,
                          )
                        : new Icon(
                            Icons.favorite,
                            color: Colors.grey[400],
                            size: 30.0,
                          ))
              ],
            ),
            new Padding(
              padding: EdgeInsets.all(10.0),
            ),
          ],
        ),
        new Divider(),
        new Expanded(
          //           child: new Column(
          //             children: <Widget>[
          //              new Row(
          //               children: <Widget>[
          //               Spacer(),
          //               new Text("Penerbit",style: TextStyle(fontSize: 15.0,color: Colors.grey[700]),),
          //               Spacer(),  // Defaults to flex: 1
          //               new Text(widget.penerbit_buku),
          //               Spacer(flex: 20),
          //             ]
          //               ),
          //              new Row(
          //               children: <Widget>[
          //               Spacer(),
          //               new Text("Genre",style: TextStyle(fontSize: 15.0,color: Colors.grey[700]),),
          //               Spacer(flex: 2,),  // Defaults to flex: 1
          //               new Text(widget.penerbit_buku),
          //               Spacer(flex: 20),
          //             ]
          //               ),
          // ],
          //           ),
          child: new Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: new Table(
              columnWidths: {1: FractionColumnWidth(.80)},
              children: [
                TableRow(children: [
                  new Text("Penerbit",
                      style: TextStyle(
                          fontSize: 15.0, color: Colors.grey[500])),
                  new Text(": " + widget.penerbit_buku,
                      style: TextStyle(
                        fontSize: 15.0,
                      ))
                ]),
                TableRow(children: [
                  new Text("Genre",
                      style: TextStyle(
                          fontSize: 15.0, color: Colors.grey[500])),
                  new Text(": " + widget.genre_buku,
                      style: TextStyle(
                        fontSize: 15.0,
                      ))
                ]),
                TableRow(children: [
                  new Text(
                    "Terbit",
                    style: TextStyle(
                        fontSize: 15.0, color: Colors.grey[500]),
                  ),
                  new Text(": " + widget.tanggal_terbit,
                      style: TextStyle(
                        fontSize: 15.0,
                      )),
                ]),
              ],
            ),
          ),
          // child: new Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: <Widget>[

          //     new Row(
          //       children: <Widget>[
          //         new Text("Penerbit"),
          //         new Padding(padding: EdgeInsets.symmetric(horizontal: 8.0),),
          //         new Text(widget.penerbit_buku)
          //       ],
          //     ),
          //     new Row(
          //       children: <Widget>[
          //         new Text("Genre"),
          //         new Padding(padding: EdgeInsets.symmetric(horizontal: 8.0),),
          //         new Text(widget.genre_buku)
          //       ],
          //     ),
          //     new Row(
          //       children: <Widget>[
          //         new Text("Tahun Terbit"),
          //         new Padding(padding: EdgeInsets.symmetric(horizontal: 8.0),),
          //         new Text(widget.tanggal_terbit),
          //       ],
          //     )
          //   ],
          // )

          // child: new Row(
          //   children: <Widget>[
          //     new Padding(padding: EdgeInsets.all(5.0),),
          //     new Text("Detail E-Book",style: TextStyle(color: Colors.grey[400]),),
          //     new Padding(padding: EdgeInsets.symmetric(vertical: 10.0),),
          //     new Text(data)

          //   ],
          // )
        ),
      ],
            ),
          ),
        ),
    );
  }
}
