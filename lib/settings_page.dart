import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false; // متغير لتتبع حالة الوضع الداكن
  bool _isNotificationsEnabled = true; // متغير لتتبع حالة الإشعارات
  bool _isSoundEnabled = true; // متغير لتتبع حالة الصوت
  String _selectedLanguage = 'العربية'; // متغير لتحديد اللغة

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          // إعداد الوضع الداكن
          _buildSwitchCard(
            title: 'الوضع الداكن',
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
              });
            },
          ),
          
          // إعدادات الإشعارات
          _buildSwitchCard(
            title: 'الإشعارات',
            value: _isNotificationsEnabled,
            onChanged: (value) {
              setState(() {
                _isNotificationsEnabled = value;
              });
            },
          ),

          // إعدادات الصوت
          _buildSwitchCard(
            title: 'الصوت',
            value: _isSoundEnabled,
            onChanged: (value) {
              setState(() {
                _isSoundEnabled = value;
              });
            },
          ),
          
          // إعداد اللغة
          Card(
            margin: EdgeInsets.all(16),
            child: ListTile(
              title: const Text('اللغة'),
              trailing: DropdownButton<String>(
                value: _selectedLanguage,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLanguage = newValue!;
                  });
                },
                items: <String>['العربية', 'English']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // دالة لبناء بطاقة تحتوي على Switch
  Widget _buildSwitchCard({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Card(
      margin: EdgeInsets.all(16),
      child: ListTile(
        title: Text(title),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}