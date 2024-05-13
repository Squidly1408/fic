import 'package:fic/home.dart';
import 'package:fic/main.dart';
import 'package:fic/screens/result.dart';
import 'package:fic/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeSearch extends StatefulWidget {
  const HomeSearch({super.key});

  @override
  State<HomeSearch> createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: MediaQuery.of(context).size.width < 1000,
          child: IconButton(
            onPressed: () {
              setState(() {
                screen = const SettingsScreen();
              });
              screenNotifier.value = !screenNotifier.value;
            },
            icon: Icon(Icons.menu, color: mainColour),
          ),
        ),
        Center(
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
                    search(value.toLowerCase());
                  },
                  side: MaterialStatePropertyAll(
                    BorderSide(color: secondaryColour2),
                  ),
                  controller: searchText,
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7),
                  leading: IconButton(
                    icon: Icon(Icons.search, color: mainColour),
                    onPressed: () {
                      search(searchText);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'This is a student created project, aimed at increasing collaboration between students. Please use this tool with respect to yourself and others, thankyou!',
                    style: TextStyle(color: secondaryColour3, fontSize: 10),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
