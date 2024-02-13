import 'package:fic/Home.dart';
import 'package:fic/main.dart';
import 'package:fic/screens/result.dart';
import 'package:flutter/material.dart';

class HomeSearch extends StatefulWidget {
  const HomeSearch({super.key});

  @override
  State<HomeSearch> createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  TextEditingController search = TextEditingController();

  Search() {
    print(search.text);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Image.asset(
                'assets/images/fic_logo.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            SearchBar(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'This is a student created project, aimed at increasing collaboration between students. Please use this tool with respect to yourself and others, thankyou!',
                style: TextStyle(color: secondaryColour3),
              ),
            )
          ],
        ),
      ),
    );
  }
}
