import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fic/main.dart';
import 'package:fic/screens/edit_profile.dart';
import 'package:fic/screens/edit_screen.dart';

import 'package:fic/screens/home_search.dart';
import 'package:fic/screens/new_post.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

ValueNotifier<bool> screenNotifier = ValueNotifier(false);
ValueNotifier<bool> settingNotifer = ValueNotifier(false);

Widget screen = const HomeSearch();

class _HomeState extends State<Home> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width > 1000
        ? FutureBuilder<DocumentSnapshot>(
            future: users
                .doc(FirebaseAuth.instance.currentUser!.uid.toString())
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return const Center(child: Text("Document does not exist"));
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return NotificationListener(
                  child: Scaffold(
                    backgroundColor: const Color(0xffffffff),
                    body: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: secondaryColour2,
                            ),
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: ListView(
                              children: [
                                SizedBox(
                                  width: 20,
                                  child: Image.asset(
                                    'assets/images/fic_logo_reverse.png',
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flex(
                                      direction:
                                          MediaQuery.of(context).size.width <
                                                  1250
                                              ? Axis.vertical
                                              : Axis.horizontal,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            backgroundColor: mainColour,
                                            maxRadius: 32,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              maxRadius: 30,
                                              child: Text(
                                                '${data['Initials']}',
                                                style: const TextStyle(
                                                    fontSize: 25),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${data['Username']}',
                                                style: TextStyle(
                                                  color: secondaryColour1,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                FirebaseAuth
                                                    .instance.currentUser!.email
                                                    .toString(),
                                                style: TextStyle(
                                                  color: secondaryColour1,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          screen = const EditProfile();
                                        });
                                        screenNotifier.value =
                                            !screenNotifier.value;
                                      },
                                      icon: Icon(Icons.edit_square,
                                          color: mainColour),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: secondaryColour1,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('${data['Description']}'),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Divider(
                                    color: mainColour,
                                  ),
                                ),
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('Posts')
                                      .where('uid',
                                          isEqualTo: FirebaseAuth
                                              .instance.currentUser!.uid)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: secondaryColour1,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(15))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(snapshot
                                                        .data!.docs[index]
                                                        .get('description')),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            IconButton(
                                                              onPressed: () {
                                                                setState(
                                                                  () {
                                                                    screen =
                                                                        EditScreen(
                                                                      postId: snapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                          .id,
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              icon: Icon(
                                                                  Icons.edit,
                                                                  color:
                                                                      secondaryColour2),
                                                            ),
                                                            IconButton(
                                                              onPressed: () {
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .runTransaction(
                                                                        (Transaction
                                                                            myTransaction) async {
                                                                  myTransaction
                                                                      .delete(snapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                          .reference);
                                                                });
                                                              },
                                                              icon: Icon(
                                                                  Icons.delete,
                                                                  color:
                                                                      secondaryColour2),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                    if (snapshot.hasError) {
                                      return const Center(child: Text('Error'));
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        screen = const NewPost();
                                      });
                                      screenNotifier.value =
                                          !screenNotifier.value;
                                    },
                                    color: mainColour,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 20.0),
                                      child: Text(
                                        'Add project',
                                        style: TextStyle(
                                          color: secondaryColour1,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: TextButton(
                                    onPressed: () {
                                      FirebaseAuth.instance.signOut();
                                    },
                                    child: Text(
                                      'Log out',
                                      style: TextStyle(
                                        color: secondaryColour1,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ValueListenableBuilder(
                              valueListenable: screenNotifier,
                              builder: (context, value, child) {
                                return screen;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return const Center(
                child: Text(
                  'Loading...',
                  style: TextStyle(
                    color: Color(0xff000000),
                  ),
                ),
              );
            },
          )
        : Expanded(
            child: ValueListenableBuilder(
              valueListenable: screenNotifier,
              builder: (context, value, child) {
                return screen;
              },
            ),
          );
  }
}
