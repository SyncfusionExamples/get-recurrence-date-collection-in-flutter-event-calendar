import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false, home: new RecurrenceDateCollection()));
}

class RecurrenceDateCollection extends StatefulWidget {
  @override
  RecurrenceDateCollectionState createState() =>
      new RecurrenceDateCollectionState();
}

class RecurrenceDateCollectionState extends State<RecurrenceDateCollection> {
  String? _recurrenceRule = 'FREQ=DAILY;INTERVAL=2;UNTIL=20210810';
  DateTime? _startTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: new RaisedButton(
                onPressed: _showDialog,
                child: new Text("Get Recurrence date collections"),
              ),
            ),
            Expanded(
                child: SfCalendar(
              view: CalendarView.month,
              dataSource: _getCalendarDataSource(),
            ))
          ],
        ),
      ),
    );
  }

  _showDialog() async {
    List<DateTime> _dateCollection =
        SfCalendar.getRecurrenceDateTimeCollection(_recurrenceRule!, _startTime!);
    await showDialog(
      builder: (context) => new
      AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: ListView.builder(
            itemCount: _dateCollection.length,
            itemBuilder: (BuildContext context, int index) {
              return new Text(DateFormat('dd, MMMM yyyy')
                  .format(_dateCollection[index])
                  .toString());
            }),
        actions: <Widget>[
          new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ), context: context,
    );
  }

  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];
    appointments.add(Appointment(
        startTime: _startTime!,
        endTime: _startTime!.add(Duration(hours: 1)),
        subject: 'Meeting',
        color: Colors.blue,
        recurrenceRule: _recurrenceRule));

    return _AppointmentDataSource(appointments);
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
