import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 0;

  Map<String, dynamic>? profile;

  late double height;
  late double weight;

  // ================= API =================
  Future<void> fetchProfile() async {
    final response = await http.get(
      Uri.parse('http://localhost/pj/get_profile.php?mb_ID=1'),
    );

    final json = jsonDecode(response.body);
    if (json['status'] == true) {
      setState(() {
        profile = json['data'];
        height = double.parse(profile!['mb_Height']);
        weight = double.parse(profile!['mb_Weight']);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

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

  @override
  Widget build(BuildContext context) {
    if (profile == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),

      // ================= AppBar =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 72,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.black,
                  child: Icon(Icons.person, color: Colors.white, size: 20),
                ),
                const SizedBox(height: 4),
                Text(profile!['mb_Name'],
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
            const Expanded(
              child: Center(
                child: Text(
                  "ข้อมูลผู้ใช้งาน",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey),
              ),
              child: const Icon(Icons.notifications_none, size: 20),
            ),
          ],
        ),
      ),

      // ================= BODY =================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _bodyInfoCard(),
            const SizedBox(height: 16),
            _goalCard(),
            const SizedBox(height: 16),
            _activityLevelCard(),
            const SizedBox(height: 80),
          ],
        ),
      ),

      // ================= Bottom Navigation =================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF22C55E),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: "Food"),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: "Workout"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: "Profile"),
        ],
      ),
    );
  }

  // ================= ข้อมูลร่างกาย =================
  Widget _bodyInfoCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "ข้อมูลร่างกาย",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton.icon(
                onPressed: () async {
                  // ✅ รับค่ากลับจากหน้าแก้ไข
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          EditProfileScreen(profile: profile!),
                    ),
                  );

                  // ✅ โหลดใหม่เฉพาะตอนแก้ไขสำเร็จ
                  if (result == true) {
                    fetchProfile();
                  }
                },
                icon: const Icon(Icons.edit,
                    size: 16, color: Color(0xFF22C55E)),
                label: const Text(
                  "แก้ไข",
                  style: TextStyle(color: Color(0xFF22C55E)),
                ),
              ),
            ],
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.4,
            children: [
              _infoBox(
                "อายุ",
                "${profile!['mb_BirthDate'] ?? '-'}",
                Icons.badge,
                const Color(0xFF2534E8),
              ),
              _infoBox(
                "ส่วนสูง",
                "$height ซม.",
                Icons.height,
                const Color(0xFFE88725),
              ),
              _infoBox(
                "น้ำหนัก",
                "$weight กก.",
                Icons.monitor_weight,
                const Color(0xFFB197FC),
              ),
              _infoBox(
                "เพศ",
                profile!['mb_Gender'],
                Icons.wc,
                const Color(0xFF63E6BE),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoBox(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 12)),
              Text(value,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  // ================= เป้าหมาย =================
  Widget _goalCard() {
    return _card(
      child: Column(
        children: [
          const Text("เป้าหมาย",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const Text("Goal", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 12),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border:
                  Border.all(color: Color(0xFF22C55E), width: 2),
            ),
            child: Text(
              profile!['mb_Goal'],
              style: const TextStyle(
                color: Color(0xFF22C55E),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= ระดับกิจกรรม =================
  Widget _activityLevelCard() {
    return _card(
      child: Column(
        children: [
          const Text("ระดับกิจกรรม",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const Text("Activity Level",
              style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 12),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border:
                  Border.all(color: Color(0xFF3B82F6), width: 2),
            ),
            child: Text(
              profile!['mb_ActivityLevel'],
              style: const TextStyle(
                color: Color(0xFF3B82F6),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}