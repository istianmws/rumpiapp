import 'dart:math';

import 'package:flutter/material.dart';

class PostField extends StatelessWidget {
  const PostField({
    super.key, required this.controller, required this.hintText,
  });

  final TextEditingController controller ;
  final String hintText ;

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: const EdgeInsets.all(32.0),
      width: double.infinity,
      height: 100.0,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 225, 225, 225),
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      child:  TextField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          hoverColor: Colors.yellow,
          hintText: hintText,
        ),
      ),
    );
  }
}