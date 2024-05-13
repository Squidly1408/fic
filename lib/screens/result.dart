import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fic/screens/other_profile.dart';
import 'package:fic/screens/settings.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home.dart';
import '../main.dart';
import 'edit_screen.dart';

class Result extends StatefulWidget {
  const Result({super.key, required this.search});

  final String search;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  TextEditingController searchText = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('Users');

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

  goToSettings() {
    setState(() {
      screen = const SettingsScreen();
    });
    screenNotifier.value = !screenNotifier.value;
  }

  like(index) {}
  dislike(index) {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Visibility(
                  visible: MediaQuery.of(context).size.width < 1000,
                  child: IconButton(
                    onPressed: () {
                      goToSettings();
                    },
                    icon: Icon(Icons.menu, color: mainColour),
                  ),
                ),
                SearchBar(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.5),
                  backgroundColor: MaterialStatePropertyAll(secondaryColour1),
                  surfaceTintColor: MaterialStatePropertyAll(secondaryColour1),
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('Posts')
                .where('Queries', arrayContains: widget.search.toString())
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                const Text('error');
              }
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              goToUserProfile(
                                snapshot.data!.docs[index]
                                    .get('uid')
                                    .toString(),
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FutureBuilder(
                                  future: users
                                      .doc(
                                        snapshot.data!.docs[index]
                                            .get('uid')
                                            .toString(),
                                      )
                                      .get(),
                                  builder: (context, snapshot) {
                                    Map<String, dynamic> data = snapshot.data!
                                        .data() as Map<String, dynamic>;
                                    return Flex(
                                      direction:
                                          MediaQuery.of(context).size.width <
                                                  1000
                                              ? Axis.vertical
                                              : Axis.horizontal,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            backgroundColor: mainColour,
                                            maxRadius: 22,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              maxRadius: 20,
                                              child: Text(
                                                '${data['Initials']}',
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data['Username'].toString(),
                                              style: TextStyle(
                                                color: secondaryColour2,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              data['Email'].toString(),
                                              style: TextStyle(
                                                color: secondaryColour2,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                snapshot.data!.docs[index].get('description')),
                          ),
                          Visibility(
                            visible: snapshot.data!.docs[index].get('uid') ==
                                FirebaseAuth.instance.currentUser!.uid,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        screen = EditScreen(
                                          postId: snapshot.data!.docs[index]
                                              .get('pid'),
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: secondaryColour3,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance.runTransaction(
                                        (Transaction myTransaction) async {
                                      myTransaction.delete(
                                          snapshot.data!.docs[index].reference);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: secondaryColour3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: mainColour,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
