import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:rumpiapp/controllers/postController.dart';
import 'package:rumpiapp/models/postsModel.dart';
import 'package:rumpiapp/views/widgets/inputWidget.dart';
import 'package:rumpiapp/views/widgets/postDataWidget.dart';

class DetailPage extends StatefulWidget {
  DetailPage({super.key, required this.post});

  final PostsModel post;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextEditingController _commentController = TextEditingController();
  final PostController _postController = Get.put(PostController());

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _postController.getComments(widget.post.id!);
    });

    _postController.getComments(widget.post.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Detail Gosipan',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            PostData(post: widget.post),
            const Center(
              child: Text(
                'komentar gosip',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              child: Obx(() {
                return _postController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          // shrinkWrap: true,
                          itemCount: _postController.comments.value.length,
                          itemBuilder: (context, index) {
                            _postController.comments.value.sort(
                                (a, b) => a.createdAt!.compareTo(b.createdAt!));

                            DateTime dateTime = _postController
                                .comments.value[index].createdAt!;
                            String dateOnly =
                                "${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
                            return

                                // PostData(post: widget.post);
                                Container(
                              margin: const EdgeInsets.only(bottom: 8.0),
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0.0),
                                  topRight: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                ),
                                color: Colors.grey[200],
                              ),
                              child: ListTile(
                                trailing: Text(
                                  dateOnly,
                                  style: const TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                leading: Icon(Icons.person_outline_outlined),
                                title: Text(_postController
                                    .comments.value[index].user!.username!),
                                subtitle: Text(_postController
                                    .comments.value[index].body!),
                              ),
                            );
                          },
                        ),
                      );
              }),
            ),
            SizedBox(
              height: 8.0,
            ),
            InputWidget(
              label: '',
              hint: 'Tanggapi gosip ini...',
              prefixIcon: Icons.message_rounded,
              isPassword: false,
              controller: _commentController,
            ),
            SizedBox(
              height: 8.0,
            ),
            ElevatedButton(
              clipBehavior: Clip.none,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black54,
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                minimumSize: const Size(250.0, 50.0),
              ),
              onPressed: () async {
                await _postController.createComment(
                  widget.post.id!,
                  _commentController.text.trim(),
                );
                _commentController.clear();
                _postController.getComments(widget.post.id!);
              },
              child: const Text(
                'Kirim',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
