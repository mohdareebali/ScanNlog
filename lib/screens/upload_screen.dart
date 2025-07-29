import 'package:flutter/material.dart';
import 'form_selector_page.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  List<String> uploadedFiles = [];

  Future<void> simulateFileUpload() async {
    // Simulate adding a file (you can replace this with real picker later)
    setState(() {
      uploadedFiles.add("sample_document.pdf");
    });
  }

  void goToFormSelector() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const FormSelectorPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFF),
      appBar: AppBar(
        title: const Text('Uploaded PDFs'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: uploadedFiles.isEmpty
            ? const Center(
          child: Text(
            'No files uploaded',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        )
            : ListView.builder(
          itemCount: uploadedFiles.length,
          itemBuilder: (context, index) {
            final file = uploadedFiles[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF0F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.picture_as_pdf, color: Colors.black54),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      file,
                      style: const TextStyle(
                          fontSize: 16, color: Colors.black87),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'uploadBtn',
            backgroundColor: Colors.blue,
            onPressed: simulateFileUpload,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 20),
          if (uploadedFiles.isNotEmpty)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: goToFormSelector,
              child: const Text(
                'Continue to Form',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }
}
