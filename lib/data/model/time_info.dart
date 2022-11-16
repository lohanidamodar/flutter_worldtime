import 'package:equatable/equatable.dart';

class TimeInfo extends Equatable {
  String? abbreviation;
  String? clientIp;
  String? datetime;
  int? dayOfWeek;
  int? dayOfYear;
  bool? dst;
  String? dstFrom;
  late int dstOffset;
  String? dstUntil;
  late int rawOffset;
  late String timezone;
  int? unixtime;
  String? utcDatetime;
  String? utcOffset;
  int? weekNumber;

  TimeInfo(
      {this.abbreviation,
      this.clientIp,
      this.datetime,
      this.dayOfWeek,
      this.dayOfYear,
      this.dst,
      this.dstFrom,
      this.dstOffset = 0,
      this.dstUntil,
      this.rawOffset = 0,
      this.timezone = '',
      this.unixtime,
      this.utcDatetime,
      this.utcOffset,
      this.weekNumber});

  TimeInfo.fromJson(Map<String, dynamic> json) {
    abbreviation = json['abbreviation'];
    clientIp = json['client_ip'];
    datetime = json['datetime'];
    dayOfWeek = json['day_of_week'];
    dayOfYear = json['day_of_year'];
    dst = json['dst'];
    dstFrom = json['dst_from'];
    dstOffset = json['dst_offset'] ?? 0;
    dstUntil = json['dst_until'];
    rawOffset = json['raw_offset'] ?? 0;
    timezone = json['timezone'] ?? '';
    unixtime = json['unixtime'];
    utcDatetime = json['utc_datetime'];
    utcOffset = json['utc_offset'];
    weekNumber = json['week_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['abbreviation'] = this.abbreviation;
    data['client_ip'] = this.clientIp;
    data['datetime'] = this.datetime;
    data['day_of_week'] = this.dayOfWeek;
    data['day_of_year'] = this.dayOfYear;
    data['dst'] = this.dst;
    data['dst_from'] = this.dstFrom;
    data['dst_offset'] = this.dstOffset ?? 0;
    data['dst_until'] = this.dstUntil;
    data['raw_offset'] = this.rawOffset ?? 0;
    data['timezone'] = this.timezone ?? '';
    data['unixtime'] = this.unixtime;
    data['utc_datetime'] = this.utcDatetime;
    data['utc_offset'] = this.utcOffset;
    data['week_number'] = this.weekNumber;
    return data;
  }

  @override
  List<Object?> get props => [abbreviation, timezone];
}
