import 'package:flutter/material.dart';

class HomeSearch extends StatefulWidget {
  const HomeSearch({super.key});

  @override
  State<HomeSearch> createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'title',
              style: TextStyle(fontSize: 20),
            ),
            Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vitae ligula blandit, auctor eros eu, tempor quam. Pellentesque suscipit velit ante, non tincidunt dui volutpat ac. Praesent porta sodales eleifend. Donec ac sem at enim fermentum ullamcorper. Curabitur ante felis, ultricies in risus id, rutrum mattis quam. Etiam lacinia sem ipsum, et gravida ex malesuada at. Suspendisse tristique lacus non tempor gravida. Duis euismod eros ut mauris congue ultrices ut non ipsum. Ut congue dolor non leo fringilla, nec condimentum mauris bibendum.'),
            Divider(
              thickness: 3,
            ),
            Text(
              'title',
              style: TextStyle(fontSize: 20),
            ),
            Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vitae ligula blandit, auctor eros eu, tempor quam. Pellentesque suscipit velit ante, non tincidunt dui volutpat ac. Praesent porta sodales eleifend. Donec ac sem at enim fermentum ullamcorper. Curabitur ante felis, ultricies in risus id, rutrum mattis quam. Etiam lacinia sem ipsum, et gravida ex malesuada at. Suspendisse tristique lacus non tempor gravida. Duis euismod eros ut mauris congue ultrices ut non ipsum. Ut congue dolor non leo fringilla, nec condimentum mauris bibendum.'),
            Divider(thickness: 3),
            Text(
              'title',
              style: TextStyle(fontSize: 20),
            ),
            Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vitae ligula blandit, auctor eros eu, tempor quam. Pellentesque suscipit velit ante, non tincidunt dui volutpat ac. Praesent porta sodales eleifend. Donec ac sem at enim fermentum ullamcorper. Curabitur ante felis, ultricies in risus id, rutrum mattis quam. Etiam lacinia sem ipsum, et gravida ex malesuada at. Suspendisse tristique lacus non tempor gravida. Duis euismod eros ut mauris congue ultrices ut non ipsum. Ut congue dolor non leo fringilla, nec condimentum mauris bibendum.'),
          ],
        ),
      ),
    );
  }
}
