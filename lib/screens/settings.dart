import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fic/screens/home_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home.dart';
import '../main.dart';
import 'edit_profile.dart';
import 'edit_screen.dart';
import 'new_post.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var passwordController = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  final likesRef = FirebaseFirestore.instance
      .collection('Likes')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<DocumentSnapshot>(
        future:
            users.doc(FirebaseAuth.instance.currentUser!.uid.toString()).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: secondaryColour2,
                    ),
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: ListView(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Visibility(
                                visible:
                                    MediaQuery.of(context).size.width < 1000,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        screen = const HomeSearch();
                                      });
                                      screenNotifier.value =
                                          !screenNotifier.value;
                                    },
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: secondaryColour1,
                                    )),
                              )
                            ]),
                        SizedBox(
                          width: 20,
                          child: Image.asset(
                            'assets/images/fic_logo_reverse.png',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Row(
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
                                    maxRadius: 32,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      maxRadius: 30,
                                      backgroundImage: NetworkImage(
                                          data['ProfilePic'].toString(),
                                          scale: 0.05),
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
                                        FirebaseAuth.instance.currentUser!.email
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
                                screenNotifier.value = !screenNotifier.value;
                              },
                              icon: Icon(Icons.edit_square, color: mainColour),
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
                                  isEqualTo:
                                      FirebaseAuth.instance.currentUser!.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: secondaryColour1,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(snapshot.data!.docs[index]
                                                .get('description')),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        setState(
                                                          () {
                                                            screen = EditScreen(
                                                              postId: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id,
                                                            );
                                                          },
                                                        );
                                                      },
                                                      icon: Icon(Icons.edit,
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
                                                          myTransaction.delete(
                                                              snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .reference);
                                                        });
                                                      },
                                                      icon: Icon(Icons.delete,
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
                              screenNotifier.value = !screenNotifier.value;
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
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Card(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // logo
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3,
                                              child: Image.asset(
                                                  'assets/images/fic_logo.png',
                                                  fit: BoxFit.scaleDown),
                                            ),

                                            // password login details
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: TextFormField(
                                                style: TextStyle(
                                                  color: mainColour,
                                                ),
                                                controller: passwordController,
                                                obscureText: true,
                                                cursorColor: mainColour,
                                                decoration: InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: mainColour,
                                                      width: 3,
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: mainColour,
                                                    ),
                                                  ),
                                                  hintText: 'Password...',
                                                  hintStyle: TextStyle(
                                                    color: mainColour,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // login button
                                            MaterialButton(
                                              onPressed: () {
                                                FirebaseAuth
                                                    .instance.currentUser
                                                    ?.updatePassword(
                                                        passwordController
                                                            .text);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'Password changed',
                                                    ),
                                                  ),
                                                );
                                              },
                                              color: mainColour,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 75),
                                                child: Text(
                                                  'Change Password',
                                                  style: TextStyle(
                                                      color: secondaryColour2),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              'Change Password',
                              style: TextStyle(
                                color: secondaryColour1,
                                fontSize: 13,
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
                ),
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(
              color: mainColour,
            ),
          );
        },
      ),
    );
  }
}
