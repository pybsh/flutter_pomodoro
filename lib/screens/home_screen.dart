import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const time = 1500;
  int totalSecond = time;
  int totalPomodoro = 0;
  bool isRunning = false;
  late Timer timer;

  void onTick(Timer timer) {
    if(totalSecond == 0) {
      setState(() {
        totalPomodoro += 1;
        isRunning = false;
        totalSecond = time;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSecond -= 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 7);
  }

  void onResetPressed() {
    setState(() {
      isRunning = false;
      totalSecond = time;
    });
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSecond),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              child: Column(
                children: [
                  Center(
                    child: IconButton(
                      iconSize: 120,
                      color: Theme.of(context).cardColor,
                      onPressed: isRunning? onPausePressed : onStartPressed,
                      icon: Icon(isRunning ? Icons.pause_circle_outline : Icons.play_circle_outline
                      ),
                    ),
                  ),
                  Center(
                    child: IconButton(
                      iconSize: 60,
                      color: Theme.of(context).cardColor,
                      onPressed: onResetPressed,
                      icon: const Icon(Icons.restart_alt),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoro',
                          style: TextStyle(
                            fontSize: 20,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '$totalPomodoro',
                          style: TextStyle(
                            fontSize: 60,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
