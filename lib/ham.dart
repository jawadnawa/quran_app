import 'package:flutter/material.dart';
import 'settings_page.dart'; // استيراد صفحة الإعدادات
import 'aboutMe.dart'; // استيراد صفحة عن المطور

class DrawerMenu extends StatelessWidget {
  final Function toggleTheme; // دالة لتبديل السمة
  final bool isDarkMode; // حالة الوضع الداكن

  const DrawerMenu({super.key, required this.toggleTheme, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: const Text(
              'القائمة',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: "Changa",
              ),
            ),
          ),
          ListTile(
            title: const Text(
              'الإعدادات',
              style: TextStyle(
                fontFamily: "Changa",
              ),
            ),
            onTap: () {
              Navigator.pop(context); // أغلق القائمة
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(), // الانتقال إلى صفحة الإعدادات
                ),
              );
            },
          ),
          ListTile(
            title: const Text('عن المطور',
              style: TextStyle(
                fontFamily: "Changa",
              ),
            ),
            onTap: () {
              Navigator.pop(context); // أغلق القائمة
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutDeveloperPage(), // الانتقال إلى صفحة عن المطور
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}