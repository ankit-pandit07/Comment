import 'package:flutter/material.dart';
import '../models/comment.dart';

class CommentProvide extends ChangeNotifier {
  final List<CommentModel> _rootComments = [];

  final Map<int, CommentModel> _commentMap = {};

  final Map<int, List<CommentModel>> _pendingChildren = {};

  List <CommentModel> get rootComments => _rootComments;

void toggleExpand(CommentModel comment) {
  comment.isExpanded = !comment.isExpanded;
  notifyListeners();
}

void addReply({
  required CommentModel parent,
  required String message,
}) {
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

  void buildTree(List<CommentModel> comments) {
   _rootComments.clear();
    _commentMap.clear();
    _pendingChildren.clear();


      for (var comment in comments) {
        comment.children=[];
        _commentMap[comment.id]=comment;
      }
      for (var comment in comments) {
        if(comment.parentId==null){
          _rootComments.add(comment);
        }else{
          final parent=_commentMap[comment.parentId];

          if(parent!=null){
            parent.children.add(comment);

          }else{
            _pendingChildren.putIfAbsent(comment.parentId!, () => []);
            _pendingChildren[comment.parentId!]!.add(comment);
          }
        }

        if(_pendingChildren.containsKey(comment.id)){
          comment.children.addAll(_pendingChildren[comment.id]!);
          _pendingChildren.remove(comment.id);
        }
      }
      notifyListeners();
  }
}