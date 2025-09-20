import 'package:amlan_portfolio/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/custom_app_bar.dart';

class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final List<GlobalKey> _sectionKeys = [
    GlobalKey(), // Hero
    GlobalKey(), // About
    GlobalKey(), // Skills
    GlobalKey(), // Projects
    GlobalKey(), // Contact
  ];

  int _currentSectionIndex = 0;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    for (int i = 0; i < _sectionKeys.length; i++) {
      final keyContext = _sectionKeys[i].currentContext;
      if (keyContext != null) {
        final box = keyContext.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero).dy;

        if (position < MediaQuery.of(context).size.height / 2 &&
            position > -box.size.height / 2) {
          if (_currentSectionIndex != i) {
            setState(() {
              _currentSectionIndex = i;
            });
          }
          break;
        }
      }
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(int index) {
    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 1200),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            CustomAppBar(
              onSectionTap: _scrollToSection,
              themeProvider: Provider.of<ThemeProvider>(context),
              currentIndex: _currentSectionIndex,
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    HeroSection(key: _sectionKeys[0]),
                    AboutSection(key: _sectionKeys[1]),
                    SkillsSection(key: _sectionKeys[2]),
                    ProjectsSection(key: _sectionKeys[3]),
                    ContactSection(key: _sectionKeys[4]),
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
