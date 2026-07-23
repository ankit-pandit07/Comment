import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/comment.dart';
import '../providers/comment.dart';

class ReplyBox extends StatefulWidget {
  final CommentModel comment;
  const ReplyBox({super.key, required this.comment});

  @override
  State<ReplyBox> createState() => _ReplyBoxState();
}

class _ReplyBoxState extends State<ReplyBox> {
  final TextEditingController controller = TextEditingController();
   bool isReplying = false;

   @override 
   Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            setState((){
              isReplying = !isReplying;
            });
          },
          child: const Text('Reply'),
        ),

   if(isReplying)

          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              children: [

                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "Write a reply",
                  ),
                ),

                ElevatedButton(
                  onPressed: () {

                    if(controller.text.trim().isEmpty) return;

                    Provider.of<CommentProvide>(
                      context,
                      listen: false,
                    ).addReply(
                      parent: widget.comment,
                      message: controller.text,
                    );

                    controller.clear();

                    setState(() {
                      isReplying = false;
                    });

                  },
                  child: const Text("Send"),
                )

              ],
            ),
          )

      ],
    );
  }
}