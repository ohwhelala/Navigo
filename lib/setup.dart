import 'package:flutter/material.dart';

void main() {
  runApp(NaviGoApp());
}

class NaviGoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NaviGo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF4169E1),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: OnboardingFlow(),
    );
  }
}

class OnboardingFlow extends StatefulWidget {
  @override
  _OnboardingFlowState createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          InitialSetupScreen(
            onContinue:
                () => _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
          ),
          UsernameScreen(
            onContinue: (String value) {
              _pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
          DateOfBirthScreen(
            onContinue: (DateTime dob) {
              _pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
          VerificationScreen(pageController: _pageController),
          WelcomeScreen(),
        ],
      ),
    );
  }
}

// Screen 1: Initial Setup Screen
class InitialSetupScreen extends StatelessWidget {
  final VoidCallback onContinue;

  const InitialSetupScreen({Key? key, required this.onContinue})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Decorative corner design
              Image.asset(
                'assets/welcome_decoration_top_left.png', // You'll need to add this asset
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              // Main text
              Text(
                'Before proceeding to the app,',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Let\'s set up your account details to get started!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              // Let's go! button
              Center(
                child: ElevatedButton(
                  onPressed: onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4169E1),
                    minimumSize: Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'Let\'s go!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              // Bottom decoration
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  'assets/welcome_decoration_bottom_right.png', // You'll need to add this asset
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Screen 2: Username Collection Screen
class UsernameScreen extends StatefulWidget {
  final Function(String) onContinue;

  const UsernameScreen({Key? key, required this.onContinue}) : super(key: key);

  @override
  _UsernameScreenState createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header with email verification text
              Align(alignment: Alignment.topCenter),
              // Decorative corner design
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/welcome_decoration_top_left.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 20),
              // Main text
              Text(
                'What should we call you?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              // Username text field
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'Username',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
              Spacer(),
              // Confirm button
              ElevatedButton(
                onPressed: () {
                  if (_usernameController.text.isNotEmpty) {
                    widget.onContinue(_usernameController.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4169E1),
                  minimumSize: Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 40),
              // Bottom decoration
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  'assets/welcome_decoration_bottom_right.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Screen 3: Date of Birth Screen
class DateOfBirthScreen extends StatefulWidget {
  final Function(DateTime) onContinue;

  const DateOfBirthScreen({Key? key, required this.onContinue})
    : super(key: key);

  @override
  _DateOfBirthScreenState createState() => _DateOfBirthScreenState();
}

class _DateOfBirthScreenState extends State<DateOfBirthScreen> {
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  bool isDateValid() {
    try {
      final day = int.parse(_dayController.text);
      final month = int.parse(_monthController.text);
      final year = int.parse(_yearController.text);

      if (day < 1 || day > 31) return false;
      if (month < 1 || month > 12) return false;
      if (year < 1900 || year > DateTime.now().year) return false;

      return true;
    } catch (e) {
      return false;
    }
  }

  DateTime getDate() {
    return DateTime(
      int.parse(_yearController.text),
      int.parse(_monthController.text),
      int.parse(_dayController.text),
    );
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header with date text
              Align(alignment: Alignment.topCenter),
              // Decorative corner design
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/welcome_decoration_top_left.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 20),
              // Main text
              Text(
                'Enter your date of birth',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              // Date fields
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Day field
                  Column(
                    children: [
                      Text('Day', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      SizedBox(
                        width: 70,
                        child: TextField(
                          controller: _dayController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: 'DD',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  // Month field
                  Column(
                    children: [
                      Text('Month', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      SizedBox(
                        width: 70,
                        child: TextField(
                          controller: _monthController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: 'MM',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  // Year field
                  Column(
                    children: [
                      Text('Year', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      SizedBox(
                        width: 80,
                        child: TextField(
                          controller: _yearController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: 'YYYY',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              // Confirm button
              ElevatedButton(
                onPressed: () {
                  if (isDateValid()) {
                    widget.onContinue(getDate());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter a valid date')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4169E1),
                  minimumSize: Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 40),
              // Bottom decoration
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  'assets/welcome_decoration_bottom_right.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Screen 4: Verification Screen
class VerificationScreen extends StatefulWidget {
  final PageController pageController;
  const VerificationScreen({Key? key, required this.pageController})
    : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  List<TextEditingController> controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  bool isButtonEnabled = false;

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = controllers.every(
        (controller) => controller.text.isNotEmpty,
      );
    });
  }

  void _navigateToWelcomeScreen() {
    widget.pageController.animateToPage(
      4,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Verify Your Account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'We\'ve sent a 4-digit code to your email. Enter it below to verify your account.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: TextField(
                        controller: controllers[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          _updateButtonState();
                        },
                      ),
                    ),
                  );
                }),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: isButtonEnabled ? _navigateToWelcomeScreen : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isButtonEnabled
                          ? Color(0xFF4169E1)
                          : Colors.grey.shade400,
                  minimumSize: Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Verify',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 12),
              TextButton(
                onPressed: _navigateToWelcomeScreen,
                child: Text(
                  'Maybe Later',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// Screen 5: Welcome Screen with NaviGo Logo
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4169E1), // Royal blue background
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              // Welcome to text
              Text(
                'Welcome to',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              // NaviGo logo
              Image.asset(
                'assets/logo.png', // You'll need to add this asset
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              // NaviGo text
              Text(
                'NaviGo',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              // Decorative corner elements
              Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(
                      'assets/welcome_decoration_top_left.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/welcome_decoration_bottom_right.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
