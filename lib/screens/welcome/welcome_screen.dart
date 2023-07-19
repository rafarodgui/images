import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: const ClampingScrollPhysics(),
            controller: _pageController,
            onPageChanged: (int index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            children: [
              _buildPage(
                const Color(0xff0026D9),
                'assets/images/image_1.png',
                'Meu consumo',
                'Acesse o extrato do seu TIM e acompanhe recargas, bônus de dados e os gastos nos últimos dias.',
              ),
              _buildPage(
                const Color(0xff0026D9),
                'assets/images/image_2.png',
                'TIM Store',
                'Personalize seu plano com serviços adicionais de video, música, games e mais.',
              ),
              _buildPage(
                Colors.white,
                'assets/images/image_3.png',
                'Aproveite o Meu Tim',
                'Caso precise de mais detalhes, no Meu Tim tem uma área de ajuda pronta para você',
              ),
            ],
          ),
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 100,
              color: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/logo_app.png',
                    width: 50,
                  ),
                  if (_currentPageIndex != 2)
                    GestureDetector(
                      onTap: () {
                        _pageController.animateToPage(
                          2,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Text(
                        'Pular',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPageIndex == index
                          ? _currentPageIndex != 2
                              ? Colors.white
                              : Colors.black
                          : Colors.grey,
                    ),
                  );
                }),
              ),
            ),
          ),
          if (_currentPageIndex == 2)
            Positioned(
              bottom: 100,
              right: 30,
              left: 30,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: const Color(0xff0026D9),
                ),
                child: const Center(
                  child: Text(
                    'Começar a usar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
          if (_currentPageIndex != 2)
            Positioned(
              bottom: 16,
              right: 16,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                  color: Colors.white,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    if (_currentPageIndex < 2) {
                      _pageController.animateToPage(
                        _currentPageIndex + 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPage(
    Color backgroundColor,
    String imagePath,
    String title,
    String description,
  ) {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 250.0, child: Image.asset(imagePath)),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _currentPageIndex != 2 ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: _currentPageIndex != 2 ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
