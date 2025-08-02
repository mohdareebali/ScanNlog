import 'package:flutter/material.dart';

class FormsToReviewPage extends StatelessWidget {
  const FormsToReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> reviewFiles = []; // Empty or populated list

    return Scaffold(
      appBar: AppBar(title: const Text("Forms to Review")),
      body: reviewFiles.isEmpty
          ? const Center(child: Text("No files to review"))
          : ListView.builder(
        itemCount: reviewFiles.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(reviewFiles[index]),
        ),
      ),
    );
  }
}