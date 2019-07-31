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
  List dataJson;
  bool _load = false;
  Future<String> getData() async {
    setState(() {
          _load = true;
        });
    var url = "http://smeandigitallibrary.000webhostapp.com/ebooks/read_by_cat.php";
    var client = new http.Client();
    http.Response r = await client.post(Uri.encodeFull(url),headers: {'Accept' :'Application/json'},body: {'category' :widget.category}).whenComplete(client.close);
   
      dataJson = jsonDecode(r.body);
    setState(() {
          _load =false;
        });
  }
  
  @override
    void initState() {
      super.initState();
      getData();
    }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.title+" - CERPENOVEL"),
      ),
      drawer: DrawerWidget(),
      body: _load == true ? new Container(
        child: Center(
         child:new CircularProgressIndicator()),
      ) : new Container(

        color: Colors.grey[100],
        child: new ListView.builder(
          itemCount: dataJson == null? 0 : dataJson.length,
          itemBuilder: (context,i){
            return new Card(
            elevation: 4.0,
            margin: EdgeInsets.only(top:5.0,bottom:5.0,left:10.0,right:10.0),
          
            child: new Hero(
                tag: dataJson[i]['judul_buku'],
                child: new GestureDetector(
                onTap: (){
                  Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  new DetailDart(judul_buku: dataJson[i]['judul_buku'],penulis_buku: dataJson[i]['penulis_buku'],penerbit_buku:dataJson[i]['penerbit_buku'] ,genre_buku:dataJson[i]['genre_buku'] ,tanggal_terbit: dataJson[i]['terbit_buku'],link_buku: dataJson[i]['link_buku'],kode_buku: dataJson[i]['kode_buku'],foto_buku:dataJson[i]['foto_buku'],)
              )
                  );
                        },
                        child:  new Container(
                          margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.all(2.0),
                        child: new Row(
                          children: <Widget>[
                            new Image.network(
                              dataJson[i]['foto_buku'],
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
                                    dataJson[i]['judul_buku'],
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
                                      child: Text(dataJson[i]['penulis_buku'])),
                                  new Padding(
                                    padding: EdgeInsets.all(10.0),
                                  ),
                                  new Center(
                                      child: Text(dataJson[i]['terbit_buku'])),
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
      ),
      
      
    );
  }
}