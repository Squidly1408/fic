import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  TextEditingController search = TextEditingController();

  Search() {
    print(search.text);
  }

  Like(index) {}

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
                Search();
              },
              side: MaterialStatePropertyAll(
                BorderSide(color: secondaryColour2),
              ),
              controller: search,
              leading: IconButton(
                icon: Icon(Icons.search, color: mainColour),
                onPressed: () {
                  Search();
                },
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            CupertinoIcons.heart,
                            color: secondaryColour3,
                          ),
                        ),
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
        ),
      ),
    );
  }
}
