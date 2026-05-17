import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {

  int seconds = 0;

  Timer? timer;

  bool isRunning = false;

  void startTimer() {

    timer = Timer.periodic(

      const Duration(seconds: 1),

      (timer) {

        setState(() {

          seconds++;

        });

      },

    );

    setState(() {

      isRunning = true;

    });

  }

  void stopTimer() {

    timer?.cancel();

    setState(() {

      isRunning = false;

    });

  }

  void resetTimer() {

    timer?.cancel();

    setState(() {

      seconds = 0;

      isRunning = false;

    });

  }

  String formatTime(int totalSeconds) {

    int minutes = totalSeconds ~/ 60;

    int remainingSeconds = totalSeconds % 60;

    return "$minutes : ${remainingSeconds.toString().padLeft(2,'0')}";

  }
  

  @override
  void dispose() {

    timer?.cancel();

    super.dispose();


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Stopwatch"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Icon(
              Icons.timer,
              size: 100,
              color: Colors.deepPurple,
            ),

            const SizedBox(height: 30),

            Text(

              formatTime(seconds),

              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),

            ),

            const SizedBox(height: 40),

            Row(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                ElevatedButton(

                  onPressed:
                  isRunning
                      ? null
                      : startTimer,

                  child: const Text("Start"),

                ),

                const SizedBox(width: 20),

                ElevatedButton(

                  onPressed:
                  isRunning
                      ? stopTimer
                      : null,

                  child: const Text("Stop"),

                ),

                const SizedBox(width: 20),

                ElevatedButton(

                  onPressed: resetTimer,

                  child: const Text("Reset"),

                ),

              ],
            )

          ],
        ),
      ),
    );
  }
}