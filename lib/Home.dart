import 'package:fic/main.dart';
import 'package:fic/screens/home_search.dart';
import 'package:fic/screens/other_profile.dart';
import 'package:fic/screens/result.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

ValueNotifier<bool> notifier1 = ValueNotifier(false);

Widget screen = const Result();

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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
                                  color: secondaryColour1,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '_________Email_________@education.nsw.gov.au',
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
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: secondaryColour1,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                    '____________________________________________________________________________________________project____________________________________________________________________________________________'),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Column(
                                      children: [
                                        Icon(CupertinoIcons.heart_fill),
                                        Text(
                                          '12',
                                          style: TextStyle(
                                            fontSize: 8,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.edit,
                                              color: secondaryColour2),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.delete,
                                              color: secondaryColour2),
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
                      color: mainColour,
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
}
