import 'package:flutter/material.dart';
import 'dart:math';
import 'manager_dashboard.dart';

class ManagerSelectionPage extends StatefulWidget {
  const ManagerSelectionPage({super.key}); // ✅ Super parameter used

  @override
  State<ManagerSelectionPage> createState() => _ManagerSelectionPageState();
}

class _ManagerSelectionPageState extends State<ManagerSelectionPage> {
  List<Map<String, String>> meList = [{'email': '', 'password': ''}];
  List<Map<String, String>> qcList = [{'email': '', 'password': ''}];

  String generatePassword() {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rand = Random();
    return List.generate(10, (_) => chars[rand.nextInt(chars.length)]).join();
  }

  void handleGeneratePassword(String listType, int index) {
    final list = listType == 'me' ? meList : qcList;
    final email = list[index]['email'] ?? '';
    final password = list[index]['password'] ?? '';

    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email before generating password')),
      );
      return;
    }

    if (password.isNotEmpty) return;

    setState(() {
      list[index]['password'] = generatePassword();
    });
  }

  void handleSharePassword(String? email, String? password) {
    if (email == null || email.isEmpty || password == null || password.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Missing Info'),
          content: const Text('Please enter email and generate password first.'),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Password Shared'),
          content: Text('Password sent to $email:\n$password'),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
        ),
      );
    }
  }

  void handleAddEngineer(String listType) {
    setState(() {
      final newEntry = {'email': '', 'password': ''};
      if (listType == 'me') {
        meList.add(newEntry);
      } else {
        qcList.add(newEntry);
      }
    });
  }

  void handleInputChange(String listType, int index, String text) {
    setState(() {
      final updatedEntry = {'email': text, 'password': ''};
      if (listType == 'me') {
        meList[index] = updatedEntry;
      } else {
        qcList[index] = updatedEntry;
      }
    });
  }

  Widget buildEngineerList(String label, List<Map<String, String>> list, String type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        const SizedBox(height: 10),
        ...list.asMap().entries.map((entry) {
          int index = entry.key;
          var item = entry.value;
          bool emailEntered = item['email'] != null && item['email']!.contains('@');
          bool passwordGenerated = item['password'] != null && item['password']!.isNotEmpty;

          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: '$label email',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  onChanged: (text) => handleInputChange(type, index, text),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: (emailEntered && !passwordGenerated)
                      ? () => handleGeneratePassword(type, index)
                      : null,
                  icon: const Icon(Icons.lock),
                  label: const Text('Generate Password'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1c3a63),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    disabledForegroundColor: Colors.grey.shade700,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                ),
                if (passwordGenerated)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['password']!,
                        style: const TextStyle(color: Color(0xFF1c3a63), fontWeight: FontWeight.w500),
                      ),
                      IconButton(
                        icon: const Icon(Icons.share, color: Color(0xFF1c3a63), size: 20),
                        onPressed: () => handleSharePassword(item['email'], item['password']),
                      ),
                    ],
                  ),
              ],
            ),
          );
        }),
        TextButton.icon(
          onPressed: () => handleAddEngineer(type),
          icon: const Icon(Icons.add_circle_outline, size: 24, color: Color(0xFF1c3a63)),
          label: const Text('Add Another', style: TextStyle(color: Color(0xFF1c3a63))),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20).copyWith(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Assign Engineers',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1c3a63),
                ),
              ),
              const SizedBox(height: 30),
              buildEngineerList('ME Engineers', meList, 'me'),
              buildEngineerList('QC Engineers', qcList, 'qc'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ManagerDashboard()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1c3a63),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  'Continue to Dashboard',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
