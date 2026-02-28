import 'package:flutter/material.dart';
import 'select_days.dart';

class WorkoutMainPage extends StatefulWidget {
  const WorkoutMainPage({super.key});

  @override
  State<WorkoutMainPage> createState() => _WorkoutMainPageState();
}

class _WorkoutMainPageState extends State<WorkoutMainPage> {
  /// ===== Colors =====
  static const Color primaryGreen = Color(0xFF2ECC71);
  static const Color lightGreen = Color(0xFFE9F9F0);
  static const Color bgColor = Color(0xFFF7F8FA);
  static const Color textGrey = Color(0xFF8E8E93);

  // 🔥 เพิ่มสีตามประเภท
  static const Color orange = Color(0xFFFF9F43); // เวท
  static const Color blue = Color(0xFF54A0FF);   // คาร์ดิโอ

  /// ===== Selected Plan =====
  String days = "3 วัน / สัปดาห์";
  String detail =
      "เหมาะกับมือใหม่ หรือ คนงานยุ่ง\n"
      "จุดเด่น : บริหารทุกส่วนในวันเดียว "
      "ช่วยกระตุ้นระบบเผาผลาญ\n"
      "ได้ดีเยี่ยม โดยไม่ต้องเข้ายิมทุกวัน";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      /// ================= AppBar =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "ตารางฝึกของฉัน",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      /// ================= Body =================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// ---------- เดือน ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "กุมภาพันธ์ 2026",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.chevron_left),
                    SizedBox(width: 4),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// ---------- วัน ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _DayText("อา"),
                _DayText("จ"),
                _DayText("อ"),
                _DayText("พ", isActive: true),
                _DayText("พฤ"),
                _DayText("ศ"),
                _DayText("ส"),
              ],
            ),

            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),

            /// ---------- แผนฝึก + ดินสอ ----------
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        days,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        detail,
                        style: const TextStyle(
                          fontSize: 13,
                          color: textGrey,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SelectDaysPage(),
                      ),
                    );

                    if (result != null) {
                      setState(() {
                        days = result['days'];
                        detail = result['detail'];
                      });
                    }
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Icon(Icons.edit, size: 18),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// ---------- แคลอรี่ที่จะเผาผลาญ ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "แคลอรี่ที่จะเผาผลาญ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: lightGreen,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "350 Kcal",
                    style: TextStyle(
                      color: primaryGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// 🟧 เวทเทรนนิ่ง
            _activityCard(
              icon: Icons.accessibility_new,
              title: "เวทเทรนนิ่ง",
              color: orange,
            ),

            const SizedBox(height: 12),

            /// 🟦 คาร์ดิโอ
            _activityCard(
              icon: Icons.directions_run,
              title: "คาร์ดิโอ",
              color: blue,
            ),

            const SizedBox(height: 24),

            Container(
              height: 3,
              decoration: BoxDecoration(
                color: primaryGreen,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 24),

            /// ---------- แคลอรี่ที่เบิร์น ----------
            const Text(
              "แคลอรี่ที่เบิร์นออก",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 170,
                    height: 170,
                    child: CircularProgressIndicator(
                      value: 1,
                      strokeWidth: 14,
                      backgroundColor: lightGreen,
                      valueColor:
                          const AlwaysStoppedAnimation(primaryGreen),
                    ),
                  ),
                  Column(
                    children: const [
                      Text(
                        "350",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "/350 Kcal",
                        style: TextStyle(
                          fontSize: 14,
                          color: textGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// ---------- รายการ ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "รายการบันทึกกิจกรรมวันนี้",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "ดูทั้งหมด",
                  style: TextStyle(color: primaryGreen),
                ),
              ],
            ),

            const SizedBox(height: 12),

            _recordCard(),
          ],
        ),
      ),

      /// ================= Bottom Nav =================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: primaryGreen,
        unselectedItemColor: textGrey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.flash_on), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ""),
        ],
      ),
    );
  }

  /// ================= Activity Card =================
  Widget _activityCard({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "เพิ่ม",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= Record Card =================
  Widget _recordCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.shade200,
            child: const Icon(Icons.fitness_center),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Squat",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "ขา",
                  style: TextStyle(fontSize: 12, color: textGrey),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    _InfoChip("4 เซต"),
                    _InfoChip("10 ครั้ง"),
                    _InfoChip("20 กก."),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: const [
              Text(
                "40",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "kcal",
                style: TextStyle(fontSize: 12, color: textGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ================= Day Widget =================
class _DayText extends StatelessWidget {
  final String text;
  final bool isActive;

  const _DayText(this.text, {this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        color: isActive ? Colors.black : Colors.grey,
      ),
    );
  }
}

/// ================= Chip =================
class _InfoChip extends StatelessWidget {
  final String text;
  const _InfoChip(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(fontSize: 12)),
    );
  }
}