import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/model/allscreens.dart';
import 'package:final_project/model/users.dart';
import 'package:final_project/resources/firestore_methods.dart';
import 'package:final_project/resources/user_providers.dart';
import 'package:final_project/resources/utils.dart';
import 'package:final_project/widgets/upvote_downvote.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final Map snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late int upvoteDownVote;
  bool isButtonActive = true;
  int commentLen = 0;

  

  @override
  void initState() {
    super.initState();
    getComments();
    upvoteDownVote = widget.snap['likes'].length;
  }

  void getComments() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();

      commentLen = snap.docs.length;
    } catch (err) {
      showSnackBar(err.toString(), context);
    }

    setState(() {});
  }

  

  bool isLikeAnimatingValue = false;
  @override
  Widget build(BuildContext context) {
    final Users user = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    widget.snap['profImage'],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap['username'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shrinkWrap: true,
                          children: ['Delete']
                              .map(
                                (e) => InkWell(
                                  onTap: () async {
                                    FirestoreMethods()
                                        .deletePost(widget.snap['postId']);
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                    child: Text(e),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () async {
              await FirestoreMethods().upVotePost(
                widget.snap['postId'],
                user.uid,
                widget.snap['likes'],
              );
              setState(() {
                isButtonActive = true;
                isLikeAnimatingValue = true;
                upvoteDownVote = widget.snap['likes'].length;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Image.network(
                    widget.snap['postUrl'],
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimatingValue ? 1 : 0,
                  child: Upvote(
                    child: const Icon(
                      Icons.expand_less,
                      color: Colors.blueAccent,
                      size: 120,
                    ),
                    isAnimating: isLikeAnimatingValue,
                    duration: const Duration(milliseconds: 400),
                    onEnd: () {
                      setState(() {
                        isLikeAnimatingValue = false;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommentScreen(
                      snap: widget.snap,
                    ),
                  ),
                ),
                icon: const Icon(
                  Icons.comment_outlined,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                ),
              ),
              Upvote(
                isAnimating: widget.snap['likes'].contains(user.uid),
                smallUpvote: true,
                child: IconButton(
                  onPressed: () async {
                    await FirestoreMethods().upVotePost(
                      widget.snap['postId'],
                      user.uid,
                      widget.snap['likes'],
                    );
                    setState(() {
                      isButtonActive = true;
                      upvoteDownVote = widget.snap['likes'].length;
                    });
                  },
                  icon: widget.snap['likes'].contains(user.uid)
                      ? const Icon(
                          Icons.expand_less,
                          color: Colors.blueAccent,
                        )
                      : const Icon(Icons.expand_less),
                ),
              ),
              Text('$upvoteDownVote'),
              IconButton(
                onPressed: isButtonActive
                    ? () {
                        setState(() {
                          upvoteDownVote = upvoteDownVote - 1;
                          isButtonActive = false;
                        });
                      }
                    : null,
                icon: const Icon(
                  Icons.expand_more,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.bookmark_border),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: widget.snap['username'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: ' ${widget.snap['description']}',
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('posts')
                            .doc(widget.snap['postId'])
                            .collection('comments')
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          return Text(
                            'View all ${snapshot.data?.docs.length} comments',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          );
                        }),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    DateFormat.yMMMd().format(
                      widget.snap['datePublished'].toDate(),
                    ),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
