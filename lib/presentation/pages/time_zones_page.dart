import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_worldtime/data/model/time_info.dart';
import 'package:flutter_worldtime/data/service/worldtime_api.dart';
import 'package:flutter_worldtime/presentation/notifiers/clocks_notifier.dart';
import 'package:flutter_worldtime/presentation/notifiers/timezones_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final timeZonesProvider = StateNotifierProvider((ref) => TimezoneNotifier());

class TimezonesPage extends StatefulHookConsumerWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TimezonesPageState();
  }
  // @override
  // _TimezonesPageState createState() => _TimezonesPageState();
}

class _TimezonesPageState extends ConsumerState<TimezonesPage> {
  String _timezone = '';
  bool _loading = false;
  GlobalKey<ScaffoldState> _scaffKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffKey,
      appBar: AppBar(
        title: Text('Select timezone'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Consumer(builder: (context, ref, child) {
          final timeZones = ref.watch(timeZonesProvider.notifier).debugState;
          if (timeZones != null) {
            return Column(
              children: [
                DropdownSearch<String>(
                  onChanged: (tz) {
                    setState(() {
                      _timezone = tz ?? '';
                    });
                  },
                  items: timeZones,
                  selectedItem: _timezone,
                ),
                ElevatedButton(
                  child: _loading ? CircularProgressIndicator() : Text("Add"),
                  onPressed: _loading
                      ? null
                      : () async {
                          if (_timezone == null) return;
                          setState(() {
                            _loading = true;
                          });
                          bool exists = false;
                          ref
                              .read(clocksProvider.notifier)
                              .debugState
                              .forEach((element) {
                            if (element.timezone == _timezone) {
                              exists = true;
                            }
                          });
                          if (!exists) {
                            TimeInfo info =
                                await WorldTimeApi.getTimezoneTime(_timezone);
                            ref.read(clocksProvider.notifier).add(info);
                            setState(() {
                              _loading = false;
                            });
                            Navigator.pop(context);
                          } else {
                            setState(() {
                              _loading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "The timezone clock is already available in the list."),
                            ));
                          }
                        },
                )
              ],
            );
          }
          return CircularProgressIndicator();
        }),
      ),
    );
  }
}
