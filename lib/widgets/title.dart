import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/comment.dart';
import '../providers/comment.dart';
import 'reply.dart';

class CommnetTitle extends StatelessWidget {
  final CommentModel comment;
  final int level;

  const CommnetTitle({super.key, required this.comment, this.level = 0});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CommentProvide>(context);
    if (!provider.matchesSearch(comment)) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(left: level * 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: ListTile(
              leading: comment.children.isEmpty
                  ? const SizedBox(width: 24)
                  : IconButton(
                      icon: Icon(
                        comment.isExpanded
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_right,
                      ),
                      onPressed: () {
                        provider.toggleExpand(comment);
                      },
                    ),
              title: Text(comment.author),
              subtitle: Text(comment.message),
            ),
          ),
          ReplyBox(comment: comment),
          if (comment.isExpanded || provider.searchQuery.isNotEmpty)
            ...comment.children
                .where((child) => provider.matchesSearch(child))
                .map((child) => CommnetTitle(comment: child, level: level + 1)),
        ],
      ),
    );
  }
}
