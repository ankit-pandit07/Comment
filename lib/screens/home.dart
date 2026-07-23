import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/comment.dart';
import '../providers/connectivity.dart';
import '../services/dummy.dart';
import '../widgets/title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;

  int updateCount = 0;
  final int maxUpdates = 5;

  @override
  void initState() {
    super.initState();
    loadComments();
    startLiveUpdates();
  }

  Future<void> loadComments() async {
    final comments = await dummyServices.getComments();

    if (!mounted) return;

    context.read<CommentProvide>().buildTree(comments);
  }

  void startLiveUpdates() {
    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (updateCount >= maxUpdates) {
        timer?.cancel();
        return;
      }

      final comment = dummyServices.randomComment();

      context.read<CommentProvide>().addComment(comment);

      updateCount++;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CommentProvide>();
    final internet = context.watch<ConnectivityProvider>();

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Nested Comments")),

      body: Column(
        children: [
          if (!internet.isConnected)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              color: Colors.red,
              child: const Text(
                "No Internet Connection",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search comments...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: provider.search,
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
