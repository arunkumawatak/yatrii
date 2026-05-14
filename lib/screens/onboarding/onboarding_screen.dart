import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yatrii/screens/auth/login/login_screen.dart';
import 'package:yatrii/screens/auth/welcome/welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/onboard2.jpeg",
      "title": "Book Trips in Seconds",
      "desc":
          "Search routes, compare travel options, and reserve your seat instantly with a smooth booking experience."
    },
    {
      "image": "assets/images/onboard4.jpeg",
      "title": "Secure Online Payments",
      "desc":
          "Pay confidently using trusted payment methods with instant booking confirmation."
    },
    {
      "image": "assets/images/onboard1.jpeg",
      "title": "Travel Without Waiting",
      "desc":
          "Skip long queues and manage your journeys directly from your phone anytime, anywhere."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: _controller,
                itemCount: onboardingData.length,
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
                itemBuilder: (context, index) => OnboardContent(
                  image: onboardingData[index]["image"]!,
                  title: onboardingData[index]["title"]!,
                  desc: onboardingData[index]["desc"]!,
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// Dots Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => buildDot(index: index),
              ),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.to(() => const LoginScreen());
                    },
                    child: Text(
                      "Later",
                      style: TextStyle(
                        fontFamily: "CrimsonText",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.indigo.shade800,
                      ),
                    ),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow.shade800,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      if (_currentPage == onboardingData.length - 1) {
                        Get.to(() => const WelcomeScreen());
                      } else {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(
                      _currentPage == onboardingData.length - 1
                          ? "Start Journey"
                          : "Continue",
                      style: const TextStyle(
                        fontFamily: "CrimsonText",
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 6),
      height: 7,
      width: _currentPage == index ? 24 : 7,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? Colors.yellow.shade800
            : Colors.indigo.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class OnboardContent extends StatelessWidget {
  final String image;
  final String title;
  final String desc;

  const OnboardContent({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 35),

        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        const SizedBox(height: 35),

        Text(
          title,
          style: TextStyle(
            fontFamily: "CrimsonText",
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.yellow.shade800,
          ),
        ),

        const SizedBox(height: 18),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "CrimsonText",
              fontSize: 15,
              height: 1.5,
              fontWeight: FontWeight.w400,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}