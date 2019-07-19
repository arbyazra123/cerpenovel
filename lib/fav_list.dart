import 'package:flutter/material.dart';
import 'config/database.dart';
import 'detail_ebook.dart';
import 'toolbar_setup.dart';
import 'package:flutter/services.dart';
class Fav_list extends StatefulWidget {
  @override
  _Fav_listState createState() => _Fav_listState();
}

class _Fav_listState extends State<Fav_list> {
  List dataJson;
  bool _load = false;
  final dbHelper = DatabaseHelper.instance;
   Future<String> ambilData() async {
    this.setState(() {
          _load = true;
        });
    final r = await dbHelper.queryAllRows();
    dataJson = r;
      this.setState((){
_load = false;
      });
      
  }

  @override
    void initState() {
      super.initState();
      this.ambilData();
         SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, 
      DeviceOrientation.portraitUp ,
    ]);
    }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Favorite - CERPENOVEL"),
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
                tag: dataJson[i]['name'],
                child: new GestureDetector(
                onTap: (){
                  Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  new DetailDart(judul_buku: dataJson[i]['name'],penulis_buku: dataJson[i]['Writer'],penerbit_buku:dataJson[i]['bookPub'] ,genre_buku:dataJson[i]['category'] ,tanggal_terbit: dataJson[i]['DateBook'],link_buku: dataJson[i]['linkBook'],kode_buku: dataJson[i]['id_books'].toString(),foto_buku:dataJson[i]['pictBook'],)
              )
                  );
                        },
                        child:  new Container(
                          margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.all(2.0),
                        child: new Row(
                          children: <Widget>[
                            FadeInImage.assetNetwork(
                                                            fadeInDuration: Duration(seconds: 1),
                            fadeOutDuration: Duration(seconds: 1),
                                                            placeholder: "assets/loading.gif",
                                                            image: dataJson[i]['pictBook'],
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
                                    dataJson[i]['name'],
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
                                      child: Text(dataJson[i]['Writer'])),
                                  new Padding(
                                    padding: EdgeInsets.all(10.0),
                                  ),
                                  new Center(
                                      child: Text(dataJson[i]['DateBook'])),
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