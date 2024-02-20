import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fic/main.dart';

import 'package:fic/screens/home_search.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

ValueNotifier<bool> notifier1 = ValueNotifier(false);

Widget screen = const HomeSearch();

class _HomeState extends State<Home> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  final likesRef = FirebaseFirestore.instance
      .collection('Likes')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future:
          users.doc(FirebaseAuth.instance.currentUser!.uid.toString()).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
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
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      maxRadius: 30,
                                      backgroundImage: NetworkImage(
                                          'https://www.shutterstock.com/image-vector/fly-wings-batman-famous-logo-600nw-2054680235.jpg'),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              ],
                            ),
                            IconButton(
                              onPressed: () {},
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
                                                      onPressed: () {},
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
                              return const Text('Error');
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.add,
                                color: secondaryColour1,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.add,
                                color: secondaryColour1,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.add,
                                color: secondaryColour1,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            onPressed: () {},
                            color: mainColour,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 16.0),
                              child: Text(
                                'Add project',
                                style: TextStyle(
                                  color: secondaryColour1,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: notifier1,
                      builder: (context, value, child) {
                        return screen;
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const Text("loading");
      },
    );
  }
}
