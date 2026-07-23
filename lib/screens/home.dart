import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/comment.dart';
import '../services/dummy.dart';
import '../widgets/title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    loadComments();
    startLiveUpdates();
  }

  Future<void> loadComments() async {
    final comments = await dummyServices.getComments();

    Provider.of<CommentProvide>(context, listen: false).buildTree(comments);
  }

  void startLiveUpdates() {
    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      final comment = dummyServices.randomComment();

      Provider.of<CommentProvide>(context, listen: false).addComment(comment);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CommentProvide>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Nested Comments")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search comments...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                Provider.of<CommentProvide>(
                  context,
                  listen: false,
                ).search(value);
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: provider.rootComments.length,
              itemBuilder: (context, index) {
                return CommnetTitle(comment: provider.rootComments[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
