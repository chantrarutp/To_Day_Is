import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/menu.dart'; // นำเข้าไฟล์ menu.dart

class LoginScren extends StatefulWidget {
  const LoginScren({super.key});

  @override
  State<LoginScren> createState() => _LoginScrenState();
}

class _LoginScrenState extends State<LoginScren> {
  @override
  void initState() {
    super.initState();
    // เรียกใช้ฟังก์ชันเพื่อรอ 5 วินาทีแล้วนำทางไปยังหน้าเมนู
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MenuScreen()), // ไปที่หน้าจอเมนู
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent, // เปลี่ยนสีพื้นหลัง
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                'logo.png', // โลโก้แสดงตรงกลางจอ
                height: 200, // ขยายขนาดรูปโลโก้เพิ่มขึ้น
                width: 200, // ความกว้างของรูปให้เท่ากันสำหรับการทำวงกลม
                fit: BoxFit.cover, // ปรับให้รูปครอบคลุมพื้นที่ทั้งหมด
              ),
            ),
            const SizedBox(height: 20), // เพิ่มช่องว่างระหว่างโลโก้กับข้อความ
            const Text(
              'Welcome To',
              style: TextStyle(
                color: Colors.white, // สีของข้อความเป็นสีขาว
                fontSize: 24, // ขนาดตัวอักษร
                fontWeight: FontWeight.bold, // ตัวอักษรหนา
              ),
            ),
            const SizedBox(height: 10), // เพิ่มช่องว่างเล็กน้อยระหว่างข้อความ
            const Text(
              '"To day is..."',
              style: TextStyle(
                color: Colors.white, // สีของข้อความเป็นสีขาว
                fontSize: 20, // ขนาดตัวอักษร
              ),
            ),
          ],
        ),
      ),
    );
  }
}
