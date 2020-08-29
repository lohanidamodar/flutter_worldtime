import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_worldtime/presentation/notifiers/timezones_notifier.dart';

final timeZonesProvider = StateNotifierProvider((ref) => TimezoneNotifier());

class TimezonesPage extends StatefulWidget {
  @override
  _TimezonesPageState createState() => _TimezonesPageState();
}

class _TimezonesPageState extends State<TimezonesPage> {
  String _timezone;
  bool _loading;
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
        child: Consumer((context, watch) {
          final timeZones = watch(timeZonesProvider.state);
          if (timeZones != null) {
            return Column(
              children: [
                DropdownSearch<String>(
                  showSearchBox: true,
                  onChanged: (tz) {
                    setState(() {
                      _timezone = tz;
                    });
                  },
                  items: timeZones,
                  mode: Mode.MENU,
                  selectedItem: _timezone,
                ),
                RaisedButton(
                  child: _loading ? CircularProgressIndicator() : Text("Add"),
                  onPressed: (){},
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
