import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> profile;

  const EditProfileScreen({super.key, required this.profile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController heightController;
  late TextEditingController weightController;
  late TextEditingController goalController;
  late TextEditingController activityController;

  @override
  void initState() {
    super.initState();
    heightController =
        TextEditingController(text: widget.profile['mb_Height']);
    weightController =
        TextEditingController(text: widget.profile['mb_Weight']);
    goalController =
        TextEditingController(text: widget.profile['mb_Goal']);
    activityController =
        TextEditingController(text: widget.profile['mb_ActivityLevel']);
  }

  // ================= UPDATE PROFILE =================
  Future<void> updateProfile() async {
    final response = await http.post(
      Uri.parse('http://localhost/pj/update_profile.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "mb_ID": widget.profile['mb_ID'],
        "mb_Height": heightController.text,
        "mb_Weight": weightController.text,
        "mb_Goal": goalController.text,
        "mb_ActivityLevel": activityController.text,
      }),
    );

    print(response.body); // debug ว่า update สำเร็จจริงไหม

    // ✅ ส่งผลกลับไปให้ ProfileScreen รู้ว่าแก้ไขสำเร็จ
    Navigator.pop(context, true);
  }

  // ===== Card Wrapper =====
  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  // ===== Input Decoration =====
  InputDecoration _inputDecoration(
      String label, IconData icon, Color iconColor) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: iconColor),
      filled: true,
      fillColor: const Color(0xFFF3F4F6),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'แก้ไขข้อมูลผู้ใช้',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("ข้อมูลร่างกาย",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),

                  TextField(
                    controller: heightController,
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration(
                        "ส่วนสูง (ซม.)", Icons.height, const Color(0xFFE88725)),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration("น้ำหนัก (กก.)",
                        Icons.monitor_weight, const Color(0xFFB197FC)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("เป้าหมายและกิจกรรม",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),

                  TextField(
                    controller: goalController,
                    decoration: _inputDecoration(
                        "เป้าหมาย", Icons.flag, const Color(0xFF22C55E)),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: activityController,
                    decoration: _inputDecoration("ระดับกิจกรรม",
                        Icons.directions_run, const Color(0xFF3B82F6)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: updateProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF22C55E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "บันทึกข้อมูล",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}