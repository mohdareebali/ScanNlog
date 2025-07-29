import 'package:flutter/material.dart';
import 'dart:math';

class ManagerSelectionPage extends StatefulWidget {
  const ManagerSelectionPage({super.key});

  @override
  State<ManagerSelectionPage> createState() => _ManagerSelectionPageState();
}

class _ManagerSelectionPageState extends State<ManagerSelectionPage> {
  List<Map<String, String>> meEngineers = [{'email': '', 'password': ''}];
  List<Map<String, String>> qcEngineers = [{'email': '', 'password': ''}];

  void generatePassword(List<Map<String, String>> list, int index, bool isME) {
    final password = getRandomPassword();
    setState(() {
      if (isME) {
        meEngineers[index]['password'] = password;
      } else {
        qcEngineers[index]['password'] = password;
      }
    });
  }

  String getRandomPassword() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final rand = Random();
    return List.generate(8, (_) => chars[rand.nextInt(chars.length)]).join();
  }

  void addEngineer(bool isME) {
    setState(() {
      if (isME) {
        meEngineers.add({'email': '', 'password': ''});
      } else {
        qcEngineers.add({'email': '', 'password': ''});
      }
    });
  }

  void updateEmail(bool isME, int index, String email) {
    setState(() {
      if (isME) {
        meEngineers[index]['email'] = email;
      } else {
        qcEngineers[index]['email'] = email;
      }
    });
  }

  Widget engineerField(bool isME, List<Map<String, String>> engineers) {
    return Column(
      children: List.generate(engineers.length, (index) {
        final engineer = engineers[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    fillColor: Color(0xFFF0F4F8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onChanged: (val) => updateEmail(isME, index, val),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => generatePassword(engineers, index, isME),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(12),
                  backgroundColor: const Color(0xFF1C3A63),
                ),
                child: const Text('🔐'),
              ),
              const SizedBox(width: 6),
              ElevatedButton(
                onPressed: () {
                  final email = engineer['email'] ?? '';
                  final password = engineer['password'] ?? '';
                  if (email.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter email and generate password')),
                    );
                  } else {
                    // Implement sharing logic or clipboard copy if needed
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(12),
                  backgroundColor: const Color(0xFF1C3A63),
                ),
                child: const Text('📤'),
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assign Engineers')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Assign Engineers',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1C3A63),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add ME-Engineers and QC-Engineers',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('ME-Engineers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    engineerField(true, meEngineers),
                    TextButton(
                      onPressed: () => addEngineer(true),
                      child: const Text('+ Add ME-Engineer'),
                    ),
                    const SizedBox(height: 20),
                    const Text('QC-Engineers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    engineerField(false, qcEngineers),
                    TextButton(
                      onPressed: () => addEngineer(false),
                      child: const Text('+ Add QC-Engineer'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
