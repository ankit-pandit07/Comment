import 'package:flutter/material.dart';
import '../models/comment.dart';

import 'reply.dart';
import 'package:provider/provider.dart';
import '../providers/comment.dart';

class CommnetTitle extends StatelessWidget {
  final CommentModel comment;
  final int level;

  const CommnetTitle({super.key, required this.comment, this.level = 0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: level * 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: ListTile(
              leading: comment.children.isEmpty
                  ? const SizedBox(height: 5)
                  : IconButton(
                      icon: Icon(
                        comment.isExpanded
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_right,
                      ),
                      onPressed: () {
                        Provider.of<CommentProvide>(
                          context,
                          listen: false,
                        ).toggleExpand(comment);
                      },
                    ),
              title: Text(comment.author),
              subtitle: Text(comment.message),
            ),
          ),
          ReplyBox(
  comment: comment,
),
          if (comment.isExpanded)
            ...comment.children.map(
              (child) => CommnetTitle(comment: child, level: level + 1),
            ),
        ],
      ),
    );
  }
}
