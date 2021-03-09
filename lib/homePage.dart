import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HomePage extends StatefulWidget {
  HomePage({this.app});
  final FirebaseApp app;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseDatabase referenceDatabase = FirebaseDatabase.instance;
  DatabaseReference _movieRef;
  final movieName = "MoviesTitle";
  final movieController = TextEditingController();
  bool isLoading = true;
  @override
  void initState() {
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    _movieRef = database.reference().child('Movies');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.reference();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Movies",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              child: Column(
                children: [
                  Image.asset("assets/logo.png"),
                ],
              ),
            ),
            Center(
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Text(
                      movieName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: movieController,
                      textAlign: TextAlign.center,
                    ),
                    FlatButton(
                      child: Text(
                        "Save movie",
                      ),
                      textColor: Colors.white,
                      color: Colors.black,
                      onPressed: () {
                        ref
                            .child("Movies")
                            .push()
                            .child(movieName)
                            .set(movieController.text)
                            .asStream();
                        movieController.clear();
                      },
                    ),
                    Flexible(
                      child: FirebaseAnimatedList(
                        shrinkWrap: true,
                        query: _movieRef,
                        itemBuilder: (context, DataSnapshot snapshot,
                            Animation<double> animation, int index) {
                          return ListTile(
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () =>
                                  _movieRef.child(snapshot.key).remove(),
                            ),
                            title: Text(
                              snapshot.value['MoviesTitle'],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
