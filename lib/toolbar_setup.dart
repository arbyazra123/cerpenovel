import 'package:flutter/material.dart';
import 'config/database.dart';
import 'category_e.dart';
import 'fav_list.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
  
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final GlobalKey<ScaffoldState> _scaffoldState = new GlobalKey<ScaffoldState>();
  final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      
      width: 250.0,
              child: Drawer(

            
                child:new ListView(
                  padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                child: new Center(child: Text('CERPENOVEL',style: TextStyle(fontSize: 25.0,color: Colors.grey[100],fontWeight: FontWeight.bold),)),
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
            ),
                  ListTile(
                    title: Text("Home"),
                    trailing: Icon(Icons.home),
                    onTap: (){
                      Navigator.pushNamed(context, "/Main");
                    },
                  ),
                  ListTile(
                    title: Text("Cerpen"),
                    trailing: Icon(Icons.book),
                    onTap: (){
                       Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context) => new CatView(category: "cerpen",title: "Cerpen",)
                          ));
                    },
                  ),
                  ExpansionTile(
                    title: Text("Novel"),
                    children: <Widget>[
                      new ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                        
                        title: Text("Adult"),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context) => new CatView(category: "adul",title: "Adult",)
                          ));
                        },
                      ),
                      new ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                        
                        title: Text("Romance"),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context) => new CatView(category: "roman",title: "Romance",)
                          ));
                        },
                      ),
                      new ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                        
                        title: Text("Horror"),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context) => new CatView(category: "horror",title: "Horror",)
                          ));
                        },
                      ),
                      new ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                        
                        title: Text("Humour"),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context) => new CatView(category: "humo",title: "Humour",)
                          ));
                        },
                      ),
                      new ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                        title: Text("Fantasy"),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context) => new CatView(category: "fantas",title: "Fantasy",)
                          ));
                        },
                      ),
                      
                    ],
                  ),
                  ListTile(
                    
                    title: Text("My Favorite"),
                    trailing: Icon(Icons.star),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) => new Fav_list()
                      ));
                    },
                  ),
                  ListTile(
                    title: Text("About"),
                    trailing: Icon(Icons.more),
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("About"),
                            content: new Table(
                            
                            columnWidths: {1: FractionColumnWidth(.60)},
                            
                          children: [
                            
                            TableRow(children: [
                             
               new Text("Name",style: TextStyle(fontSize: 15.0,color: Colors.grey[500])),
               new Text(" CERPENOVEL",style: TextStyle(fontSize: 15.0,color: Colors.grey[800]))
                            ]),
                            TableRow(children: [
               new Text("Version",style: TextStyle(fontSize: 15.0,color: Colors.grey[500])),
               new Text(" 1.0.0",style: TextStyle(fontSize: 15.0,color: Colors.grey[800]))
                            ]),
                            TableRow(children: [
               new Text("Developer",style: TextStyle(fontSize: 15.0,color: Colors.grey[500]),),
               new Text(" Jefar Studios",style: TextStyle(fontSize: 15.0,color: Colors.grey[800])),
               
                            ]),
                            TableRow(children: [
               new Text("Email  ",style: TextStyle(fontSize: 15.0,color: Colors.grey[500]),),
               new Text(" jefarstudios@gmail.com",style: TextStyle(fontSize: 15.0,color: Colors.grey[800])),
               
                            ]),
                          ],
                        ),
                        actions: <Widget>[
                          new FlatButton(
                            child: Text("Close"),
                            onPressed: (){
              Navigator.of(context).pop();
                            },
                          )
                        ],
                          );
                        }

                      );
                    },
                  ),

                ],
            ),
            // new ListView.builder(
            //  itemCount: getList().length,
            //  itemBuilder: (context,i){
            //    return new ListTile(
            //       title: Text("Kode Buku "+getList()[i]),
                   
                    
            //    );
            //  },
            // )
            
                    
          
        ),
    );
  }
}