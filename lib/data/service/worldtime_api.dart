import 'dart:convert';

import 'package:flutter_worldtime/data/model/time_info.dart';
import 'package:http/http.dart' as http;

class WorldTimeApi {
  static final String baseUrl = "http://worldtimeapi.org/api";

  static Future<TimeInfo> getCurrentTime({String timeZone}) async {
    http.Response res = await http.get("$baseUrl/ip");
    if (res != null && res.statusCode == 200) {
      return TimeInfo.fromJson(jsonDecode(res.body));
    } else {
      return null;
    }
  }

  static Future<TimeInfo> getTimezoneTime(String timeZone) async {
    http.Response res = await http.get("$baseUrl/timezone/$timeZone");
    if (res != null) {
      return TimeInfo.fromJson(jsonDecode(res.body));
    } else {
      return null;
    }
  }

  static Future<List<String>> getTimeZones() async {
    http.Response res = await http.get("$baseUrl/timezone");
    if (res != null)
      return jsonDecode(res.body);
    else
      return null;
  }
}
