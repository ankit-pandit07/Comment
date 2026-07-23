import 'package:flutter/material.dart';
import '../models/comment.dart';

class CommentProvide extends ChangeNotifier {
  final List<CommentModel> _rootComments = [];

  final Map<int, CommentModel> _commentMap = {};

  final Map<int, List<CommentModel>> _pendingChildren = {};

  String _searchQuery = "";

  String get searchQuery => _searchQuery;

  List<CommentModel> get rootComments => _rootComments;

  void search(String value) {
    _searchQuery = value.toLowerCase();
    notifyListeners();
  }

  void toggleExpand(CommentModel comment) {
    comment.isExpanded = !comment.isExpanded;
    notifyListeners();
  }

  void addReply({required CommentModel parent, required String message}) {
    final reply = CommentModel(
      id: DateTime.now().millisecondsSinceEpoch,
      parentId: parent.id,
      author: "You",
      message: message,
      createdAt: DateTime.now(),
    );

    parent.children.add(reply);

    notifyListeners();
  }

  bool matchesSearch(CommentModel comment) {
    if (_searchQuery.isEmpty) return true;

    final selfMatch =
        comment.author.toLowerCase().contains(_searchQuery) ||
        comment.message.toLowerCase().contains(_searchQuery);

    if (selfMatch) return true;

    for (final child in comment.children) {
      if (matchesSearch(child)) {
        return true;
      }
    }

    return false;
  }

  void addComment(CommentModel comment) {
    _commentMap[comment.id] = comment;

    if (comment.parentId == null) {
      _rootComments.add(comment);
    } else {
      final parent = _commentMap[comment.parentId];

      if (parent != null) {
        parent.children.add(comment);
      } else {
        _pendingChildren.putIfAbsent(comment.parentId!, () => []);
        _pendingChildren[comment.parentId!]!.add(comment);
      }
    }

    if (_pendingChildren.containsKey(comment.id)) {
      comment.children.addAll(_pendingChildren[comment.id]!);
      _pendingChildren.remove(comment.id);
    }

    notifyListeners();
  }

  void buildTree(List<CommentModel> comments) {
    _rootComments.clear();
    _commentMap.clear();
    _pendingChildren.clear();

    for (var comment in comments) {
      comment.children = [];
      _commentMap[comment.id] = comment;
    }
    for (var comment in comments) {
      if (comment.parentId == null) {
        _rootComments.add(comment);
      } else {
        final parent = _commentMap[comment.parentId];

        if (parent != null) {
          parent.children.add(comment);
        } else {
          _pendingChildren.putIfAbsent(comment.parentId!, () => []);
          _pendingChildren[comment.parentId!]!.add(comment);
        }
      }

      if (_pendingChildren.containsKey(comment.id)) {
        comment.children.addAll(_pendingChildren[comment.id]!);
        _pendingChildren.remove(comment.id);
      }
    }
    notifyListeners();
  }
}
