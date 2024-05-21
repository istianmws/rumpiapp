import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rumpiapp/models/postsModel.dart';

class PostData extends StatelessWidget {
  const PostData({
    super.key, required this.post,
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
            color: const Color.fromARGB(255, 225, 225, 225),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
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
              onPressed: () {},
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
