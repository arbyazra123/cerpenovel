import 'package:flutter/material.dart';
import 'config/database.dart';
import 'category_e.dart';
import 'fav_list.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();
  final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: 250.0,
      child: Drawer(
        child: new ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: new Center(
                  child: Text(
                'NAC Book Library',
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.grey[100],
                    fontWeight: FontWeight.bold),
              )),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text("Home"),
              trailing: Icon(Icons.home),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/Main", (route) => false);
              },
            ),
            ListTile(
              title: Text("Cerpen"),
              trailing: Icon(Icons.book),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => new CatView(
                              category: "cerpen",
                              title: "Cerpen",
                            )),
                    (route) => false);
              },
            ),
            ExpansionTile(
              title: Text("Novel"),
              children: <Widget>[
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                  title: Text("Adult"),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => new CatView(
                                  category: "adul",
                                  title: "Adult",
                                )),
                        (route) => false);
                  },
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                  title: Text("Romance"),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => new CatView(
                                  category: "roman",
                                  title: "Romance",
                                )),
                        (route) => false);
                  },
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                  title: Text("Horror"),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => new CatView(
                                  category: "horror",
                                  title: "Horror",
                                )),
                        (route) => false);
                  },
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                  title: Text("Humour"),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => new CatView(
                                  category: "humo",
                                  title: "Humour",
                                )),
                        (route) => false);
                  },
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                  title: Text("History"),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => new CatView(
                                  category: "history",
                                  title: "History",
                                )),
                        (route) => false);
                  },
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                  title: Text("Fantasy"),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => new CatView(
                                  category: "fantas",
                                  title: "Fantasy",
                                )),
                        (route) => false);
                  },
                ),
              ],
            ),
            ListTile(
              title: Text("My Favorite"),
              trailing: Icon(Icons.star),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => new Fav_list()),
                    (route) => false);
              },
            ),
            ListTile(
              title: Text("About"),
              trailing: Icon(Icons.more),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("About"),
                        content: new Table(
                          columnWidths: {1: FractionColumnWidth(.60)},
                          children: [
                            TableRow(children: [
                              new Text("Name",
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.grey[500])),
                              new Text(" NAC Book Library",
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.grey[800]))
                            ]),
                            TableRow(children: [
                              new Text("Version",
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.grey[500])),
                              new Text(" 1.0.0",
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.grey[800]))
                            ]),
                            TableRow(children: [
                              new Text(
                                "Developer",
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.grey[500]),
                              ),
                              new Text(" Narendra Daily",
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.grey[800])),
                            ]),
                          ],
                        ),
                        actions: <Widget>[
                          new FlatButton(
                            child: Text("Close"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
