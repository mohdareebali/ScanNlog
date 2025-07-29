import 'package:flutter/material.dart';

class Form1SetupPage extends StatefulWidget {
  const Form1SetupPage({super.key});

  @override
  State<Form1SetupPage> createState() => _Form1SetupPageState();
}

class _Form1SetupPageState extends State<Form1SetupPage> {
  final Map<String, TextEditingController> controllers = {};

  bool fullFAI = false;
  bool partialFAI = false;
  bool aog = false;
  bool faaApproved = false;
  bool nonConformance = false;
  String detailType = ''; // 'detail' or 'assembly'

  void toggle(String key) {
    setState(() {
      if (key == 'detail') {
        detailType = detailType == 'detail' ? '' : 'detail';
      } else if (key == 'assembly') {
        detailType = detailType == 'assembly' ? '' : 'assembly';
      }
    });
  }

  Widget buildTextField(String label) {
    controllers[label] = TextEditingController();
    return TextField(
      controller: controllers[label],
      decoration: InputDecoration(labelText: label),
    );
  }

  @override
  void dispose() {
    controllers.forEach((_, c) => c.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form1Setup")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text("Form 1", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),

            Row(children: [Expanded(child: buildTextField("1. Part Number")), const SizedBox(width: 12), Expanded(child: buildTextField("2. Part Name"))]),
            Row(children: [Expanded(child: buildTextField("3. Serial Number")), const SizedBox(width: 12), Expanded(child: buildTextField("4. FAIR Identifier"))]),
            Row(children: [Expanded(child: buildTextField("5. Part Revision Level")), const SizedBox(width: 12), Expanded(child: buildTextField("6. Drawing Number"))]),
            Row(children: [Expanded(child: buildTextField("7. Drawing Rev Level")), const SizedBox(width: 12), Expanded(child: buildTextField("8. Additional Changes"))]),

            buildTextField("9. Manufacturing Process Reference"),
            buildTextField("10. Organization Name"),
            Row(children: [Expanded(child: buildTextField("11. Supplier Code")), const SizedBox(width: 12), Expanded(child: buildTextField("12. PO Number"))]),

            const SizedBox(height: 12),
            Row(children: [
              const Text("13. "),
              const SizedBox(width: 6),
              const Text("Detail"),
              Checkbox(
                value: detailType == 'detail',
                onChanged: (_) => toggle('detail'),
              ),
              const SizedBox(width: 20),
              const Text("Assembly"),
              Checkbox(
                value: detailType == 'assembly',
                onChanged: (_) => toggle('assembly'),
              ),
            ]),

            Row(children: [
              const Text("14. "),
              Checkbox(
                value: fullFAI,
                onChanged: (val) => setState(() => fullFAI = val!),
              ),
              const Text("Full FAI"),
              Checkbox(
                value: partialFAI,
                onChanged: (val) => setState(() => partialFAI = val!),
              ),
              const Text("Partial FAI"),
            ]),
            buildTextField("Reason for Full/Partial FAI"),
            Row(children: [
              Checkbox(
                value: aog,
                onChanged: (val) => setState(() => aog = val!),
              ),
              const Text("AOG"),
              const SizedBox(width: 20),
              Checkbox(
                value: faaApproved,
                onChanged: (val) => setState(() => faaApproved = val!),
              ),
              const Text("FAA Approved"),
            ]),

            const Divider(height: 24),
            Text("Index of Parts or Sub-Assemblies", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            buildTextField("15. Part Number"),
            buildTextField("16. Part Name"),
            buildTextField("17. Part Type"),
            buildTextField("Supplier"),
            buildTextField("18. FAIR Identifier"),
            buildTextField("FAIR #"),
            buildTextField("FAIR Status"),
            buildTextField("Program"),
            buildTextField("Customer"),
            buildTextField("Division Info"),

            const Divider(height: 24),
            const Text("19. Does FAIR Contain a Documented Nonconformance(s):"),
            Row(children: [
              Radio(
                value: true,
                groupValue: nonConformance,
                onChanged: (_) => setState(() => nonConformance = true),
              ),
              const Text("Yes"),
              Radio(
                value: false,
                groupValue: nonConformance,
                onChanged: (_) => setState(() => nonConformance = false),
              ),
              const Text("No"),
            ]),

            Row(children: [Expanded(child: buildTextField("20. FAIR Verified By")), const SizedBox(width: 12), Expanded(child: buildTextField("21. Date"))]),
            Row(children: [Expanded(child: buildTextField("22. FAIR Reviewed/Approved By")), const SizedBox(width: 12), Expanded(child: buildTextField("23. Date"))]),
            Row(children: [Expanded(child: buildTextField("24. Customer Approval")), const SizedBox(width: 12), Expanded(child: buildTextField("25. Date"))]),
            buildTextField("26. Comments"),
          ],
        ),
      ),
    );
  }
}
