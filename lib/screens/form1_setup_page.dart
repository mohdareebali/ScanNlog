import 'package:flutter/material.dart';
import 'form2_setup_page.dart';

class Form1SetupPage extends StatefulWidget {
  const Form1SetupPage({super.key});

  @override
  State<Form1SetupPage> createState() => _Form1SetupPageState();
}

class _Form1SetupPageState extends State<Form1SetupPage> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, TextEditingController> controllers = {
    'partNumber': TextEditingController(),
    'partName': TextEditingController(),
    'serialNumber': TextEditingController(),
    'fairId': TextEditingController(),
    'partRevision': TextEditingController(),
    'drawingNumber': TextEditingController(),
    'drawingRevision': TextEditingController(),
    'additionalChanges': TextEditingController(),
    'processReference': TextEditingController(),
    'organization': TextEditingController(),
    'supplierCode': TextEditingController(),
    'poNumber': TextEditingController(),
    'baselinePart': TextEditingController(),
    'reasonFAI': TextEditingController(),
    'part15': TextEditingController(),
    'part16Name': TextEditingController(),
    'part17Type': TextEditingController(),
    'supplier': TextEditingController(),
    'fair18': TextEditingController(),
    'fairNumber': TextEditingController(),
    'fairStatus': TextEditingController(),
    'program': TextEditingController(),
    'customer': TextEditingController(),
    'division': TextEditingController(),
    'fairVerifiedBy': TextEditingController(),
    'fairVerifiedDate': TextEditingController(),
    'fairApprovedBy': TextEditingController(),
    'fairApprovedDate': TextEditingController(),
    'customerApproval': TextEditingController(),
    'customerApprovalDate': TextEditingController(),
    'comments': TextEditingController(),
  };

  String? detailType;
  bool fullFAI = false;
  bool partialFAI = false;
  bool aog = false;
  bool faaApproved = false;
  bool? nonConformance;

  @override
  void dispose() {
    controllers.forEach((_, c) => c.dispose());
    super.dispose();
  }

  Widget buildField(String label, String key) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        TextFormField(
          controller: controllers[key],
          decoration: InputDecoration(
            hintText: label.replaceFirst(RegExp(r'^\d+\.\s*'), ''),
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          validator: (value) => value == null || value.isEmpty ? 'Required' : null,
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget buildDualRow(String label1, String key1, String label2, String key2) {
    return Row(
      children: [
        Expanded(child: buildField(label1, key1)),
        const SizedBox(width: 16),
        Expanded(child: buildField(label2, key2)),
      ],
    );
  }

  Widget buildCheckbox(String label, bool value, void Function(bool?) onChanged) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Text(label),
      ],
    );
  }

  Widget buildRadioGroup({
    required String title,
    required List<String> options,
    required String? groupValue,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        for (var option in options)
          Row(
            children: [
              Radio<String>(
                value: option,
                groupValue: groupValue,
                onChanged: onChanged,
              ),
              Text(option),
            ],
          ),
        const SizedBox(height: 12),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => Form2SetupPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form 1: Part Number Accountability'),

      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDualRow('1. Part Number', 'partNumber', '2. Part Name', 'partName'),
              buildDualRow('3. Serial Number', 'serialNumber', '4. FAIR Identifier', 'fairId'),
              buildDualRow('5. Part Revision Level', 'partRevision', '6. Drawing Number', 'drawingNumber'),
              buildDualRow('7. Drawing Revision Level', 'drawingRevision', '8. Additional Changes', 'additionalChanges'),
              buildField('9. Manufacturing Process Reference', 'processReference'),
              buildField('10. Organization Name', 'organization'),
              buildDualRow('11. Supplier Code', 'supplierCode', '12. Purchase Order Number', 'poNumber'),

              buildRadioGroup(
                title: '13. Detail / Assembly',
                options: const ['detail', 'assembly'],
                groupValue: detailType,
                onChanged: (val) => setState(() => detailType = val),
              ),

              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('14. Full/Partial FAI:', style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: fullFAI,
                        onChanged: (val) => setState(() => fullFAI = val!),
                      ),
                      const Text('Full FAI'),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: partialFAI,
                        onChanged: (val) => setState(() => partialFAI = val!),
                      ),
                      const Text('Partial FAI'),
                    ],
                  ),
                ],
              ),

              buildField('Baseline Part Number (Including Revision Level)', 'baselinePart'),
              buildField('Reason for Full/Partial FAI', 'reasonFAI'),
              buildCheckbox('AOG', aog, (val) => setState(() => aog = val!)),
              buildCheckbox('FAA Approved', faaApproved, (val) => setState(() => faaApproved = val!)),

              const SizedBox(height: 16),
              const Text('INDEX of part numbers or sub-assembly numbers required to make the assembly noted above',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              buildDualRow('15. Part Number', 'part15', '16. Part Name', 'part16Name'),
              buildField('17. Part Type', 'part17Type'),
              buildField('Supplier', 'supplier'),
              buildField('18. FAIR Identifier', 'fair18'),

              const SizedBox(height: 20),
              const Text('FAIR and Program Information', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              buildField('FAIR #', 'fairNumber'),
              buildField('FAIR Status', 'fairStatus'),
              buildField('Program', 'program'),
              buildField('Customer', 'customer'),
              buildField('Division Info', 'division'),

              buildRadioGroup(
                title: '19. Does FAIR Contain a Documented Nonconformance?',
                options: const ['Yes', 'No'],
                groupValue: nonConformance == null
                    ? ''
                    : (nonConformance! ? 'Yes' : 'No'),
                onChanged: (val) => setState(() => nonConformance = val == 'Yes'),
              ),

              const SizedBox(height: 16),
              const Text('FAIR Verification and Approval', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              buildDualRow('20. FAIR Verified By', 'fairVerifiedBy', '21. Date', 'fairVerifiedDate'),
              buildDualRow('22. FAIR Reviewed/Approved By', 'fairApprovedBy', '23. Date', 'fairApprovedDate'),
              buildDualRow('24. Customer Approval', 'customerApproval', '25. Date', 'customerApprovalDate'),
              buildField('26. Comments', 'comments'),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Form saved locally!')),
                        );
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Save & Proceed'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Next → Form 2'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
