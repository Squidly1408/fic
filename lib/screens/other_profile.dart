import 'package:flutter/cupertino.dart';
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

  search(search) {
    setState(() {
      screen = Result(
        search: search,
      );
      screenNotifier.value = !screenNotifier.value;
    });
  }

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
        body: Expanded(
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
                            '______Name______',
                            style: TextStyle(
                              color: secondaryColour2,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '_________Email_________@education.nsw.gov.au',
                            style: TextStyle(
                              color: secondaryColour2,
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
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        '____________________________________________________________________________________________Description____________________________________________________________________________________________'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  color: mainColour,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '______Name______',
                                      style: TextStyle(
                                        color: secondaryColour2,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '_________Email_________@education.nsw.gov.au',
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
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              '________________________________________________________________________________________________________________________________________________________________________________________Description________________________________________________________________________________________________________________________________________________________________________________________'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                color: secondaryColour3,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.delete,
                                color: secondaryColour3,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
