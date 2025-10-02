import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(const SportsTechApp());
}

class SportsTechApp extends StatelessWidget {
  const SportsTechApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sports Tech',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Arial',
      ),
      home: const SkillsScreen(),
    );
  }
}

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({Key? key}) : super(key: key);

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  int basicCurrentIndex = 0;
  int intermediateCurrentIndex = 0;
  int advancedCurrentIndex = 0;

  final List<Map<String, dynamic>> skillsData = [
    {
      "name": "Dribbling",
      "level": "Basic",
      "image": "assets/images/basketball.jpg",
    },
    {"name": "Passing", "level": "Basic", "image": "assets/images/passing.jpg"},
    {"name": "Running", "level": "Basic", "image": "assets/images/running.jpg"},
    {
      "name": "Vault",
      "level": "Intermediate",
      "image": "assets/images/vault.jpg",
    },
    {
      "name": "Swimming",
      "level": "Intermediate",
      "image": "assets/images/swimming.jpg",
    },
    {
      "name": "Cycling",
      "level": "Intermediate",
      "image": "assets/images/cycling.jpg",
    },
    {
      "name": "Agility",
      "level": "Advanced",
      "image": "assets/images/agility.jpg",
    },
    {
      "name": "Boxing",
      "level": "Advanced",
      "image": "assets/images/boxing.jpg",
    },
    {
      "name": "Tennis Serve",
      "level": "Advanced",
      "image": "assets/images/tennis.jpg",
    },
  ];

  List<Map<String, dynamic>> getSkillsByLevel(String level) {
    return skillsData.where((skill) => skill['level'] == level).toList();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final basicSkills = getSkillsByLevel('Basic');
    final intermediateSkills = getSkillsByLevel('Intermediate');
    final advancedSkills = getSkillsByLevel('Advanced');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white, size: w * 0.07),
          onPressed: () {},
        ),
        title: Container(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.05,
            vertical: h * 0.01,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8),
          ),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'SPORTS ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.045,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1,
                  ),
                ),
                TextSpan(
                  text: 'TECH',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.045,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white, size: w * 0.07),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: h * 0.025),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(
                'BASIC',
                basicSkills,
                const Color(0xFF2D5016),
                'basic',
                w,
                h,
              ),
              SizedBox(height: h * 0.03),
              _buildSection(
                'INTERMEDIATE',
                intermediateSkills,
                const Color(0xFF6B5518),
                'intermediate',
                w,
                h,
              ),
              SizedBox(height: h * 0.03),
              _buildSection(
                'ADVANCED',
                advancedSkills,
                const Color(0xFF5C1515),
                'advanced',
                w,
                h,
              ),
              SizedBox(height: h * 0.1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    String level,
    List<Map<String, dynamic>> skills,
    Color badgeColor,
    String levelType,
    double w,
    double h,
  ) {
    int currentIdx = levelType == 'basic'
        ? basicCurrentIndex
        : levelType == 'intermediate'
        ? intermediateCurrentIndex
        : advancedCurrentIndex;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: w * 0.03, bottom: h * 0.019),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.025,
              vertical: h * 0.006,
            ),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              level,
              style: TextStyle(
                color: Colors.white,
                fontSize: w * 0.033,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: h * 0.20,
            viewportFraction: 0.75,
            enlargeCenterPage: true,
            enlargeFactor: 0.35,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            enableInfiniteScroll: skills.length > 1,
            onPageChanged: (index, reason) {
              setState(() {
                if (levelType == 'basic')
                  basicCurrentIndex = index;
                else if (levelType == 'intermediate')
                  intermediateCurrentIndex = index;
                else
                  advancedCurrentIndex = index;
              });
            },
          ),
          items: skills.map((skill) => _buildCard(skill, w, h)).toList(),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: h * 0.019),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(skills.length, (index) {
                return Container(
                  width: w * 0.02,
                  height: w * 0.02,
                  margin: EdgeInsets.symmetric(horizontal: w * 0.0075),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == currentIdx
                        ? Colors.lightBlueAccent
                        : Colors.grey[700],
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCard(Map<String, dynamic> skill, double w, double h) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: w * 0.02),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[800]!, width: 1.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                skill['image'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[900],
                    child: Center(
                      child: Icon(
                        Icons.sports,
                        color: Colors.white54,
                        size: w * 0.125,
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: h * 0.0125,
              left: w * 0.025,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.0375,
                    vertical: h * 0.0025,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    skill['name'].toString().toUpperCase(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: w * 0.033,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
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
