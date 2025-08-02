import 'package:flutter/material.dart';

class ApprovedFormsPage extends StatelessWidget {
  const ApprovedFormsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> approvedFiles = []; // Empty or populated list

    return Scaffold(
      appBar: AppBar(title: const Text("Approved Forms")),
      body: approvedFiles.isEmpty
          ? const Center(child: Text("No approved files"))
          : ListView.builder(
        itemCount: approvedFiles.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(approvedFiles[index]),
        ),
      ),
    );
  }
}