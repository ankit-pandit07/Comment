class CommentModel {
  final int id;
  final int? parentId;
  final String author;
  final String message;
  final DateTime createdAt;

  List<CommentModel> children;

  CommentModel({
    required this.id,
    this.parentId,
    required this.author,
    required this.message,
    required this.createdAt,
    this.children = const [],
  });

    factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json["id"],
      parentId: json["parentId"],
      author: json["author"],
      message: json["message"],
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }
}