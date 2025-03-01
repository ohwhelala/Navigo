import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Import package

void main() {
  runApp(NaviGoApp());
}

class NaviGoApp extends StatelessWidget {
  const NaviGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NaviGo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  List<Map<String, String>> introData = [
    {
      "title": "NaviGo",
      "subtitle": "Your smart, real-time navigation assistant",
      "image": "assets/logo.png",
      "buttonText": "Get Started",
    },
    {
      "title": "Stay ahead with real-time updates",
      "image": "assets/real_time.gif",
      "buttonText": "Next",
    },
    {
      "title": "Customized navigation",
      "image": "assets/custom_navigation.gif",
      "buttonText": "Next",
    },
    {
      "title":
          "Navigate with options to reduce fuel consumption and carbon emissions.",
      "image": "assets/setting_lp.gif",
      "buttonText": "Next",
    },
    {
      "title": "A quick guide on how to use the application",
      "image": "assets/search_lp.png",
      "subtitle": "Step 1: Search for your destination",
      "buttonText": "Next",
    },
    {
      "title": "A quick guide on how to use the application",
      "image": "assets/destination_lp.png",
      "subtitle":
          "Step 2: Click the check ✓ button to confirm your destination",
      "buttonText": "Next",
    },
    {
      "title": "A quick guide on how to use the application",
      "image": "assets/transpo_lp.png",
      "subtitle": "Step 3: Choose your mode of transportation",
      "buttonText": "Next",
    },
    {
      "title": "A quick guide on how to use the application",
      "image": "assets/go_lp.png",
      "subtitle": "Step 4: Click the 'Start Session' & your route is ready!",
      "buttonText": "Next",
    },
    {
      "title": "Location Access",
      "image": "assets/location.gif",
      "subtitle": "To guide you effectively, allow us to access your location",
      "buttonText": "Allow",
      "isLocationAccessPage": "true",
    },
    {
      "title": "Let's Go!",
      "image": "assets/car.gif",
      "buttonText": "Start Exploring",
    },
  ];

  void _nextPage() {
    if (_currentPage < introData.length - 1) {
      _controller.animateToPage(
        _currentPage + 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      _skipIntro();
    }
  }

  void _skipIntro() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: introData.length,
            itemBuilder:
                (context, index) => IntroContent(
                  title: introData[index]['title'],
                  subtitle: introData[index]['subtitle'],
                  image: introData[index]['image'],
                  buttonText: introData[index]['buttonText'],
                  onNext: _nextPage,
                  isFirstPage: index == 0,
                  isLocationAccessPage: index == 8,
                ),
          ),

          if (_currentPage != 0 &&
              _currentPage != introData.length - 1) // Hide Skip on First Page
            Positioned(
              top: 40,
              right: 20,
              child: TextButton(
                onPressed: _skipIntro,
                child: Row(
                  mainAxisSize:
                      MainAxisSize
                          .min, // Ensures the row takes only needed space
                  children: [
                    Text(
                      "Skip",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Change color as needed
                      ),
                    ),
                    SizedBox(width: 5), // Adds spacing between text and arrow
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                      size: 18,
                    ), // ➡️ Arrow Icon
                  ],
                ),
              ),
            ),
          if (_currentPage != 0 &&
              _currentPage != introData.length - 1) //hide page control
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: SmoothPageIndicator(
                  controller: _controller, // Connects to PageView controller
                  count: introData.length, // Number of pages
                  effect: WormEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    activeDotColor: Colors.blue, // Active dot color
                    dotColor: Colors.grey.shade400, // Inactive dot color
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class IntroContent extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? image;
  final String? buttonText;
  final VoidCallback onNext;
  final bool isFirstPage;
  final bool isLocationAccessPage;

  const IntroContent({
    super.key,
    this.title,
    this.subtitle,
    this.image,
    this.buttonText,
    required this.onNext,
    required this.isFirstPage,
    this.isLocationAccessPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (image != null)
              Image.asset(image!, width: 250, height: 250, fit: BoxFit.contain),
            SizedBox(height: 20),
            if (title != null)
              Text(
                title!,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  subtitle!,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4169E1),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(buttonText ?? "Next", style: TextStyle(fontSize: 16)),
            ),
            if (isLocationAccessPage) //
              TextButton(
                onPressed: () => print("Location Access Denied"),
                style: TextButton.styleFrom(backgroundColor: Colors.grey),
                child: Text("Deny", style: TextStyle(color: Colors.black)),
              ),
          ],
        ),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      backgroundColor: Colors.white,
      body: Center(
        child: Text("Registration Page", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
