import 'package:flutter/material.dart';
import 'package:timely/components/home_calendar.dart';
import 'package:timely/components/my_calendar.dart';
import 'package:timely/pages/event_filter_screen.dart';
import 'package:timely/pages/print_events_screen.dart';
import 'package:timely/state/calendar_controller.dart';
import '../main.dart';

// New color scheme
const Color primaryColor = Color(0xFF1A6B3C);
const Color accentColor = Color(0xFF4CAF50);
const Color backgroundColor = Colors.white;
const Color cardColor = Colors.white;
const Color subtleColor = Color(0xFFF5F5F5);

const Duration _animationDuration = Duration(milliseconds: 300);
const Curve _animationCurve = Curves.easeInOut;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: _animationCurve),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final calendarController = CalendarController();
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Row(
          children: [
            AnimatedContainer(
              duration: _animationDuration,
              curve: _animationCurve,
              width: screenWidth * 0.25,
              padding: const EdgeInsets.all(8.0),
              color: backgroundColor,
              child: MyCalendar(controller: calendarController),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AnimatedContainer(
                duration: _animationDuration,
                curve: _animationCurve,
                padding: const EdgeInsets.all(12.0),
                color: backgroundColor,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: HomeCalendar(controller: calendarController),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
