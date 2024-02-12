import 'package:fic/main.dart';
import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  IconData thumbsUp = Icons.thumb_up_alt_outlined;
  IconData thumbsDown = Icons.thumb_down_alt_outlined;
  var postUserPic = 'assets/images/transparent_colour_logo.png';
  var likeAmount = 4;
  var dislikeAmount = 1;
  var likesDislikes = true;
  var commentsOn = true;
  var commentsOpen = false;

  comments() {
    setState(() {
      commentsOpen = !commentsOpen;
    });
  }

  addLike() {
    setState(() {
      if (thumbsUp == Icons.thumb_up_alt_outlined) {
        thumbsUp = Icons.thumb_up_alt;
        thumbsDown = Icons.thumb_down_alt_outlined;
        likeAmount++;
      } else {
        thumbsUp = Icons.thumb_up_alt_outlined;
        likeAmount--;
      }
    });
  }

  addDisLike() {
    setState(() {
      if (thumbsDown == Icons.thumb_down_alt_outlined) {
        thumbsDown = Icons.thumb_down_alt;
        thumbsUp = Icons.thumb_up_alt_outlined;
        dislikeAmount++;
      } else {
        thumbsDown = Icons.thumb_down_alt_outlined;
        dislikeAmount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 3,
              color: Color(0x33000000),
              offset: Offset(0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      'https://picsum.photos/seed/207/600',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(12, 8, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Skate Park',
                            style: TextStyle(
                              color: secondaryColour2,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 4, 0, 0),
                            child: SelectionArea(
                              child: Text(
                                '23 Ramps',
                                style: TextStyle(
                                  color: secondaryColour3,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.settings_sharp,
                        color: secondaryColour3,
                        size: 24,
                      ),
                      Icon(
                        Icons.delete,
                        color: secondaryColour3,
                        size: 24,
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                child: Text(
                  'Notes & descriptions go here they will maybe help explain when it needs done.',
                  style: TextStyle(
                    color: secondaryColour3,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child: SelectionArea(
                        child: Text(
                          'Last Activity',
                          style: TextStyle(
                            color: Color(0xFF57636C),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite,
                            color: secondaryColour3,
                            size: 24,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
