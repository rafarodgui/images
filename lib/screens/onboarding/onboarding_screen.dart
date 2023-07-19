import 'dart:async';
import 'package:flutter/material.dart';

import '../welcome/welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  String text0 = '';
  String text1 = 'Olá, Adriana';
  String text2 = 'Boas-vindas ao plano TIM Pré top!';
  String text3 = 'Agora você terá um mundo de possibilidades aqui no Meu TIM';

  List<String> texts = [];
  int currentIndex = 0;
  late Timer timer;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    setState(() {
      texts.add(text0);
      texts.add(text1);
      texts.add(text2);
      texts.add(text3);
    });

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _fadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController);

    startTimer();
  }

  @override
  void dispose() {
    stopTimer();
    _animationController.dispose();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      setState(() {
        currentIndex = (currentIndex + 1);
        if (currentIndex == texts.length - 1) {
          stopTimer();
        }
        _animationController.reset();
        _animationController.forward();
      });
    });
  }

  void stopTimer() {
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 40.0,
          child: Image.asset('assets/images/logo_app.png'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
            ),
            if (currentIndex == 0)
              const Center(
                child: CircularProgressIndicator(),
              ),
            if (currentIndex == texts.length - 2)
              Text(
                texts[currentIndex - 1],
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  texts[currentIndex],
                  style: TextStyle(
                    fontSize: currentIndex == texts.length - 2 ? 18 : 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (currentIndex == texts.length - 1)
              FutureBuilder(
                future: Future.delayed(
                  const Duration(seconds: 3),
                ),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  } else {
                    return Column(
                      children: [
                        const SizedBox(height: 100),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => WelcomeScreen(),
                            ),
                          ),
                          child: Container(
                            width: 300,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: const Color(0xff0026D9),
                            ),
                            child: const Center(
                              child: Text(
                                'Conhecer o app',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: GestureDetector(
                            child: const Text(
                              'Pular',
                              style: TextStyle(
                                color: Color(0xff0026D9),
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
