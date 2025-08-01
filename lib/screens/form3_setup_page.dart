import 'package:flutter/material.dart';

class Form3SetupPage extends StatefulWidget {
  const Form3SetupPage({super.key});

  @override
  State<Form3SetupPage> createState() => _Form3SetupPageState();
}

class _Form3SetupPageState extends State<Form3SetupPage> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, TextEditingController> formDataControllers = {
    'partNumber': TextEditingController(),
    'partName': TextEditingController(),
    'serialNumber': TextEditingController(),
    'fairIdentifier': TextEditingController(),
  };

  List<Map<String, TextEditingController>> characteristicControllers = [
    {
      'number': TextEditingController(),
      'location': TextEditingController(),
      'accountability': TextEditingController(),
      'requirement': TextEditingController(),
      'result': TextEditingController(),
      'tooling': TextEditingController(),
      'nonConformance': TextEditingController(),
      'comments': TextEditingController(),
    }
  ];

  @override
  void dispose() {
    formDataControllers.forEach((_, c) => c.dispose());
    for (var map in characteristicControllers) {
      map.forEach((_, c) => c.dispose());
    }
    super.dispose();
  }

  Widget buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) => value == null || value.trim().isEmpty ? 'Required' : null,
      ),
    );
  }

  Widget buildCharacteristicRow(int index) {
    final controllers = characteristicControllers[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 30),
        Text('Characteristic Row ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        buildField('Characteristic Number', controllers['number']!),
        buildField('Location', controllers['location']!),
        buildField('Characteristic Accountability', controllers['accountability']!),
        buildField('Requirement', controllers['requirement']!),
        buildField('Result', controllers['result']!),
        buildField('Qualified Tooling', controllers['tooling']!),
        buildField('Non-Conformance Number', controllers['nonConformance']!),
        buildField('Comments', controllers['comments']!),
      ],
    );
  }

  void _submitForm() {
    bool valid = _formKey.currentState!.validate();
    for (var map in characteristicControllers) {
      for (var ctrl in map.values) {
        if (ctrl.text.trim().isEmpty) valid = false;
      }
    }

    if (valid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form 3 submitted successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields.')),
      );
    }
  }

  void addCharacteristicRow() {
    setState(() {
      characteristicControllers.add({
        'number': TextEditingController(),
        'location': TextEditingController(),
        'accountability': TextEditingController(),
        'requirement': TextEditingController(),
        'result': TextEditingController(),
        'tooling': TextEditingController(),
        'nonConformance': TextEditingController(),
        'comments': TextEditingController(),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form 3: Characteristic Evaluation')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildField('Part Number', formDataControllers['partNumber']!),
              buildField('Part Name', formDataControllers['partName']!),
              buildField('Serial Number', formDataControllers['serialNumber']!),
              buildField('FAIR Identifier', formDataControllers['fairIdentifier']!),

              const SizedBox(height: 20),
              const Text(
                'Characteristic Accountability, Verification & Compatibility',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),

              ...List.generate(characteristicControllers.length, buildCharacteristicRow),

              ElevatedButton.icon(
                onPressed: addCharacteristicRow,
                icon: const Icon(Icons.add),
                label: const Text('Add Characteristic Row'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          onPressed: _submitForm,
          icon: const Icon(Icons.save),
          label: const Text('Save & Proceed'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
