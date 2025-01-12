import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // تأكد من استيراد المكتبة
import 'about.dart'; // استيراد صفحة عن التطبيق

class DrawerMenu extends StatelessWidget {
  final Function toggleTheme; // دالة لتبديل السمة
  final bool isDarkMode; // حالة الوضع الداكن

  const DrawerMenu(
      {super.key, required this.toggleTheme, required this.isDarkMode});

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
          // ListTile(
          //   title: const Text(
          //     'قيم التطبيق',
          //     style: TextStyle(
          //       fontFamily: "Changa",
          //       fontSize: 18,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          //   minVerticalPadding: 0,
          //   subtitle: const Text(
          //     " قم بتقييم التطبيق 5 ⭐ نجوم لتنشر الخير    (الدال على الخير كفاعلة)"   ,  
          //     style: TextStyle(
          //       fontFamily: "Changa",
          //       fontSize: 15,
          //     ),
          //   ),
          //   onTap: () async {
          //     const url = 'https://play.google.com/store/apps/details?id=com.simppro.quran.offline&hl=ar';
          //     if (await canLaunch(url)) {
          //       await launch(url);
          //     } else {
          //       throw 'Could not launch $url';
          //     }
          //   },
          // ),
          ListTile(
            title: const Text(
              'عن المطور',
              style: TextStyle(
                fontFamily: "Changa",
              ),
            ),
            onTap: () {
              Navigator.pop(context); // أغلق القائمة
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const AboutDeveloperPage(), // الانتقال إلى صفحة عن المطور
                ),
              );
            },
          ),
          ListTile(
            title: const Text(
              'عن التطبيق',
              style: TextStyle(
                fontFamily: "Changa",
              ),
            ),
            onTap: () {
              Navigator.pop(context); // أغلق القائمة
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const AboutAppPage(), // الانتقال إلى صفحة عن التطبيق
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}