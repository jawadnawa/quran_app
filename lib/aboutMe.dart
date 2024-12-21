import 'package:flutter/material.dart';

class AboutDeveloperPage extends StatelessWidget {
  const AboutDeveloperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
          "Jawad Card",
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontFamily: "Changa",
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage("images/pic.jpeg"),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "جواد النوايسة",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontFamily: "Changa",
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "مطور تطبيقات",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontFamily: "Changa",
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: isDarkMode ? Colors.white : Colors.black,
              thickness: 5,
              indent: 200,
              endIndent: 20,
            ),
            SizedBox(height: 20),
            _buildCard(
              context,
              icon: Icons.email,
              text: "jawad200888@gmail.com",
              color: Colors.blue,
              isDarkMode: isDarkMode,
            ),
            _buildCard(
              context,
              icon: Icons.phone,
              text: "962 - 799 263 728",
              color: Colors.green,
              isDarkMode: isDarkMode,
            ),
            _buildCard(
              context,
              icon: Icons.sms_rounded,
              text: "IG: @Justjawad",
              color: Colors.orange,
              isDarkMode: isDarkMode,
            ),
            _buildCard(
              context,
              icon: Icons.location_on,
              text: " الكرك - الأردن",
              color: Colors.yellow,
              isDarkMode: isDarkMode,
            ),
            _buildCard(context,
                icon: Icons.cake,
                text: "16 Years Old",
                color: Colors.redAccent,
                isDarkMode: isDarkMode)
          ],
        ),
      ),
    );
  }

  // Function to create each card
  Widget _buildCard(BuildContext context,
      {required IconData icon,
      required String text,
      required Color color,
      required bool isDarkMode}) {
    return Card(
      color: isDarkMode ? color.withOpacity(0.8) : color,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(
            icon,
            color: isDarkMode ? Colors.black : Colors.white,
            size: 60,
          ),
          title: Text(
            text,
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 18,
              fontFamily: "Changa",
            ),
          ),
        ),
      ),
    );
  }
}
