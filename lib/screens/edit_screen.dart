import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fic/screens/home_search.dart';
import 'package:flutter/material.dart';

import '../home.dart';
import '../main.dart';
import 'other_profile.dart';
import 'result.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.postId});
  final String postId;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  CollectionReference posts = FirebaseFirestore.instance.collection('Posts');
  TextEditingController searchText = TextEditingController();

  search(search) {
    setState(() {
      screen = Result(
        search: search,
      );
      screenNotifier.value = !screenNotifier.value;
    });
  }

  goToUserProfile(String uid) {
    setState(() {
      screen = OtherProfile(
        uid: uid,
      );
    });

    screenNotifier.value = !screenNotifier.value;
  }

  like(index) {}
  dislike(index) {}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: posts.doc(widget.postId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          TextEditingController description =
              TextEditingController(text: data['description']);
          TextEditingController query1 =
              TextEditingController(text: data['Queries'][0]);
          TextEditingController query2 =
              TextEditingController(text: data['Queries'][1]);
          TextEditingController query3 =
              TextEditingController(text: data['Queries'][2]);
          return Center(
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.menu, color: mainColour),
                      ),
                      SearchBar(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.5),
                        backgroundColor:
                            MaterialStatePropertyAll(secondaryColour1),
                        surfaceTintColor:
                            MaterialStatePropertyAll(secondaryColour1),
                        hintText: 'Search...',
                        onSubmitted: (value) {
                          search(value);
                        },
                        side: MaterialStatePropertyAll(
                          BorderSide(color: secondaryColour2),
                        ),
                        controller: searchText,
                        leading: IconButton(
                          icon: Icon(Icons.search, color: mainColour),
                          onPressed: () {
                            search(searchText);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      children: [
                        const Text(
                          'Edit your Project',
                          style: TextStyle(fontSize: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: TextFormField(
                              maxLines: null,
                              expands: true,
                              style: TextStyle(
                                color: secondaryColour2,
                              ),
                              controller: description,
                              keyboardType: TextInputType.multiline,
                              cursorColor: secondaryColour2,
                              decoration: InputDecoration(
                                labelText: 'Description',
                                labelStyle: TextStyle(color: secondaryColour2),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: secondaryColour2,
                                    width: 3,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: secondaryColour2,
                                  ),
                                ),
                                hintText: 'Describe your project...',
                                hintStyle: TextStyle(
                                  color: secondaryColour2,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: TextFormField(
                              maxLines: null,
                              expands: true,
                              style: TextStyle(
                                color: secondaryColour2,
                              ),
                              controller: query1,
                              keyboardType: TextInputType.multiline,
                              cursorColor: secondaryColour2,
                              decoration: InputDecoration(
                                labelText: 'Query 1',
                                labelStyle: TextStyle(color: secondaryColour2),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: secondaryColour2,
                                    width: 3,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: secondaryColour2,
                                  ),
                                ),
                                hintText: 'Search query 1...',
                                hintStyle: TextStyle(
                                  color: secondaryColour2,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: TextFormField(
                              maxLines: null,
                              expands: true,
                              style: TextStyle(
                                color: secondaryColour2,
                              ),
                              controller: query2,
                              keyboardType: TextInputType.multiline,
                              cursorColor: secondaryColour2,
                              decoration: InputDecoration(
                                labelText: 'Query 2',
                                labelStyle: TextStyle(color: secondaryColour2),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: secondaryColour2,
                                    width: 3,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: secondaryColour2,
                                  ),
                                ),
                                hintText: 'Search query 2...',
                                hintStyle: TextStyle(
                                  color: secondaryColour2,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: TextFormField(
                              maxLines: null,
                              expands: true,
                              style: TextStyle(
                                color: secondaryColour2,
                              ),
                              controller: query3,
                              keyboardType: TextInputType.multiline,
                              cursorColor: secondaryColour2,
                              decoration: InputDecoration(
                                labelText: 'Query 3',
                                labelStyle: TextStyle(color: secondaryColour2),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: secondaryColour2,
                                    width: 3,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: secondaryColour2,
                                  ),
                                ),
                                hintText: 'Search query 3...',
                                hintStyle: TextStyle(
                                  color: secondaryColour2,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('Posts')
                                .doc(widget.postId)
                                .update({'description': description.text});
                            FirebaseFirestore.instance
                                .collection('Posts')
                                .doc(widget.postId)
                                .update(
                              {
                                'Queries': [
                                  query1.text,
                                  query2.text,
                                  query3.text
                                ]
                              },
                            );
                            setState(() {
                              screen = HomeSearch();
                            });
                            screenNotifier.value = !screenNotifier.value;
                          },
                          color: secondaryColour2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 75),
                            child: Text(
                              'Change Post',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        return Text("loading");
      },
    );
  }
}
