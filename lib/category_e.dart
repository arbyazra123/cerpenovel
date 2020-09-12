import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'toolbar_setup.dart';
import 'detail_ebook.dart';

class CatView extends StatefulWidget {
  @override
  _CatViewState createState() => _CatViewState();
  CatView({Key key,@required this.category, this.title}) : super(key : key);
  final String category;
  final String title;

}

class _CatViewState extends State<CatView> {
  final GlobalKey<ScaffoldState> _scaffoldState = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    print(widget.category.toLowerCase());
    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.title+" - NAC Book Library"),
      ),
      drawer: DrawerWidget(),
      body: StreamBuilder(
        stream: Firestore.instance.collection("book_library")
            .snapshots(),
        builder:(context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.data==null)return Center(child: CircularProgressIndicator(),);
          if(snapshot.data.documents.length==0)return Center(child: Text("Data Kosong"),);
          var data = snapshot.data.documents.where((e) => e.data['category'].toString().toLowerCase().contains(widget.category)).toList();
        return data.length>0? Container(

          color: Colors.grey[100],
          child: new ListView.builder(
            itemCount:data.length ,
            itemBuilder: (context,i){
              var curData = data[i];
              return new Card(
              elevation: 4.0,
              margin: EdgeInsets.only(top:5.0,bottom:5.0,left:10.0,right:10.0),
            
              child: new Hero(
                  tag: curData.data['title'],
                  child: new GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                MaterialPageRoute(builder: (context) =>  new DetailDart(
                  id: curData.documentID,
                  judul_buku: curData.data['title'],
                  penulis_buku: curData.data['writer'],
                  genre_buku: curData.data['category'],
                  tanggal_terbit: curData.data['published_year'],
                  link_buku: curData.data['link'],
                  foto_buku: curData.data['cover'],
                )
                )
                    );
                          },
                          child:  new Container(
                            margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.all(2.0),
                          child: new Row(
                            children: <Widget>[
                              new Image.network(
                                curData.data['cover'],
                                width: 70.0,
                              ),
                              new Container(
                                padding: EdgeInsets.all(10.0),
                                width: 180.0,
                                child: new Column(
                                  children: <Widget>[
                                    new Container(
                                     child: new FittedBox(
                                       fit:BoxFit.contain,
                                       child: new Text(
                                         curData.data['title'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ))),
                                    
                                    new Padding(
                                      padding: EdgeInsets.all(10.0),
                                    ),
                                    new Center(
                                        child: Text(curData.data['writer'])),
                                    new Padding(
                                      padding: EdgeInsets.all(10.0),
                                    ),
                                    new Center(
                                        child: Text(curData.data['published_year'])),
                                  ],
                                ),
                              ),
                             
                            ],
                          ),
                        ),
                        
                        
                  ),
              ),
              
              );
            },
          ),
        ):Center(child: Text("Data Kosong"),);
        } 
      ),
      
      
    );
  }
}