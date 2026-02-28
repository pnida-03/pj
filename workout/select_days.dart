import 'package:flutter/material.dart';

class SelectDaysPage extends StatelessWidget {
  const SelectDaysPage({super.key});

  static const Color primaryGreen = Color(0xFF2ECC71);
  static const Color bgColor = Color(0xFFF6F6F6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "เลือกจำนวนวันที่ต้องการฝึก",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          /// ===== 3 วัน =====
          WorkoutPlanItem(
            title: "Full Body",
            days: "3 วัน / สัปดาห์",
            description:
                "เหมาะกับมือใหม่ หรือ คนงานยุ่ง\n"
                "จุดเด่น : บริหารทุกส่วนในวันเดียว\n"
                "ช่วยกระตุ้นระบบเผาผลาญได้ดี",
            images: [
              "assets/images/fullbody.jpg",
            ],
          ),

          SizedBox(height: 24),

          /// ===== 4 วัน (รูปเดียวแล้ว) =====
          WorkoutPlanItem(
            title: "Upper / Lower",
            days: "4 วัน / สัปดาห์",
            description:
                "แบ่งฝึกช่วงบนและช่วงล่าง\n"
                "เพิ่มความเข้มข้นมากขึ้น\n"
                "เหมาะกับผู้ที่เริ่มมีประสบการณ์",
            images: [
              "assets/images/upper_lower.jpg",
            ],
          ),

          SizedBox(height: 24),

          /// ===== 5 วัน =====
          WorkoutPlanItem(
            title: "Body Split",
            days: "5 วัน / สัปดาห์",
            description:
                "แยกฝึกกล้ามเนื้อแต่ละส่วน\n"
                "เหมาะสำหรับสายจริงจัง\n"
                "สร้างกล้ามเนื้อได้ชัดเจน",
            images: [
              "assets/images/bodysplit.jpg",
            ],
          ),
        ],
      ),
    );
  }
}

/// =================================================
/// การ์ดแผนฝึก (กดแล้ว pop กลับ)
/// =================================================
class WorkoutPlanItem extends StatelessWidget {
  final String title;
  final String days;
  final String description;
  final List<String> images;

  const WorkoutPlanItem({
    super.key,
    required this.title,
    required this.days,
    required this.description,
    required this.images,
  });

  static const Color primaryGreen = Color(0xFF2ECC71);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.pop(context, {
          "days": days,
          "detail": description,
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ===== รูป (อัตโนมัติรูปเดียว) =====
          _singleImage(images.first),

          const SizedBox(height: 8),

          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            days,
            style: const TextStyle(
              color: primaryGreen,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              color: Colors.black54,
              height: 1.4,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 12),

          Container(
            height: 3,
            width: double.infinity,
            color: primaryGreen,
          ),
        ],
      ),
    );
  }

  /// ===== รูปเดียว =====
  Widget _singleImage(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Image.asset(
            image,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          _overlayText(),
        ],
      ),
    );
  }

  /// ===== ตัวอักษรทับรูป =====
  Widget _overlayText() {
    return Positioned(
      bottom: 10,
      left: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}