import 'package:flutter/material.dart';
import 'form1_setup_page.dart';
import 'form2_setup_page.dart';
import 'form3_setup_page.dart'; // ✅ Add this import

class FormSelectorPage extends StatelessWidget {
  const FormSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('FormSelector'),
        elevation: 1,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Choose a Form Type',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                  )
                ],
              ),
              child: Column(
                children: [
                  _formButton(context, 'Form 1', const Form1SetupPage()),
                  const SizedBox(height: 12),
                  _formButton(context, 'Form 2', Form2SetupPage()),
                  const SizedBox(height: 12),
                  _formButton(context, 'Form 3', Form3SetupPage()), // ✅ Activate Form 3
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formButton(BuildContext context, String text, Widget? page) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: page != null ? const Color(0xFF1A3D6D) : Colors.grey.shade400,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: page != null
            ? () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        }
            : null,
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}