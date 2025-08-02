import 'package:flutter/material.dart';

class Form2SetupPage extends StatefulWidget {
  const Form2SetupPage({super.key});

  @override
  State<Form2SetupPage> createState() => _Form2SetupPageState();
}

class _Form2SetupPageState extends State<Form2SetupPage> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, TextEditingController> controllers = {
    'partNumber': TextEditingController(),
    'partName': TextEditingController(),
    'serialNumber': TextEditingController(),
    'fairIdentifier': TextEditingController(),
    'materialProcess': TextEditingController(),
    'specNumber': TextEditingController(),
    'code': TextEditingController(),
    'processes': TextEditingController(),
    'supplier': TextEditingController(),
    'customerApproval': TextEditingController(),
    'certificateOfConformance': TextEditingController(),
    'materials': TextEditingController(),
    'fairNumber': TextEditingController(),
    'processName': TextEditingController(),
    'processCode': TextEditingController(),
    'supplierDetails': TextEditingController(),
    'certificateNumber': TextEditingController(),
    'referenceDocument': TextEditingController(),
    'inspections': TextEditingController(),
    'functionalTestProc': TextEditingController(),
    'acceptanceReportNum': TextEditingController(),
    'comments': TextEditingController(),
  };

  bool? customerApproved;

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
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Row(
            children: [
              Expanded(child: buildField(label1, key1)),
              const SizedBox(width: 16),
              Expanded(child: buildField(label2, key2)),
            ],
          );
        } else {
          return Column(
            children: [
              buildField(label1, key1),
              buildField(label2, key2),
            ],
          );
        }
      },
    );
  }

  Widget buildRadioGroup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Customer Approval Verification:', style: TextStyle(fontWeight: FontWeight.w500)),
        Row(
          children: [
            Radio<bool>(
              value: true,
              groupValue: customerApproved,
              onChanged: (val) => setState(() => customerApproved = val),
            ),
            const Text('Yes'),
            Radio<bool>(
              value: false,
              groupValue: customerApproved,
              onChanged: (val) => setState(() => customerApproved = val),
            ),
            const Text('No'),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  void _saveAndProceed() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form saved successfully!')),
      );

      // Navigate to Form 3 when available
      // Navigator.push(context, MaterialPageRoute(builder: (_) => Form3SetupPage()));
    }
  }

  void _downloadForm() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Download initiated.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B3558), // Match Form 3 color
        title: const Text('Form 2: Material & Process Info'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _downloadForm,
            tooltip: 'Download Form',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 90),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDualRow('1. Part Number', 'partNumber', '2. Part Name', 'partName'),
                  buildDualRow('3. Serial Number', 'serialNumber', '4. FAIR Identifier', 'fairIdentifier'),
                  const SizedBox(height: 10),

                  const Text('Material/Processes – Rows 5 to 10', style: TextStyle(fontWeight: FontWeight.bold)),
                  buildField('5. Material/Process Name', 'materialProcess'),
                  buildField('6. Specification Number', 'specNumber'),
                  buildField('7. Code', 'code'),
                  buildField('8. Supplier', 'supplier'),
                  buildField('9. Customer Approval Verification (Optional Text)', 'customerApproval'),
                  buildField('10. Certificate of Conformance Number', 'certificateOfConformance'),

                  buildField('Materials', 'materials'),
                  const SizedBox(height: 16),
                  const Text('Contains No Materials', style: TextStyle(fontWeight: FontWeight.bold)),
                  buildField('Processes', 'processes'),

                  buildField('FAIR #', 'fairNumber'),
                  buildField('Process Name', 'processName'),
                  buildField('Process Code', 'processCode'),
                  buildField('Supplier Details', 'supplierDetails'),

                  buildRadioGroup(),

                  buildField('Certificate Number', 'certificateNumber'),
                  buildField('Reference Document', 'referenceDocument'),
                  buildField('Inspections', 'inspections'),

                  const Text('Contains No Inspections', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  buildField('11. Functional Test Procedure Number', 'functionalTestProc'),
                  buildField('12. Acceptance Report Number', 'acceptanceReportNum'),
                  const Text('Contains No Functional Tests and Acceptance Reports', style: TextStyle(fontWeight: FontWeight.bold)),
                  buildField('13. Comments', 'comments'),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _saveAndProceed,
                        icon: const Icon(Icons.save),
                        label: const Text('Save & Proceed'),
                      ),
                      ElevatedButton(
                        onPressed: _saveAndProceed,
                        child: const Text('Next → Form 3'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
