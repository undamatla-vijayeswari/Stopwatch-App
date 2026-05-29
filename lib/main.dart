import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  const StopwatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stopwatch App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const StopwatchHomePage(),
    );
  }
}

class StopwatchHomePage extends StatefulWidget {
  const StopwatchHomePage({super.key});

  @override
  State<StopwatchHomePage> createState() => _StopwatchHomePageState();
}

class _StopwatchHomePageState extends State<StopwatchHomePage> {
  Timer? timer;

  int milliseconds = 0;
  bool isRunning = false;

  void startTimer() {
    if (isRunning) return;

    isRunning = true;

    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        milliseconds += 10;
      });
    });
  }

  void pauseTimer() {
    timer?.cancel();

    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    timer?.cancel();

    setState(() {
      milliseconds = 0;
      isRunning = false;
    });
  }

  String formatTime(int milliseconds) {
    int minutes = (milliseconds ~/ 60000);
    int seconds = (milliseconds ~/ 1000) % 60;
    int centiseconds = (milliseconds ~/ 10) % 100;

    String minuteString = minutes.toString().padLeft(2, '0');
    String secondString = seconds.toString().padLeft(2, '0');
    String milliString = centiseconds.toString().padLeft(2, '0');

    return '$minuteString : $secondString : $milliString';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,

      appBar: AppBar(title: const Text("Stopwatch"), centerTitle: true),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.timer, size: 100, color: Colors.white),

              const SizedBox(height: 30),

              Text(
                formatTime(milliseconds),
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: startTimer,

                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 15,
                      ),
                    ),

                    child: const Text("Start", style: TextStyle(fontSize: 18)),
                  ),

                  const SizedBox(width: 15),

                  ElevatedButton(
                    onPressed: pauseTimer,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 15,
                      ),
                    ),

                    child: const Text("Pause", style: TextStyle(fontSize: 18)),
                  ),

                  const SizedBox(width: 15),

                  ElevatedButton(
                    onPressed: resetTimer,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 15,
                      ),
                    ),

                    child: const Text("Reset", style: TextStyle(fontSize: 18)),
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
