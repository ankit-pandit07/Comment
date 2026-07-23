import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/comment.dart';
import '../services/dummy.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override 
  void initState() {
    super.initState();

    loadComments();
  
  }
  Future<void> loadComments() async {
    final comments = await dummyServices.getComments();
    Provider.of<CommentProvide>(context, listen: false).buildTree(comments);
  }

@override 
Widget build(BuildContext context) {
  final provider = Provider.of<CommentProvide>(context);
  return Scaffold(
    appBar:AppBar(
      title:const Text("Nested Comments"),
    ),
     body: ListView.builder(
        itemCount: provider.rootComments.length,
        itemBuilder: (context, index) {

        final comment = provider.rootComments[index];
          return ListTile(
            title: Text(comment.author),
            subtitle: Text(comment.message),
          );
        },
      ),
    );
  }
}
