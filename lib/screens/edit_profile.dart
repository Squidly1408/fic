import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home.dart';
import '../main.dart';
import 'home_search.dart';
import 'other_profile.dart';
import 'result.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
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
              TextEditingController(text: data['Description']);
          TextEditingController username =
              TextEditingController(text: data['Username']);

          return Center(
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SearchBar(
                    backgroundColor: MaterialStatePropertyAll(secondaryColour1),
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
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      children: [
                        const Text(
                          'Edit your Profile',
                          style: TextStyle(fontSize: 20),
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
                              controller: username,
                              keyboardType: TextInputType.multiline,
                              cursorColor: secondaryColour2,
                              decoration: InputDecoration(
                                labelText: 'Username',
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
                                hintText: 'Describe yourself...',
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
                          onPressed: () async {
                            FirebaseFirestore.instance
                                .collection('Users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update({'Description': description.text});
                            FirebaseFirestore.instance
                                .collection('Users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update({'Username': username.text});

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
                              'Change User Profile',
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
