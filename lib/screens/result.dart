import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fic/screens/other_profile.dart';

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
      notifier1.value = !notifier1.value;
    });
  }

  goToUserProfile(String uid) {
    setState(() {
      screen = OtherProfile(
        uid: uid,
      );
    });

    notifier1.value = !notifier1.value;
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
            child: SearchBar(
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
                                Flex(
                                  direction:
                                      MediaQuery.of(context).size.width < 1000
                                          ? Axis.vertical
                                          : Axis.horizontal,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        backgroundColor: mainColour,
                                        maxRadius: 22,
                                        child: const CircleAvatar(
                                          backgroundColor: Colors.white,
                                          maxRadius: 20,
                                          backgroundImage: NetworkImage(
                                              'https://www.shutterstock.com/image-vector/fly-wings-batman-famous-logo-600nw-2054680235.jpg'),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data!.docs[index]
                                              .get('Username'),
                                          style: TextStyle(
                                            color: secondaryColour2,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!.docs[index]
                                              .get('Email'),
                                          style: TextStyle(
                                            color: secondaryColour2,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
