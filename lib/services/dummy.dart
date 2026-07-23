import "../models/comment.dart";

class dummyServices {
  static Future<List<CommentModel>> getComments() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      CommentModel(
        id: 3,
        parentId: 2,
        author: "David",
        message: "Nice!",
        createdAt: DateTime.now(),
      ),
      CommentModel(
        id: 1,
        parentId: null,
        author: "John",
        message: "Hello Everyone",
        createdAt: DateTime.now(),
      ),
      CommentModel(
        id: 5,
        parentId: 3,
        author: "Emma",
        message: "Great!",
        createdAt: DateTime.now(),
      ),
      CommentModel(
        id: 2,
        parentId: 1,
        author: "Alex",
        message: "Hi John",
        createdAt: DateTime.now(),
      ),
      CommentModel(
        id: 4,
        parentId: 1,
        author: "Sarah",
        message: "Welcome",
        createdAt: DateTime.now(),
      ),
    ];
  }
}