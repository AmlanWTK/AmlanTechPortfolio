import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class OneTimeScrollAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double verticalOffset;

  const OneTimeScrollAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.verticalOffset = 30.0,
  }) : super(key: key);

  @override
  _OneTimeScrollAnimationState createState() => _OneTimeScrollAnimationState();
}

class _OneTimeScrollAnimationState extends State<OneTimeScrollAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _hasAnimated = false; // ensures animation runs only once

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, widget.verticalOffset / 100),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: UniqueKey(),
      onVisibilityChanged: (info) {
        if (!_hasAnimated && info.visibleFraction > 0.1) {
          _controller.forward();
          _hasAnimated = true;
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.translate(
            offset: _slideAnimation.value * 100, // vertical offset in px
            child: child,
          ),
        ),
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
