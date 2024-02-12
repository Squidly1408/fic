import 'package:fic/main.dart';
import 'package:fic/screens/home_search.dart';
import 'package:fic/widgets/drawer.dart';
import 'package:fic/widgets/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

ValueNotifier<bool> notifier1 = ValueNotifier(false);

Widget setting = const HomeSearch();

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
              color: secondaryColour2,
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
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              maxRadius: 30,
                              backgroundImage: NetworkImage(
                                  'https://www.shutterstock.com/image-vector/fly-wings-batman-famous-logo-600nw-2054680235.jpg'),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '___Username___',
                                style: TextStyle(
                                  color: secondaryColour1,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '______Email______@education.nsw.gov.au',
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
                        icon: Icon(Icons.edit_square, color: secondaryColour1),
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
                      color: secondaryColour1,
                    ),
                  ),
                  Center(
                    child: Text(
                      'Projects',
                      style: TextStyle(
                        color: secondaryColour1,
                        fontSize: 13,
                      ),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                            color: secondaryColour2,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      color: secondaryColour1,
                    ),
                  )
                ],
              ),
            ),
            const VerticalDivider(thickness: 3),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: notifier1,
                builder: (context, value, child) {
                  return setting;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final Widget setting;
  const _CustomListTile(
      {Key? key,
      required this.title,
      required this.icon,
      this.trailing,
      required this.setting})
      : super(key: key);

  @override
  State<_CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<_CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      leading: Icon(widget.icon),
      trailing: widget.trailing ?? const Icon(CupertinoIcons.forward, size: 18),
      onTap: () {
        setState(() {
          setting = widget.setting;
        });
        notifier1.value = !notifier1.value;
      },
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toUpperCase(),
            style:
                Theme.of(context).textTheme.headline3?.copyWith(fontSize: 16),
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
