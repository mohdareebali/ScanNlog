import 'package:flutter/material.dart';
import 'form3_setup_page.dart';

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
    'supplier': TextEditingController(),
    'certificateOfConformance': TextEditingController(),
    'materials': TextEditingController(),
    'processes': TextEditingController(),
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
            hintText: label,
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
        const SizedBox(width: 10),
        Expanded(child: buildField(label2, key2)),
      ],
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
              onChanged: (value) => setState(() => customerApproved = value),
            ),
            const Text('Yes'),
            Radio<bool>(
              value: false,
              groupValue: customerApproved,
              onChanged: (value) => setState(() => customerApproved = value),
            ),
            const Text('No'),
          ],
        ),


      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && customerApproved != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const Form3SetupPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete all required fields.")),
      );
    }
  }

  void _saveForm() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Form saved locally!")),
    );
    // Add actual saving logic here if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form 2: Material & Process Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildDualRow('1. Part Number', 'partNumber', '2. Part Name', 'partName'),
              buildDualRow('3. Serial Number', 'serialNumber', '4. FAIR Identifier', 'fairIdentifier'),
              buildField('5. Material/Process Name', 'materialProcess'),
              buildField('6. Specification Number', 'specNumber'),
              buildField('7. Code', 'code'),
              buildField('8. Supplier', 'supplier'),
              buildField('9. Certificate of Conformance Number', 'certificateOfConformance'),
              buildField('10. Materials', 'materials'),
              buildField('11. Processes', 'processes'),
              buildField('12. FAIR #', 'fairNumber'),
              buildField('13. Process Name', 'processName'),
              buildField('14. Process Code', 'processCode'),
              buildField('15. Supplier Details', 'supplierDetails'),
              buildRadioGroup(),
              buildField('16. Certificate Number', 'certificateNumber'),
              buildField('17. Reference Document', 'referenceDocument'),
              buildField('18. Inspections', 'inspections'),
              buildField('19. Functional Test Procedure Number', 'functionalTestProc'),
              buildField('20. Acceptance Report Number', 'acceptanceReportNum'),
              buildField('21. Comments', 'comments'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _saveForm,
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
                  ElevatedButton.icon(
                    onPressed: _submitForm,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Next → Form 3'),
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
