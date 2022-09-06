import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_worldtime/data/model/time_info.dart';
import 'package:flutter_worldtime/data/service/worldtime_api.dart';
import 'package:flutter_worldtime/presentation/notifiers/clocks_notifier.dart';
import 'package:flutter_worldtime/presentation/widgets/clock_container.dart';
import 'package:flutter_worldtime/presentation/widgets/clock_hands.dart';
import 'package:flutter_worldtime/res/routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

final timeProvider = StateProvider<DateTime>((ref) => DateTime.now());

final timezone = FutureProvider<TimeInfo>((ref) async {
  return WorldTimeApi.getCurrentTime();
});

class ClockPage extends StatefulHookConsumerWidget {

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
      return _ClockPageState();
  }
}

class _ClockPageState extends ConsumerState<ClockPage> {
  Timer? timer;
  Timer? timer2;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      ref.read(timeProvider.notifier).state =
          ref.read(timeProvider.notifier).state.add(Duration(seconds: 1));
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
            Row(
              children: [
                Spacer(),
                MaterialButton(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.pink,
                  shape: CircleBorder(),
                  child: Icon(Icons.add),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.timezonesPage);
                  },
                ),
              ],
            ),
            Container(
              child: Consumer( builder: (context, ref, child) {
                final p = ref.watch(timeProvider);
                final time = ref.watch(timeProvider.notifier).debugState;
                debugPrint('_ClockPageState.build: ${time}');
                return Column(
                  children: [
                    ClockContainer(
                      child: CustomPaint(
                        painter: ClockHands(time),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Consumer(builder: (context, ref, child) {
                      final timeinfo = ref.watch(timezone);
                      return timeinfo.when(
                          data: (timeinfo) => Text(
                                timeinfo?.timezone ?? '',
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24.0,
                                ),
                              ),
                          loading: () => const CircularProgressIndicator(),
                          error: (err, stack) => Container());
                    }),
                    Text(
                      DateFormat.jm().format(time),
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(height: 10.0),
                  ],
                );
              }),
            ),
            SizedBox(
              height: 160,
              child: Consumer(
                builder: (context, ref, child) {
                  final p = ref.watch(clocksProvider);
                  final clocks = ref.watch<List<TimeInfo>>(clocksProvider);
                  var tp = ref.watch<DateTime>(timeProvider);
                  if (clocks != null && clocks.isNotEmpty)
                    return ListView.builder(
                      itemCount: clocks.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        TimeInfo clock = clocks[index];
                        var time = tp.toUtc();
                        int offset = clock.rawOffset + clock.dstOffset;
                        if (clock.rawOffset > 0) {
                          time = time.add(Duration(seconds: offset));
                        } else if (clock.rawOffset < 0) {
                          time =
                              time.subtract(Duration(seconds: (offset * -1)));
                        }
                        return Card(
                          child: Stack(
                            children: [
                              Container(
                                width: 300,
                                padding: const EdgeInsets.all(32.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      clock.timezone,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      "${clock.utcOffset}",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 15.0),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                              DateFormat.yMMMd().format(time)),
                                        ),
                                        Text(
                                          DateFormat.jm().format(time),
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 24.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    ref.read(clocksProvider.notifier).remove(clock);
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
