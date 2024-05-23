import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:rumpiapp/models/postsModel.dart';
import 'package:rumpiapp/views/postDetailPage.dart';

class PostData extends StatelessWidget {
  const PostData({
    super.key,
    required this.post,
  });

  final PostsModel post;

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
                        post.user!.name!,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        post.user!.email!,
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
                post.content!,
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
              onPressed: () {},
              icon: const Icon(Icons.favorite_border),
            ),
            IconButton(
              onPressed: () {
                Get.to(() => DetailPage(post: post));
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
