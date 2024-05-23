import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:rumpiapp/controllers/postController.dart';
import 'package:rumpiapp/models/postsModel.dart';
import 'package:rumpiapp/views/postDetailPage.dart';

class PostData extends StatefulWidget {
  const PostData({
    super.key,
    required this.post,
  });

  final PostsModel post;

  @override
  State<PostData> createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {

  final PostController _postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 220, 220, 220),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
              bottomLeft: Radius.zero,
              bottomRight: Radius.circular( 25.0)
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_rounded,
                    size: 40,
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.user!.name!,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.post.user!.email!,
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                widget.post.content!,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () async{
                await _postController.likePost(widget.post.id!);
              },
              icon: Icon(widget.post.liked! ? Icons.favorite : Icons.favorite_border,
                  color: widget.post.liked! ? Colors.red : null,),
            ),
            IconButton(
              onPressed: () {
                Get.to(() => DetailPage(post: widget.post));
              },
              icon: const Icon(Icons.comment_outlined),
            ),
          ],
        ),
        const SizedBox(
          height: 8.0,
        )
      ],
    );
  }
}
