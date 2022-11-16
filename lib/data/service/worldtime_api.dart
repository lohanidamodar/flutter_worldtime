import 'dart:convert';

import 'package:flutter_worldtime/data/model/time_info.dart';
import 'package:http/http.dart' as http;

class WorldTimeApi {
  static final String baseUrl = "worldtimeapi.org";

  static Future<TimeInfo> getCurrentTime({String? timeZone}) async {
    http.Response res = await http.get(Uri.http("$baseUrl", "ip"));
    if (res != null && res.statusCode == 200) {
      return TimeInfo.fromJson(jsonDecode(res.body));
    } else {
      return TimeInfo();
    }
  }

  static Future<TimeInfo> getTimezoneTime(String timeZone) async {
    try {
      http.Response res =
          await http.get(Uri.http("$baseUrl", "api/timezone/$timeZone"));
      if (res != null) {
        return TimeInfo.fromJson(jsonDecode(res.body));
      } else {
        return TimeInfo();
      }
    } catch (e) {
      return TimeInfo();
    }
  }

  static Future<List<String>> getTimeZones() async {
    http.Response res = await http.get(Uri.http("$baseUrl", "api/timezone"));
    if (res != null)
      return List<String>.from(jsonDecode(res.body));
    else
      return [];
  }
}
