import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedTextWidget extends StatefulWidget {
  @override
  _AnimatedTextWidgetState createState() => _AnimatedTextWidgetState();
}

class _AnimatedTextWidgetState extends State<AnimatedTextWidget>
    with TickerProviderStateMixin {
  late AnimationController _typewriterController;
  late Animation<int> _typewriterAnimation;
  
  final List<String> titles = [
    'Flutter Developer',
    'AI/ML Enthusiast',
    'Problem Solver',
    'Innovation Seeker',
  ];
  
  int currentTitleIndex = 0;
  String displayText = '';

  @override
  void initState() {
    super.initState();
    _typewriterController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _startTypewriterEffect();
  }

  void _startTypewriterEffect() {
    _typewriterAnimation = IntTween(
      begin: 0,
      end: titles[currentTitleIndex].length,
    ).animate(CurvedAnimation(
      parent: _typewriterController,
      curve: Curves.easeInOut,
    ));

    _typewriterAnimation.addListener(() {
      setState(() {
        displayText = titles[currentTitleIndex].substring(0, _typewriterAnimation.value);
      });
    });

    _typewriterController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 1000), () {
          _typewriterController.reverse().then((_) {
            setState(() {
              currentTitleIndex = (currentTitleIndex + 1) % titles.length;
            });
            Future.delayed(Duration(milliseconds: 500), () {
              _startTypewriterEffect();
            });
          });
        });
      } else if (status == AnimationStatus.dismissed) {
        _typewriterController.forward();
      }
    });

    _typewriterController.forward();
  }

  @override
  void dispose() {
    _typewriterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            displayText,
            style: GoogleFonts.firaCode(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Container(
            width: 2,
            height: 24,
            color: Theme.of(context).primaryColor,
            margin: EdgeInsets.only(left: 2),
            child: AnimatedBuilder(
              animation: _typewriterController,
              builder: (context, child) {
                return Opacity(
                  opacity: _typewriterController.value > 0.5 ? 1.0 : 0.0,
                  child: Container(
                    color: Theme.of(context).primaryColor,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}