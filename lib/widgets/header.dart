import 'package:fic/main.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return AppBar(
      shadowColor: Colors.red,
      titleSpacing: 0,
      actions: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width > 1000 ? 400 : 200,
                height: 40,
                child: TextFormField(
                  style: TextStyle(
                    color: secondaryColour1,
                  ),
                  controller: searchController,
                  scrollController: ScrollController(),
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: secondaryColour1,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: secondaryColour1,
                        width: 3,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: secondaryColour1,
                      ),
                    ),
                    icon: const Icon(Icons.search),
                    iconColor: secondaryColour1,
                    hintText: 'Search...',
                    hintStyle: TextStyle(
                      color: secondaryColour1,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
      automaticallyImplyLeading: false,
      backgroundColor: secondaryColour2, // black
    );
  }
}
