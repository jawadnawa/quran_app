import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart'; // استيراد مكتبة provider
import 'ham.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// 1. ThemeNotifier لإدارة حالة الثيم
class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // إشعار المستمعين بتغيير الحالة
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 2. استخدام ThemeNotifier لتحديد الثيم
    final isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;

    return MaterialApp(
      title: 'Quran Recitation',
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          " القارئ بندر بليلة",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: "Changa",
          ),
        ),
        backgroundColor: themeProvider.isDarkMode
            ? Colors.blue
            : const Color.fromARGB(255, 255, 255, 255),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: DrawerMenu(
        toggleTheme: themeProvider.toggleTheme,
        isDarkMode: themeProvider.isDarkMode,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/background.jpg"), // إضافة صورة خلفية
          fit: BoxFit.cover,
        )),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height:
                    MediaQuery.of(context).size.height * 0.6, // 60% من الواجهة
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage("images/finalbander.png"), // الصورة المطلوبة
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                " بندر بليلة قارئ وإمام الحرم المكي، يتميز بصوت شجي وأسلوب تلاوة مؤثر 🎧. ",
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Changa",
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuranPageBander()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeProvider.isDarkMode
                              ? Colors.blueGrey
                              : Colors.blue,
                          foregroundColor: themeProvider.isDarkMode
                              ? Colors.white
                              : Colors.black, // لون النص
                        ),
                        child: Text(
                          "استمع للقرآن",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Changa",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AzkarPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeProvider.isDarkMode
                              ? Colors.blueGrey
                              : Colors.blue,
                          foregroundColor: themeProvider.isDarkMode
                              ? Colors.white
                              : Colors.black, // لون النص
                        ),
                        child: Text(
                          "الأذكار",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Changa",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => themeProvider.toggleTheme(),
        child: Icon(
          themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
        ),
      ),
    );
  }
}

Widget buildReaderTile(
    BuildContext context, String name, String imagePath, Widget page) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imagePath),
            radius: 50,
          ),
          const SizedBox(width: 20),
          Text(
            name,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: "Changa",
            ),
          ),
        ],
      ),
    ),
  );
}

class AzkarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الأذكار"),
        backgroundColor: Colors.blue,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl, // تعيين الاتجاه من اليمين إلى اليسار
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // الصباح
            buildAzkarSection(
              context,
              title: "أذكار الصباح",
              azkar: [
                AzkarItem(
                  title: "آية الكرسي",
                  subtitle:
                      "اللّهُ لاَ إِلٰهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاءَ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ.",
                ),
                AzkarItem(
                  title: "سورة الإخلاص",
                  subtitle:
                      "قُلْ هُوَ اللَّهُ أَحَدٌ اللَّهُ الصَّمَدُ لَمْ يَلِدْ وَلَمْ يُولَدْ وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ.",
                ),
                AzkarItem(
                  title: "سورة الفلق",
                  subtitle:
                      "قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ مِن شَرِّ مَا خَلَقَ وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ.",
                ),
                AzkarItem(
                  title: "سورة الناس",
                  subtitle:
                      "قُلْ أَعُوذُ بِرَبِّ النَّاسِ مَلِكِ النَّاسِ إِلَهِ النَّاسِ مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ مِنَ الْجِنَّةِ وَالنَّاسِ.",
                ),
                AzkarItem(
                  title: "أصبحنا وأصبح الملك لله",
                  subtitle:
                      "أصبحنا وأصبح الملك لله، والحمد لله، لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير. رب أسألك خير ما في هذا اليوم وخير ما بعده، وأعوذ بك من شر ما في هذا اليوم وشر ما بعده. رب أعوذ بك من الكسل وسوء الكبر. رب أعوذ بك من عذاب في النار وعذاب في القبر.",
                ),
                AzkarItem(
                  title: "اللهم بك أصبحنا",
                  subtitle:
                      "اللهم بك أصبحنا، وبك أمسينا، وبك نحيا، وبك نموت، وإليك النشور.",
                ),
                AzkarItem(
                  title: "اللهم أنت ربي",
                  subtitle:
                      "اللهم أنت ربي، لا إله إلا أنت، خلقتني وأنا عبدك، وأنا على عهدك ووعدك ما استطعت، أعوذ بك من شر ما صنعت، أبوء لك بنعمتك علي، وأبوء بذنبي، فاغفر لي، فإنه لا يغفر الذنوب إلا أنت.",
                ),
                AzkarItem(
                  title: "اللهم إني أصبحت أشهدك",
                  subtitle:
                      "اللهم إني أصبحت أشهدك، وأشهد حملة عرشك، وملائكتك، وجميع خلقك، أنك أنت الله لا إله إلا أنت، وحدك لا شريك لك، وأن محمدًا عبدك ورسولك.",
                ),
                AzkarItem(
                  title: "اللهم ما أصبح بي من نعمة",
                  subtitle:
                      "اللهم ما أصبح بي من نعمة أو بأحد من خلقك، فمنك وحدك لا شريك لك، فلك الحمد ولك الشكر.",
                ),
                AzkarItem(
                  title: "حسبي الله لا إله إلا هو",
                  subtitle:
                      "حسبي الله لا إله إلا هو، عليه توكلت وهو رب العرش العظيم.",
                ),
                AzkarItem(
                  title: "بسم الله الذي لا يضر مع اسمه شيء",
                  subtitle:
                      "بسم الله الذي لا يضر مع اسمه شيء في الأرض ولا في السماء وهو السميع العليم.",
                ),
                AzkarItem(
                  title: "رضيت بالله ربا",
                  subtitle:
                      "رضيت بالله ربا، وبالإسلام دينا، وبمحمد صلى الله عليه وسلم نبيا.",
                ),
                AzkarItem(
                  title: "يا حي يا قيوم",
                  subtitle:
                      "يا حي يا قيوم، برحمتك أستغيث، أصلح لي شأني كله، ولا تكلني إلى نفسي طرفة عين.",
                ),
                AzkarItem(
                  title: "سبحان الله وبحمده",
                  subtitle:
                      "سبحان الله وبحمده، عدد خلقه، ورضا نفسه، وزنة عرشه، ومداد كلماته.",
                ),
                AzkarItem(
                  title: "اللهم عافني في بدني",
                  subtitle:
                      "اللهم عافني في بدني، اللهم عافني في سمعي، اللهم عافني في بصري، لا إله إلا أنت.",
                ),
                AzkarItem(
                  title: "اللهم إني أعوذ بك من الكفر",
                  subtitle:
                      "اللهم إني أعوذ بك من الكفر، والفقر، وأعوذ بك من عذاب القبر، لا إله إلا أنت.",
                ),
                AzkarItem(
                  title: "اللهم إني أسألك العفو والعافية",
                  subtitle:
                      "اللهم إني أسألك العفو والعافية في الدنيا والآخرة، اللهم إني أسألك العفو والعافية في ديني ودنياي، وأهلي ومالي، اللهم استر عوراتي، وآمن روعاتي، واحفظني من بين يدي، ومن خلفي، وعن يميني، وعن شمالي، ومن فوقي، وأعوذ بعظمتك أن أغتال من تحتي.",
                ),
                AzkarItem(
                  title: "اللهم عالم الغيب والشهادة",
                  subtitle:
                      "اللهم عالم الغيب والشهادة، فاطر السماوات والأرض، رب كل شيء ومليكه، أشهد أن لا إله إلا أنت، أعوذ بك من شر نفسي، ومن شر الشيطان وشركه، وأن أقترف على نفسي سوءا، أو أجره إلى مسلم.",
                ),
                AzkarItem(
                  title: "أعوذ بكلمات الله التامات",
                  subtitle: "أعوذ بكلمات الله التامات من شر ما خلق.",
                ),
                AzkarItem(
                  title: "اللهم صل وسلم على نبينا محمد",
                  subtitle: "اللهم صل وسلم على نبينا محمد.",
                ),
              ],
            ),
            const Divider(thickness: 2),
            // المساء
            buildAzkarSection(
              context,
              title: "أذكار المساء",
              azkar: [
                AzkarItem(
                  title: "آية الكرسي",
                  subtitle:
                      "اللّهُ لاَ إِلٰهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاءَ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ.",
                ),
                AzkarItem(
                  title: "سورة الإخلاص",
                  subtitle:
                      "قُلْ هُوَ اللَّهُ أَحَدٌ اللَّهُ الصَّمَدُ لَمْ يَلِدْ وَلَمْ يُولَدْ وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ.",
                ),
                AzkarItem(
                  title: "سورة الفلق",
                  subtitle:
                      "قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ مِن شَرِّ مَا خَلَقَ وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ.",
                ),
                AzkarItem(
                  title: "سورة الناس",
                  subtitle:
                      "قُلْ أَعُوذُ بِرَبِّ النَّاسِ مَلِكِ النَّاسِ إِلَهِ النَّاسِ مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ مِنَ الْجِنَّةِ وَالنَّاسِ.",
                ),
                AzkarItem(
                  title: "أمسينا وأمسى الملك لله",
                  subtitle:
                      "أمسينا وأمسى الملك لله، والحمد لله، لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير. رب أسألك خير ما في هذه الليلة وخير ما بعدها، وأعوذ بك من شر ما في هذه الليلة وشر ما بعدها. رب أعوذ بك من الكسل وسوء الكبر. رب أعوذ بك من عذاب في النار وعذاب في القبر.",
                ),
                AzkarItem(
                  title: "اللهم بك أمسينا",
                  subtitle:
                      "اللهم بك أمسينا، وبك أصبحنا، وبك نحيا، وبك نموت، وإليك المصير.",
                ),
                AzkarItem(
                  title: "اللهم أنت ربي",
                  subtitle:
                      "اللهم أنت ربي، لا إله إلا أنت، خلقتني وأنا عبدك، وأنا على عهدك ووعدك ما استطعت، أعوذ بك من شر ما صنعت، أبوء لك بنعمتك علي، وأبوء بذنبي، فاغفر لي، فإنه لا يغفر الذنوب إلا أنت.",
                ),
                AzkarItem(
                  title: "اللهم إني أمسيت أشهدك",
                  subtitle:
                      "اللهم إني أمسيت أشهدك، وأشهد حملة عرشك، وملائكتك، وجميع خلقك، أنك أنت الله لا إله إلا أنت، وحدك لا شريك لك، وأن محمدًا عبدك ورسولك.",
                ),
                AzkarItem(
                  title: "اللهم ما أمسى بي من نعمة",
                  subtitle:
                      "اللهم ما أمسى بي من نعمة أو بأحد من خلقك، فمنك وحدك لا شريك لك، فلك الحمد ولك الشكر.",
                ),
                AzkarItem(
                  title: "حسبي الله لا إله إلا هو",
                  subtitle:
                      "حسبي الله لا إله إلا هو، عليه توكلت وهو رب العرش العظيم.",
                ),
                AzkarItem(
                  title: "بسم الله الذي لا يضر مع اسمه شيء",
                  subtitle:
                      "بسم الله الذي لا يضر مع اسمه شيء في الأرض ولا في السماء وهو السميع العليم.",
                ),
                AzkarItem(
                  title: "رضيت بالله ربا",
                  subtitle:
                      "رضيت بالله ربا، وبالإسلام دينا، وبمحمد صلى الله عليه وسلم نبيا.",
                ),
                AzkarItem(
                  title: "يا حي يا قيوم",
                  subtitle:
                      "يا حي يا قيوم، برحمتك أستغيث، أصلح لي شأني كله، ولا تكلني إلى نفسي طرفة عين.",
                ),
                AzkarItem(
                  title: "سبحان الله وبحمده",
                  subtitle:
                      "سبحان الله وبحمده، عدد خلقه، ورضا نفسه، وزنة عرشه، ومداد كلماته.",
                ),
                AzkarItem(
                  title: "اللهم عافني في بدني",
                  subtitle:
                      "اللهم عافني في بدني، اللهم عافني في سمعي، اللهم عافني في بصري، لا إله إلا أنت.",
                ),
                AzkarItem(
                  title: "اللهم إني أعوذ بك من الكفر",
                  subtitle:
                      "اللهم إني أعوذ بك من الكفر، والفقر، وأعوذ بك من عذاب القبر، لا إله إلا أنت.",
                ),
                AzkarItem(
                  title: "اللهم إني أسألك العفو والعافية",
                  subtitle:
                      "اللهم إني أسألك العفو والعافية في الدنيا والآخرة، اللهم إني أسألك العفو والعافية في ديني ودنياي، وأهلي ومالي، اللهم استر عوراتي، وآمن روعاتي، واحفظني من بين يدي، ومن خلفي، وعن يميني، وعن شمالي، ومن فوقي، وأعوذ بعظمتك أن أغتال من تحتي.",
                ),
                AzkarItem(
                  title: "اللهم عالم الغيب والشهادة",
                  subtitle:
                      "اللهم عالم الغيب والشهادة، فاطر السماوات والأرض، رب كل شيء ومليكه، أشهد أن لا إله إلا أنت، أعوذ بك من شر نفسي، ومن شر الشيطان وشركه، وأن أقترف على نفسي سوءا، أو أجره إلى مسلم.",
                ),
                AzkarItem(
                  title: "أعوذ بكلمات الله التامات",
                  subtitle: "أعوذ بكلمات الله التامات من شر ما خلق.",
                ),
                AzkarItem(
                  title: "اللهم صل وسلم على نبينا محمد",
                  subtitle: "اللهم صل وسلم على نبينا محمد.",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildAzkarSection(BuildContext context,
      {required String title, required List<AzkarItem> azkar}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Changa",
            ),
          ),
        ),
        ...azkar.map((item) => buildAzkarTile(item)).toList(),
      ],
    );
  }

  Widget buildAzkarTile(AzkarItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          item.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Changa",
          ),
        ),
        subtitle: Text(
          item.subtitle,
          style: const TextStyle(
            fontFamily: "Changa",
          ),
        ),
      ),
    );
  }
}

class AzkarItem {
  final String title;
  final String subtitle;

  AzkarItem({required this.title, required this.subtitle});
}

class QuranPageBander extends StatefulWidget {
  @override
  _QuranPageBanderState createState() => _QuranPageBanderState();
}

class _QuranPageBanderState extends State<QuranPageBander> {
  final List<Map<String, String>> _surahs = [
    {
      "name": "سورة الفاتحة",
      "path":
          "https://drive.google.com/uc?export=download&id=1_OBkHObS1ZU_REn_KdMsge6k_rP0V6hn"
    },
    {
      "name": "سورة البقرة",
      "path":
          "https://drive.google.com/uc?export=download&id=1f3DbXWnFNRh1CN21TraGQtTmaVJzCMPI"
    },
    {
      "name": "سورة آل عمران", // رقم السورة: 3
      "path":
          "https://drive.google.com/uc?export=download&id=1lSKQMBCqdBKjOzqKy_Y2XohsUT4M5hbQ"
    },
    {
      "name": "سورة النساء",
      "path":
          "https://drive.google.com/uc?id=1HaUCtuorNpYM_na8AWqqaLIseyFVWYgn&export=download"
    },
    {
      "name": "سورة المائدة",
      "path":
          "https://drive.google.com/uc?id=1LqdAFI21u2KrqOeObjynMPX_koNQjPj7&export=download"
    },
    {
      "name": "سورة الأنعام",
      "path":
          "https://drive.google.com/uc?id=1O1aR4cssP1zdtVb3__BnSoO9LcRGQ2AV&export=download"
    },
    {
      "name": "سورة الأعراف",
      "path":
          "https://drive.google.com/uc?id=1yZMK2YYTSyFNYcCmMph69i-Hpk4s_otS&export=download"
    },
    {
      "name": "سورة الأنفال",
      "path":
          "https://drive.google.com/uc?id=1E6vK-ybdeZjwKcvsRw0oKzFqhVR1AW5w&export=download"
    },
    {
      "name": "سورة التوبة",
      "path":
          "https://drive.google.com/uc?id=1sT3FBOTSbAhPHUNosEkT0cvWxruNAXx5&export=download"
    },
    {
      "name": "سورة يونس",
      "path":
          "https://drive.google.com/uc?id=1wUkS_VPoiKvDec4B2aPkEqtaGE_wDTq3&export=download"
    },
    {
      "name": "سورة هود",
      "path":
          "https://drive.google.com/uc?id=11bvbVbigOv-GSpYuPFNseK1doNOI9iL2&export=download"
    },
    {
      "name": "سورة يوسف",
      "path":
          "https://drive.google.com/uc?id=1Dw8SPZLyC0exkx3IZVCs8gUUugjxXDWd&export=download"
    },
    {
      "name": "سورة الرعد",
      "path":
          "https://drive.google.com/uc?id=1XhqdxAYZUV-Dsebh8eDXWZgERzXKvODv&export=download"
    },
    {
      "name": "سورة إبراهيم",
      "path":
          "https://drive.google.com/uc?id=1G45C8yXQ7raARQE4s9vgUubI-pjeNkq5&export=download"
    },
    {
      "name": "سورة الحجر",
      "path":
          "https://drive.google.com/uc?id=1om0UYynUOEQPCPc4J2mEEY8yUcfan03Y&export=download"
    },
    {
      "name": "سورة النحل",
      "path":
          "https://drive.google.com/uc?id=1QIWPS4PwrXhuSrziklJz_2klr4zYB7R-&export=download"
    },
    {
      "name": "سورة الإسراء",
      "path":
          "https://drive.google.com/uc?id=1Oj5Ac2yATwVULucxbECGI17CarjNz3_p&export=download"
    },
    {
      "name": "سورة الكهف",
      "path":
          "https://drive.google.com/uc?id=1DhLjq3jFtqWkZfPKo_h4u59pWyOoO2H4&export=download"
    },
    {
      "name": "سورة مريم",
      "path":
          "https://drive.google.com/uc?id=177p4eHa4jxo6m_FcmG3WK8yjfLXvzTCj&export=download"
    },
    {
      "name": "سورة طه",
      "path":
          "https://drive.google.com/uc?id=1SCtw_fJmrqOa7cpmPqSmWJ3rRyjGiz9U&export=download"
    },
    {
      "name": "سورة الأنبياء",
      "path":
          "https://drive.google.com/uc?id=1rKlquLMXneL1t_ueJ1BgHHl7nxvCdQLn&export=download"
    },
    {
      "name": "سورة الحج",
      "path":
          "https://drive.google.com/uc?id=1baGIcw7kRas0WycnSSasYUuDuXOCI-Dw&export=download"
    },
    {
      "name": "سورة المؤمنون",
      "path":
          "https://drive.google.com/uc?id=1VwPPqMoZzzG_iNp-XzpgwUCIDeEFbdB0&export=download"
    },
    {
      "name": "سورة النور",
      "path":
          "https://drive.google.com/uc?id=1zeEUtupjuPzRV_RWZrnywK67p7eamhWx&export=download"
    },
    {
      "name": "سورة الفرقان",
      "path":
          "https://drive.google.com/uc?id=1HOfpO5DZUi0bQ76pthCnBKBjflQUeF__&export=download"
    },
    {
      "name": "سورة الشعراء",
      "path":
          "https://drive.google.com/uc?id=1WvYWRjZjcfDOKd6krRPlFs2DE3ea6mvl&export=download"
    },
    {
      "name": "سورة النمل",
      "path":
          "https://drive.google.com/uc?id=1wLZQM25ObYFD406nQSPveSNpIm9UAHln&export=download"
    },
    {
      "name": "سورة القصص",
      "path":
          "https://drive.google.com/uc?id=1AykucsZOQVPwB1Gs6qq-rZyV9v5h7B-P&export=download"
    },
    {
      "name": "سورة العنكبوت",
      "path":
          "https://drive.google.com/uc?id=1VG41qqRLrGo-dG-g2ZGEe3dItRzn2u4O&export=download"
    },
    {
      "name": "سورة الروم",
      "path":
          "https://drive.google.com/uc?id=1lnlJmaMjD2XB20bQOsXbfuC04UZifVgq&export=download"
    },
    {
      "name": "سورة لقمان",
      "path":
          "https://drive.google.com/uc?id=1jt5dQnakA0u0SueL0A-I04i5JiO5kKyI&export=download"
    },
    {
      "name": "سورة السجدة",
      "path":
          "https://drive.google.com/uc?id=1nzJGqpEgceyJkMvc_uHOaP-hjnfEKAoZ&export=download"
    },
    {
      "name": "سورة الأحزاب",
      "path":
          "https://drive.google.com/uc?id=1pdvNZ1_rY2zCT8H_vaFK4WQV-zSY4sYy&export=download"
    },
    {
      "name": "سورة سبأ",
      "path":
          "https://drive.google.com/uc?id=1gG-DQ4c-y9shv0Pmnr8mlkQav_V8C7Aj&export=download"
    },
    {
      "name": "سورة فاطر",
      "path":
          "https://drive.google.com/uc?id=19JFlIE3XwOAk5ThBWBs9qP5Lg0ZOabEi&export=download"
    },
    {
      "name": "سورة يس",
      "path":
          "https://drive.google.com/uc?id=1ELXHGqL6XnR_l9X_XqVW6wBPvMGf6bqn&export=download"
    },
    {
      "name": "سورة الصافات",
      "path":
          "https://drive.google.com/uc?id=1ZJ35QBynnL6HR9Q4tkn0CumKZvKtDhwt&export=download"
    },
    {
      "name": "سورة ص",
      "path":
          "https://drive.google.com/uc?id=1j6WoIOitGoUNDAEdSCNRPX2IbcRsuyCs&export=download"
    },
    {
      "name": "سورة الزمر",
      "path":
          "https://drive.google.com/uc?id=1RoDeNTgN7ANV5vn94RIOT0_D63b5agJp&export=download"
    },
    {
      "name": "سورة غافر",
      "path":
          "https://drive.google.com/uc?id=1YDJ57L5xFiWnKGPzuk_smPIm7LGuorq0&export=download"
    },
    {
      "name": "سورة فصلت",
      "path":
          "https://drive.google.com/uc?id=1sqg7-WYUpdsEMZNUUz-x4qHui-EnSmZh&export=download"
    },
    {
      "name": "سورة الشورى",
      "path":
          "https://drive.google.com/uc?id=1Zsgjm3zf5AurBegFQvsW7-ajHDsaSo-k&export=download"
    },
    {
      "name": "سورة الزخرف",
      "path":
          "https://drive.google.com/uc?id=1hh2F1TlTOiCm3c5DwHetWQbrxC1Biexh&export=download"
    },
    {
      "name": "سورة الدخان",
      "path":
          "https://drive.google.com/uc?id=1_gbBIk4102raVK9bHp-lr-y2OK3u7xuE&export=download"
    },
    {
      "name": "سورة الجاثية",
      "path":
          "https://drive.google.com/uc?id=1mY5M1U5Q5WR5V7DCbA0QJR6f3qVWO8wF&export=download"
    },
    {
      "name": "سورة الأحقاف",
      "path":
          "https://drive.google.com/uc?id=1awwMHHJ6i0uwc1sMq0RD1g0H2rP7Slmj&export=download"
    },
    {
      "name": "سورة محمد",
      "path":
          "https://drive.google.com/uc?id=1ViPqxbrSz1V1Ts6vk_BGUasJ9l22CkJ3&export=download"
    },
    {
      "name": "سورة الفتح",
      "path":
          "https://drive.google.com/uc?id=19LiQkKNK130YvO102h2W2D0D27DOE531&export=download"
    },
    {
      "name": "سورة الحجرات",
      "path":
          "https://drive.google.com/uc?id=1ANISqW7uiiNmJ4t-AxW6UkGa7Z_WzKEU&export=download"
    },
    {
      "name": "سورة ق",
      "path":
          "https://drive.google.com/uc?id=15DeeViRoZCUFLVvsUG8F5-kj3oMmL-Tr&export=download"
    },
    {
      "name": "سورة الذاريات",
      "path":
          "https://drive.google.com/uc?id=14ryzfwWJG8QTOnLapfJeaKUc14-wkXS1&export=download"
    },
    {
      "name": "سورة الطور",
      "path":
          "https://drive.google.com/uc?id=1JgmupP_0xIEMB08qIlgeZDd4asWAbpZ-&export=download"
    },
    {
      "name": "سورة النجم",
      "path":
          "https://drive.google.com/uc?id=1gSvJ34-sPyPrRbYCIQj1eR1T9n0wqnsZ&export=download"
    },
    {
      "name": "سورة القمر",
      "path":
          "https://drive.google.com/uc?id=1HsVVSFlP8rIo71jK5peFaK0ujIF0UJVD&export=download"
    },
    {
      "name": "سورة الرحمن",
      "path":
          "https://drive.google.com/uc?id=1RMW1uWb4vwfCWAKbnpdgE6EFMk_tq0-t&export=download"
    },
    {
      "name": "سورة الواقعة",
      "path":
          "https://drive.google.com/uc?id=1VkuCwge1PSYYDrxYQx6-C35Hj3R7DDQm&export=download"
    },
    {
      "name": "سورة الحديد",
      "path":
          "https://drive.google.com/uc?id=1_LyvNnD0AM_ixR9TDG2ZF6yXrqMgXxNf&export=download"
    },
    {
      "name": "سورة المجادلة",
      "path":
          "https://drive.google.com/uc?id=1kpFqyx0Zuqmm5AokbO8fNEOY-OPVrC4O&export=download"
    },
    {
      "name": "سورة الحشر",
      "path":
          "https://drive.google.com/uc?id=1SbMEhhNfyHPvPh8gisgOxIYExW2BJZdw&export=download"
    },
    {
      "name": "سورة الممتحنة",
      "path":
          "https://drive.google.com/uc?id=1iMlp008PEkdyA_dZYGPJKVZ156-aXSb6&export=download"
    },
    {
      "name": "سورة الصف",
      "path":
          "https://drive.google.com/uc?id=1CPDRX-ehJ5Z5WxgYY0jXSLLPNFbnAhle&export=download"
    },
    {
      "name": "سورة الجمعة",
      "path":
          "https://drive.google.com/uc?id=18xVUn7Dv_IRVOALW-D7FFoGr8yIKcrep&export=download"
    },
    {
      "name": "سورة المنافقون",
      "path":
          "https://drive.google.com/uc?id=19K796RcU31097e4IN4CsZllRTW1XK_2v&export=download"
    },
    {
      "name": "سورة التغابن",
      "path":
          "https://drive.google.com/uc?id=1PPtPhASEJIXQk7YPeYlOAyvBWPdS3GdN&export=download"
    },
    {
      "name": "سورة الطلاق",
      "path":
          "https://drive.google.com/uc?id=1x8r_8_f12x1w1Hs-byOWtoBLDYL8tHHo&export=download"
    },
    {
      "name": "سورة التحريم",
      "path":
          "https://drive.google.com/uc?id=1tiF3T_RS6y1nLqx0_BWsMsFR844hobCz&export=download"
    },
    {
      "name": "سورة الملك",
      "path":
          "https://drive.google.com/uc?id=1dOrbzpOcopNUD0CT5HDmyi3l2CqtYlv6&export=download"
    },
    {
      "name": "سورة القلم",
      "path":
          "https://drive.google.com/uc?id=13JqEgDXBpw0GRWOyscgcO2oUxRybvzQh&export=download"
    },
    {
      "name": "سورة الحاقة",
      "path":
          "https://drive.google.com/uc?id=1v7LuSSmbF-o-w5yneY1y-x6f6OnCEE18&export=download"
    },
    {
      "name": "سورة المعارج",
      "path":
          "https://drive.google.com/uc?id=1msG01rm9wXawrjLQ3jnoAQJIrUXFeFWU&export=download"
    },
    {
      "name": "سورة نوح",
      "path":
          "https://drive.google.com/uc?id=1xOg86r9id26ZOA88MpxzjSF0PwEkjzys&export=download"
    },
    {
      "name": "سورة الجن",
      "path":
          "https://drive.google.com/uc?id=1fJ85je3w0pgBuErMbprSVPjB2R3Pq4TH&export=download"
    },
    {
      "name": "سورة المزمل",
      "path":
          "https://drive.google.com/uc?id=1Fy-Sn6TIzPQmET0n8ED7n2DYn9Rrw2sT&export=download"
    },
    {
      "name": "سورة المدثر",
      "path":
          "https://drive.google.com/uc?id=1RXKCLFZVlavxVn2McdCwHuZN-b-MX5LI&export=download"
    },
    {
      "name": "سورة القيامة",
      "path":
          "https://drive.google.com/uc?id=1jvi4GZg6D2diPHw9Qyjql-EGYwwSN58U&export=download"
    },
    {
      "name": "سورة الإنسان",
      "path":
          "https://drive.google.com/uc?id=17vvjoN_u2Pbi_ULbvqou-aU5pEPPw9qM&export=download"
    },
    {
      "name": "سورة المرسلات",
      "path":
          "https://drive.google.com/uc?id=15YdSQm3g2SWVitxaNkr915ljipFDiVXW&export=download"
    },
    {
      "name": "سورة النبأ",
      "path":
          "https://drive.google.com/uc?id=1KA1aarj9d-P98AhM7OILyxaA0WttReEW&export=download"
    },
    {
      "name": "سورة النازعات",
      "path":
          "https://drive.google.com/uc?id=1VGA2JMSIX04PrTQv29374woY2dpgvlcS&export=download"
    },
    {
      "name": "سورة عبس",
      "path":
          "https://drive.google.com/uc?id=1ktYTpBCdMOwV5xv1I6wn68K4nTYtT6H2&export=download"
    },
    {
      "name": "سورة التكوير",
      "path":
          "https://drive.google.com/uc?id=1zDa1Ser7JjyYJ1Hozsr5Mj_xCeSLY9uH&export=download"
    },
    {
      "name": "سورة الإنفطار",
      "path":
          "https://drive.google.com/uc?id=1JgPU1n5JwY931XhIfjl2tI2t-tmA1E2W&export=download"
    },
    {
      "name": "سورة المطففين",
      "path":
          "https://drive.google.com/uc?id=11WYEJJcO_Ydvsdm4vIqCepJ7g6LUObED&export=download"
    },
    {
      "name": "سورة الإنشقاق",
      "path":
          "https://drive.google.com/uc?id=1HBq7smsLpZnej37Hvjj8pGMEbh-htLkz&export=download"
    },
    {
      "name": "سورة البروج",
      "path":
          "https://drive.google.com/uc?id=1u0eu4qQqX688ZTDGgethybYqr-VExb2K&export=download"
    },
    {
      "name": "سورة الطارق",
      "path":
          "https://drive.google.com/uc?id=1JEcnhCj47a7MaZcfb-mYG4uS-wl5o9dH&export=download"
    },
    {
      "name": "سورة الأعلى",
      "path":
          "https://drive.google.com/uc?id=1xYTZqD60XKQovAG-vqWDWeOCQ_8Dsr6q&export=download"
    },
    {
      "name": "سورة الغاشية",
      "path":
          "https://drive.google.com/uc?id=1w1_-a4BHh659o8twmV7brxvreBpYxUl2&export=download"
    },
    {
      "name": "سورة الفجر",
      "path":
          "https://drive.google.com/uc?id=1fkGIyLqZ8WFmTeOVy-1-pYOido1rTxG9&export=download"
    },
    {
      "name": "سورة البلد",
      "path":
          "https://drive.google.com/uc?id=1nVtyjlUs_ZR7l6txkyVmB-bpO9pWn9Ih&export=download"
    },
    {
      "name": "سورة الشمس",
      "path":
          "https://drive.google.com/uc?id=1EX9sET17l9kKhhEzhaBWtoOoW78El_SK&export=download"
    },
    {
      "name": "سورة الليل",
      "path":
          "https://drive.google.com/uc?id=1zfU4bOPz84TNrpeAV_2I6k5mjVQuwD_i&export=download"
    },
    {
      "name": "سورة الضحى",
      "path":
          "https://drive.google.com/uc?id=1az9i29BEJqinOAFPPcT2AjcREQau7AF-&export=download"
    },
    {
      "name": "سورة الشرح",
      "path":
          "https://drive.google.com/uc?id=1v6EPb9Vbb3MoWpNK2yYTmzXNcOaHeuPI&export=download"
    },
    {
      "name": "سورة التين",
      "path":
          "https://drive.google.com/uc?id=1FxeDnQ_R6u_EkKvdUIjGZur_FxDjllUz&export=download"
    },
    {
      "name": "سورة العلق",
      "path":
          "https://drive.google.com/uc?id=1kMIPXX9neQwMtYJNI4UwVL6RK-sl7b6D&export=download"
    },
    {
      "name": "سورة القدر",
      "path":
          "https://drive.google.com/uc?id=15mXZpYuFaRuHw4teQ3p4s3PFSg5gnt1C&export=download"
    },
    {
      "name": "سورة البينة",
      "path":
          "https://drive.google.com/uc?id=1Z89o298B1Kb6kzTK3lN-85edRxUs4L9u&export=download"
    },
    {
      "name": "سورة الزلزلة",
      "path":
          "https://drive.google.com/uc?id=1iV4BFU0PADCuJr8xaK2hg0DKe1p5HBmB&export=download"
    },
    {
      "name": "سورة العاديات",
      "path":
          "https://drive.google.com/uc?id=1UnMTfJPdpspMzRuTi44ISUUCCAu0VgAQ&export=download"
    },
    {
      "name": "سورة القارعة",
      "path":
          "https://drive.google.com/uc?id=1JKVQM2KoNT6msbWEkBN3uVFO2Up1SdTM&export=download"
    },
    {
      "name": "سورة التكاثر",
      "path":
          "https://drive.google.com/uc?id=1VDglqBneOjBuxTChY_ul-cKp9FGr0AJ5&export=download"
    },
    {
      "name": "سورة العصر",
      "path":
          "https://drive.google.com/uc?id=1vjVzxdA9GORlIhSwGy5eHoUIk6KVtRHm&export=download"
    },
    {
      "name": "سورة الهمزة",
      "path":
          "https://drive.google.com/uc?id=1erVDS3axOpTYV-08WHkqlnp9er7HlGDB&export=download"
    },
    {
      "name": "سورة الفيل",
      "path":
          "https://drive.google.com/uc?id=1MfV2ux_i7l0Vd_sIRoqOik0Ft1axvLAL&export=download"
    },
    {
      "name": "سورة قريش",
      "path":
          "https://drive.google.com/uc?id=1D2shoMqirj6tGnvirPypAEsLktSQeOWH&export=download"
    },
    {
      "name": "سورة الماعون",
      "path":
          "https://drive.google.com/uc?id=1npugVFTd7JNWJcMCUMmChyrgxlCpud2H&export=download"
    },
    {
      "name": "سورة الكوثر",
      "path":
          "https://drive.google.com/uc?id=1mGgGefo3S_g2JMuzQSPFFGwStObSJiKk&export=download"
    },
    {
      "name": "سورة الكافرون",
      "path":
          "https://drive.google.com/uc?id=1zzCmMuxK4Bqo_YGAovJ-DrIm9zi8YO0g&export=download"
    },
    {
      "name": "سورة النصر",
      "path":
          "https://drive.google.com/uc?id=1YPdsn2tGDmFa4Nfbx9gG2wc5VJhdNZKr&export=download"
    },
    {
      "name": "سورة المسد",
      "path":
          "https://drive.google.com/uc?id=1mepaM6igLQ_MOH0XozI7kYwngo8Drie6&export=download"
    },
    {
      "name": "سورة الإخلاص",
      "path":
          "https://drive.google.com/uc?id=1tbsSlCIperPiMG7bCFTIY-vJ02y9hK4N&export=download"
    },
    {
      "name": "سورة الفلق",
      "path":
          "https://drive.google.com/uc?id=1KScgfgZrbuIlSBv8GEVIlTiKMEym7vCA&export=download"
    },
    {
      "name": "سورة الناس",
      "path":
          "https://drive.google.com/uc?id=1DqMkvE1yLkN1-zewvnw6KSreBi8-bq38&export=download"
    },
  ];
  // متغير لتخزين نص البحث
  String _searchText = '';
  final TextEditingController _searchController = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  String _currentSurah = '';
  Map<String, Duration> _currentPositions = {};
  Map<String, Duration> _totalDurations = {};
  bool _isBuffering = false; // متغير لتحديد حالة التحميل

  // متغير لتخزين حالة الوضع (Dark/Light)
  @override
  void initState() {
    super.initState();
    _audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        _currentPositions[_currentSurah] = position;
      });
    });
  }

  @override
  void dispose() {
    _stopAudio(); // إيقاف الصوت عند التخلص من الصفحة
    _searchController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _seekAudio(double value, String surahPath) async {
    try {
      setState(() {
        _isBuffering = true; // بدء حالة التحميل
      });

      final position = Duration(seconds: value.toInt());
      await _audioPlayer.seek(position);

      // تحديث الموضع الحالي بعد التقديم
      setState(() {
        _currentPositions[surahPath] = position;
        _isBuffering = false; // إنهاء حالة التحميل
      });
    } catch (e) {
      setState(() {
        _isBuffering = false; // إنهاء حالة التحميل في حال حدوث خطأ
      });
      print("Error while seeking: $e");
    }
  }

  Future<void> _toggleAudio(String surahPath) async {
    try {
      // التحقق من الاتصال بالإنترنت
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("خطأ"),
                content: const Text(
                    "لا يوجد اتصال بالإنترنت. يرجى التحقق من الاتصال."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("حسناً"),
                  ),
                ],
              );
            },
          );
        }
        return; // الخروج من الوظيفة
      }

      setState(() {
        _isBuffering = true; // بدء التحميل
      });

      // التحقق من حالة التشغيل
      if (_isPlaying && _currentSurah == surahPath) {
        await _audioPlayer.pause();
        setState(() {
          _isPlaying = false;
          _isBuffering = false; // إيقاف التحميل
        });
      } else {
        if (_isPlaying) {
          await _audioPlayer.stop();
        }
        await _audioPlayer.play(UrlSource(surahPath));
        setState(() {
          _isPlaying = true;
          _currentSurah = surahPath;
          _isBuffering = false; // انتهاء التحميل
        });

        // الحصول على مدة السورة
        Duration? duration = await _audioPlayer.getDuration();
        if (duration != null) {
          setState(() {
            _totalDurations[surahPath] = duration;
          });
        }
      }
    } catch (e) {
      setState(() {
        _isBuffering = false; // انتهاء التحميل عند الخطأ
      });
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("خطأ"),
              content: Text("حدث خطأ أثناء التشغيل: $e"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("حسناً"),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void _restartAudio(String surahPath) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(UrlSource(surahPath)); // استخدام UrlSource
    setState(() {
      _isPlaying = true;
      _currentSurah = surahPath;
    });
  }

  void _stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
      _currentSurah = '';
    });
  }

  ListTile addSurah(String surahName, String surahPath) {
    Duration currentPosition = _currentPositions[surahPath] ?? Duration.zero;
    Duration totalDuration = _totalDurations[surahPath] ?? Duration.zero;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      leading: Stack(
        alignment: Alignment.center,
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage("images/bander.webp"),
            radius: 50,
          ),
        ],
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  surahName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Changa",
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "- بندر بليلة",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    fontFamily: "Changa",
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white70
                        : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  _isPlaying && _currentSurah == surahPath
                      ? Icons.pause
                      : Icons.play_arrow,
                  color: Colors.green,
                  size: 30,
                ),
                onPressed: () => _toggleAudio(surahPath),
              ),
              IconButton(
                icon: const Icon(
                  Icons.replay,
                  color: Colors.blue,
                  size: 30,
                ),
                onPressed: () => _restartAudio(surahPath),
              ),
            ],
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Slider(
            value: currentPosition.inSeconds.toDouble(),
            max: totalDuration.inSeconds.toDouble().clamp(1.0, double.infinity),
            onChanged: (double value) =>
                _seekAudio(value, surahPath), // استدعاء الوظيفة المعدلة
          ),
          Text(
            '${_formatDuration(currentPosition)} / ${_formatDuration(totalDuration)}',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white70
                  : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return hours != "00" ? '$hours:$minutes:$seconds' : '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeNotifier>(context);

    final filteredSurahs = _surahs.where((surah) {
      return surah["name"]!.toLowerCase().contains(_searchText.toLowerCase());
    }).toList();

    return WillPopScope(
      onWillPop: () async {
        _stopAudio();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeProvider.isDarkMode ? Colors.blue : null,
          title: const Text(
            "Quran - بندر بليلة",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: "Changa",
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: themeProvider.toggleTheme,
            ),
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _searchController,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      decoration: const InputDecoration(
                        labelText: 'ابحث عن سورة',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchText = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredSurahs.length,
                      itemBuilder: (context, index) {
                        final surah = filteredSurahs[index];
                        return Column(
                          children: [
                            addSurah(surah["name"]!, surah["path"]!),
                            const Divider(
                              thickness: 2,
                              color: Colors.grey,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
              if (_isBuffering)
                Positioned(
                  top: 10, // موضع المؤشر بالنسبة للجزء العلوي
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: const Color.fromARGB(255, 157, 65, 231),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
