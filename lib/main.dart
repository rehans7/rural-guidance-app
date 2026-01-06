import 'package:flutter/material.dart';
import 'chat_page.dart';
import 'package:flutter/services.dart';

final PageController pageController = PageController(initialPage: 1);
final ScrollController storyScrollController = ScrollController();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SwipeHome(),
    );
  }
}

class SwipeHome extends StatelessWidget {
  const SwipeHome({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: const [CareerPage(), MainPage(), SocialPage()],
    );
  }
}

class CareerPage extends StatefulWidget {
  const CareerPage({super.key});

  @override
  State<CareerPage> createState() => _CareerPageState();
}

class _CareerPageState extends State<CareerPage> {
  final List<String> careers = [
    "Doctor",
    "Engineering",
    "Mechanic",
    "Government Exams",
    "Police Officer",
    "Teacher",
    "Farmer",
    "Business",
    "Electrician",
    "Army",
  ];

  final Set<String> selectedCareers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            pageController.animateToPage(
              1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
        title: const Text(
          "Career Guidance",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E3A8A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADING
            const Text(
              "Is there a specific career you're curious about?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            // CAREER OPTIONS
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: careers.map((career) {
                final isSelected = selectedCareers.contains(career);
                return ChoiceChip(
                  label: Text(career),
                  selected: isSelected,
                  selectedColor: const Color(0xFF1E3A8A),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  onSelected: (value) {
                    setState(() {
                      if (value) {
                        selectedCareers.add(career);
                      } else {
                        selectedCareers.remove(career);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            const Spacer(),

            // SUBMIT BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedCareers.isEmpty
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SelectedCareersPage(
                              careers: selectedCareers.toList(),
                            ),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E3A8A),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
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

class CareerDetailPage extends StatelessWidget {
  final String career;

  const CareerDetailPage({super.key, required this.career});

  Map<String, dynamic> getCareerInfo(String career) {
    return {
          "Doctor": {
            "salary": "₹50k – ₹1.5L/month",
            "growth": "High demand, respected",
            "flexibility": "Low (long hours)",
            "time": "8–10 years",
            "roadmap": [
              "Study PCB in 11th & 12th",
              "Write NEET exam",
              "Join MBBS",
              "Internship + specialization",
              "Apply for govt/private hospitals",
            ],
            "disadvantages": [
              "Long study time",
              "High study cost",
              "Less personal time",
              "High work pressure",
            ],
          },
          "Engineering": {
            "salary": "₹30k – ₹1L/month",
            "growth": "Very good if skilled",
            "flexibility": "Medium",
            "time": "4–6 years",
            "roadmap": [
              "Study MPC in 11th & 12th",
              "Write JEE / EAMCET",
              "Join engineering college",
              "Build skills + internships",
              "Apply for jobs or MTech",
            ],
            "disadvantages": [
              "High competition",
              "Jobs need strong skills",
              "College fees can be high",
              "Some branches have low demand",
            ],
          },
          "Mechanic": {
            "salary": "₹20k – ₹50k/month",
            "growth": "Good with experience",
            "flexibility": "High",
            "time": "1–2 years",
            "roadmap": [
              "Join ITI or local training",
              "Learn hands-on repair",
              "Work under senior mechanic",
              "Open own workshop",
              "Increase skills gradually",
            ],
            "disadvantages": [
              "Physically tiring work",
              "Income depends on work",
              "Risk of injuries",
              "Needs constant skill update",
            ],
          },
          "Government Exams": {
            "salary": "₹40k – ₹80k/month",
            "growth": "Stable career",
            "flexibility": "Medium",
            "time": "2–5 years",
            "roadmap": [
              "Choose exam (Group 2, SSC, etc.)",
              "Complete graduation",
              "Daily preparation",
              "Write exams + interview",
              "Join govt service",
            ],
            "disadvantages": [
              "Very tough competition",
              "Long preparation time",
              "No guarantee of selection",
              "Mental stress during exams",
            ],
          },
          "Police Officer": {
            "salary": "₹35k – ₹60k/month",
            "growth": "Stable & respected",
            "flexibility": "Low",
            "time": "2–4 years",
            "roadmap": [
              "Complete 12th / degree",
              "Physical fitness training",
              "Write police recruitment exam",
              "Clear physical & interview",
              "Join police force",
            ],
            "disadvantages": [
              "Physical risk",
              "Long duty hours",
              "High work stress",
              "Less family time",
            ],
          },
          "Teacher": {
            "salary": "₹25k – ₹60k/month",
            "growth": "Stable, respected career",
            "flexibility": "Medium",
            "time": "3–5 years",
            "roadmap": [
              "Complete graduation",
              "Do B.Ed or D.El.Ed",
              "Write teacher eligibility test (TET)",
              "Apply for govt or private schools",
              "Gain experience and promotions",
            ],
            "disadvantages": [
              "Salary grows slowly",
              "Needs patience",
              "Government jobs are competitive",
              "Limited flexibility in schedule",
            ],
          },
          "Farmer": {
            "salary": "₹15k – ₹22k/month",
            "growth": "Good with modern methods",
            "flexibility": "High",
            "time": "1–2 years",
            "roadmap": [
              "Learn modern farming techniques",
              "Use government agriculture schemes",
              "Attend local farming training",
              "Use better seeds & tools",
              "Sell produce directly to markets",
            ],
            "disadvantages": [
              "Income depends on weather",
              "Hard physical work",
              "Market price changes",
              "Initial investment needed",
            ],
          },
          "Business": {
            "salary": "₹20k – Unlimited",
            "growth": "Very high if successful",
            "flexibility": "High",
            "time": "2–5 years",
            "roadmap": [
              "Choose a business idea",
              "Learn basic money management",
              "Start small with local market",
              "Register business if needed",
              "Grow slowly with experience",
            ],
            "disadvantages": [
              "Income not stable",
              "Risk of loss",
              "Needs good planning",
              "Takes time to grow",
            ],
          },
          "Electrician": {
            "salary": "₹20k – ₹20k/month",
            "growth": "High demand skill",
            "flexibility": "High",
            "time": "1–2 years",
            "roadmap": [
              "Join ITI electrician course",
              "Learn practical electrical work",
              "Work under experienced electrician",
              "Get safety certification",
              "Start own service or join company",
            ],
            "disadvantages": [
              "Risk of electric shock",
              "Physically demanding work",
              "Income depends on clients",
              "Needs safety precautions",
            ],
          },
          "Army": {
            "salary": "₹30k – ₹70k/month",
            "growth": "Secure & respected",
            "flexibility": "Low",
            "time": "2–4 years",
            "roadmap": [
              "Complete 10th or 12th",
              "Prepare physically and mentally",
              "Apply for army recruitment",
              "Clear written & physical tests",
              "Complete training and join service",
            ],
            "disadvantages": [
              "High physical risk",
              "Long time away from family",
              "Strict discipline",
              "Transfers to remote areas",
            ],
          },
        }[career] ??
        {};
  }

  @override
  Widget build(BuildContext context) {
    final info = getCareerInfo(career);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          career,
          style: TextStyle(color: Colors.white), // Set the text color to white
        ),
        backgroundColor: const Color(0xFF1E3A8A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _infoTile("Salary", info["salary"]),
            _infoTile("Growth", info["growth"]),
            _infoTile("Flexibility", info["flexibility"]),
            _infoTile("Time to reach good level", info["time"]),

            const SizedBox(height: 20),

            const Text(
              "ROADMAP",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ...(info["roadmap"] as List<String>).map(
              (step) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("• "),
                    Expanded(child: Text(step)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "DISADVANTAGES",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ...(info["disadvantages"] as List<String>).map(
              (point) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("⚠️ "),
                    Expanded(
                      child: Text(point, style: const TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectedCareersPage extends StatelessWidget {
  final List<String> careers;

  const SelectedCareersPage({super.key, required this.careers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Your Selected Careers",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "You are curious about:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: careers.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(
                            255,
                            255,
                            255,
                            255,
                          ).withOpacity(0.08),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        careers[index],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                CareerDetailPage(career: careers[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1E3A8A), // Deep Blue
                Color(0xFF3B82F6), // Lighter Blue
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          "Rural Guidance",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // CHATBOT CARD
            Builder(
              builder: (context) {
                final height = MediaQuery.of(context).size.height;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChatPage()),
                    );
                  },
                  child: Container(
                    height: height * 0.30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF1E3A8A), // Deep Blue
                          Color(0xFF3B82F6), // Lighter Blue
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.smart_toy_outlined,
                            size: 40,
                            color: Colors.white,
                          ),
                          SizedBox(height: 12),
                          Text(
                            "Ask your doubt",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Get instant guidance and clarity",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      "Success Stories",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Expanded(
                    child: ListView(
                      controller: storyScrollController,
                      scrollDirection: Axis.horizontal,
                      children: [
                        _storyCard(
                          "From Village School to IIT Bombay",
                          "assets/stories/iit.jpg",
                        ),
                        _storyCard(
                          "Auto Driver’s Daughter Joins ISRO",
                          "assets/stories/isro.jpg",
                        ),
                        _storyCard(
                          "Farmer’s Son Cracks UPSC in First Attempt",
                          "assets/stories/upsc.jpg",
                        ),
                        _storyCard(
                          "Small Town Student Gets Google Internship",
                          "assets/stories/google.jpg",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // BUTTONS — remaining space
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Career Button (Blue)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        pageController.animateToPage(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      icon: const Icon(Icons.work_outline),
                      label: const Text(
                        "Career Guidance",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A8A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 6,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Social Button (Orange)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        pageController.animateToPage(
                          2,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      icon: const Icon(Icons.people_outline),
                      label: const Text(
                        "Social Skills",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF59E0B),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SocialPage extends StatelessWidget {
  const SocialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            pageController.animateToPage(
              1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
        title: const Text(
          "Social Skills",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E3A8A),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _socialTile(
            context,
            icon: Icons.record_voice_over,
            title: "How to Speak Confidently",
            content:
                "Confidence comes from clarity and practice.\n\n"
                "• Speak slowly and clearly\n"
                "• Maintain eye contact\n"
                "• Practice daily in front of a mirror\n"
                "• Do not fear mistakes\n\n"
                "Confidence grows when action is repeated.",
          ),
          _socialTile(
            context,
            icon: Icons.group,
            title: "Improve Communication Skills",
            content:
                "Good communication builds respect and opportunities.\n\n"
                "• Listen more than you speak\n"
                "• Use simple words\n"
                "• Ask questions politely\n"
                "• Respect others’ opinions\n\n"
                "Strong communication changes lives.",
          ),
          _socialTile(
            context,
            icon: Icons.school,
            title: "Scholarships for Students",
            content:
                "Many students miss opportunities due to lack of awareness.\n\n"
                "• Government scholarships\n"
                "• Minority & merit scholarships\n"
                "• College-based financial aid\n\n"
                "Always check official portals regularly.",
          ),
          _socialTile(
            context,
            icon: Icons.work_outline,
            title: "Internships for Beginners",
            content:
                "Internships build real-world experience.\n\n"
                "• Start with small companies\n"
                "• Learn skills online\n"
                "• Apply on LinkedIn & Internshala\n"
                "• Do unpaid internships if needed initially\n\n"
                "Experience matters more than salary at start.",
          ),
        ],
      ),
    );
  }
}

Widget _socialTile(
  BuildContext context, {
  required IconData icon,
  required String title,
  required String content,
}) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Scaffold(
            backgroundColor: const Color(0xFFF5F7FB),
            appBar: AppBar(
              backgroundColor: const Color(0xFF1E3A8A),
              title: Text(title, style: const TextStyle(color: Colors.white)),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                content,
                style: const TextStyle(fontSize: 16, height: 1.6),
              ),
            ),
          ),
        ),
      );
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFFF59E0B), Color(0xFFFBBF24)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
        ],
      ),
    ),
  );
}

Widget _storyCard(String title, String imagePath) {
  return InkWell(
    onTap: () {
      String storyText;

      if (title.contains("IIT")) {
        storyText =
            "Coming from a remote village school with minimal facilities, this student "
            "studied under streetlights and shared textbooks.\n\n"
            "With strong basics, self-study, and discipline, he cleared JEE and secured "
            "a seat at IIT Bombay.\n\n"
            "Today, he inspires thousands of rural students to dream big.";
      } else if (title.contains("ISRO")) {
        storyText =
            "Raised by an auto driver, this girl faced financial struggles from childhood.\n\n"
            "Despite obstacles, she stayed consistent in science and mathematics, using "
            "free resources and scholarships.\n\n"
            "Her dedication led her to join ISRO, proving talent beats circumstances.";
      } else if (title.contains("UPSC")) {
        storyText =
            "Son of a farmer, limited income, no coaching institutes nearby.\n\n"
            "He relied on NCERTs, newspapers, and discipline.\n\n"
            "In his first attempt, he cracked UPSC, showing that focus and patience win.";
      } else {
        storyText =
            "From a small town with little exposure, this student learned coding online.\n\n"
            "Through projects, consistency, and self-belief, he earned a Google internship.\n\n"
            "A reminder that global opportunities are possible from anywhere.";
      }

      Navigator.push(
        pageController.position.context.storageContext,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF1E3A8A),
              title: const Text(
                "Success Story",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    imagePath,
                    height: 240,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  storyText,
                  style: const TextStyle(fontSize: 16, height: 1.6),
                ),
              ],
            ),
          ),
        ),
      );
    },
    child: Container(
      width: 220,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            child: Stack(
              children: [
                Image.asset(
                  imagePath,
                  height: 110,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 110,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.15),
                        Colors.black.withOpacity(0.55),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 6),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "Tap to read full story",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _infoTile(String title, String value) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6),
      ],
    ),
    child: Row(
      children: [
        Text("$title: ", style: const TextStyle(fontWeight: FontWeight.bold)),
        Expanded(child: Text(value)),
      ],
    ),
  );
}
