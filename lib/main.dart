import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: RecurrenceDateCollection()));
}

class RecurrenceDateCollection extends StatefulWidget {
  const RecurrenceDateCollection({super.key});

  @override
  RecurrenceDateCollectionState createState() =>
      RecurrenceDateCollectionState();
}

class RecurrenceDateCollectionState extends State<RecurrenceDateCollection> {
  final String? _recurrenceRule = 'FREQ=DAILY;INTERVAL=2;UNTIL=20240810';
  final DateTime? _startTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: TextButton(
                onPressed: _showDialog,
                child: Text("Get Recurrence date collections"),
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
    List<DateTime> dateCollection = SfCalendar.getRecurrenceDateTimeCollection(
        _recurrenceRule!, _startTime!);
    await showDialog(
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Container(
          width: 800,
          height: 800,
          child: ListView.builder(
              itemCount: dateCollection.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(DateFormat('dd, MMMM yyyy')
                    .format(dateCollection[index])
                    .toString());
              }),
        ),
        actions: <Widget>[
          TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
          TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      context: context,
    );
  }

  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];
    appointments.add(Appointment(
        startTime: _startTime!,
        endTime: _startTime!.add(const Duration(hours: 1)),
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