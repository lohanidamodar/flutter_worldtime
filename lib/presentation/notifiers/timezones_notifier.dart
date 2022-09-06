
import 'package:flutter_worldtime/data/service/worldtime_api.dart';
import 'package:state_notifier/state_notifier.dart';

class TimezoneNotifier extends StateNotifier<List<String>> {
  TimezoneNotifier() : super([]) {
    _init();
  }

  _init() {
    print('TimezoneNotifier._init.1: $state');
    Future.delayed(Duration(milliseconds: 1000)).then((_) async {
      state = await WorldTimeApi.getTimeZones() ?? [];
      print('TimezoneNotifier._init.2: $state');
    });
  }


}