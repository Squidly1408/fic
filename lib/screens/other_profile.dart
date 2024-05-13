import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fic/screens/settings.dart';
import 'package:flutter/material.dart';

import '../home.dart';
import '../main.dart';
import 'result.dart';

class OtherProfile extends StatefulWidget {
  const OtherProfile({
    super.key,
    required this.uid,
  });
  final String uid;

  @override
  State<OtherProfile> createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile> {
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

  goToSettings() {
    setState(() {
      screen = const SettingsScreen();
    });
    screenNotifier.value = !screenNotifier.value;
  }

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
        body: FutureBuilder(
          future: users.doc(widget.uid).get(),
          builder: (context, snapshot) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            if (!snapshot.hasData) {
              const Text('Error');
            }
            if (snapshot.hasData) {
              return Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flex(
                          direction: MediaQuery.of(context).size.width < 1000
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
                                    style: const TextStyle(fontSize: 25),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${data['Username']}',
                                    style: TextStyle(
                                      color: secondaryColour2,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '${data['Email']}',
                                    style: TextStyle(
                                      color: secondaryColour2,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: secondaryColour1,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
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
                          .where('uid', isEqualTo: widget.uid)
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
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data!.docs[index]
                                            .get('description')),
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
                  ],
                ),
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
    );
  }
}
