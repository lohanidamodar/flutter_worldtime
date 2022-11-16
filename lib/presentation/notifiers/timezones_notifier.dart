import 'package:flutter_worldtime/data/service/worldtime_api.dart';
import 'package:state_notifier/state_notifier.dart';

class TimezoneNotifier extends StateNotifier<List<String>> {
  TimezoneNotifier() : super([]) {
    _init();
  }

  _init() async {
    state = await WorldTimeApi.getTimeZones() ?? [];
  }
}
