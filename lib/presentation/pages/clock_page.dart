import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_worldtime/presentation/widgets/clock_container.dart';
import 'package:flutter_worldtime/presentation/widgets/clock_hands.dart';
import 'package:intl/intl.dart';

final timeProvider = StateProvider<DateTime>((ref) => DateTime.now());

class ClockPage extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  Timer timer;
  Timer timer2;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      context.read(timeProvider).state =
          context.read(timeProvider).state.add(Duration(seconds: 1));
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            Container(
              child: Consumer((context, watch) {
                final time = watch(timeProvider).state;
                return Column(
                  children: [
                    ClockContainer(
                      child: CustomPaint(
                        painter: ClockHands(time),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      DateFormat.jm().format(time),
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(height: 10.0),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
