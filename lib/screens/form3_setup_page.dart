import 'package:flutter/material.dart';

class Form3SetupPage extends StatefulWidget {
  @override
  _Form3SetupPageState createState() => _Form3SetupPageState();
}

class _Form3SetupPageState extends State<Form3SetupPage> {
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

  Widget buildField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(height: 4),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: label.replaceFirst(RegExp(r'^\d+\.\s*'), ''),
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }

  Widget buildDualFieldRow(String label1, TextEditingController ctrl1, String label2, TextEditingController ctrl2) {
    return Row(
      children: [
        Expanded(child: buildField(label1, ctrl1)),
        SizedBox(width: 10),
        Expanded(child: buildField(label2, ctrl2)),
      ],
    );
  }

  Widget buildCharacteristicRow(int index) {
    var controllers = characteristicControllers[index];
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Characteristic Row ${index + 1}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              if (characteristicControllers.length > 1)
                IconButton(
                  onPressed: () => deleteCharacteristicRow(index),
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
            ],
          ),
          SizedBox(height: 8),
          Text('Characteristic Accountability',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1c3a63))),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: buildField('5. Characteristic No.', controllers['number']!)),
              SizedBox(width: 10),
              Expanded(child: buildField('6. Reference Location', controllers['location']!)),
            ],
          ),
          buildField('7. Characteristic Accountability', controllers['accountability']!),
          buildField('8. Requirement', controllers['requirement']!),
          SizedBox(height: 12),
          Text('Inspection / Test Results',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1c3a63))),
          buildField('9. Result', controllers['result']!),
          buildField('10. Designed / Qualified Tooling', controllers['tooling']!),
          buildField('11. Non-Conformance Number', controllers['nonConformance']!),
          buildField('12. Additional Data / Comments', controllers['comments']!),
        ],
      ),
    );
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

  void deleteCharacteristicRow(int index) {
    setState(() {
      characteristicControllers.removeAt(index);
    });
  }

  void _saveForm() {
    // TODO: Add actual save logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Form 3 saved successfully.")),
    );
  }

  @override
  void dispose() {
    formDataControllers.values.forEach((controller) => controller.dispose());
    for (var row in characteristicControllers) {
      row.values.forEach((controller) => controller.dispose());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form 3'),
        backgroundColor: Color(0xFF1c3a63),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDualFieldRow('1. Part Number', formDataControllers['partNumber']!,
                    '2. Part Name', formDataControllers['partName']!),
                buildDualFieldRow('3. Serial Number', formDataControllers['serialNumber']!,
                    '4. FAIR Identifier', formDataControllers['fairIdentifier']!),

                SizedBox(height: 10),
                Text(
                  'Characteristic Accountability, Verification, and Compatibility Evaluation',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),

                ...List.generate(characteristicControllers.length, (index) => buildCharacteristicRow(index)),

                ElevatedButton(
                  onPressed: addCharacteristicRow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1c3a63),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  child: Text(
                    '+ Add Characteristic Row',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: ElevatedButton.icon(
              onPressed: _saveForm,
              icon: Icon(Icons.save, color: Colors.white),
              label: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1c3a63),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}