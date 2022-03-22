import 'package:flutter/material.dart';

class SetShedulePage extends StatefulWidget {
  const SetShedulePage({ Key? key }) : super(key: key);

  @override
  State<SetShedulePage> createState() => _SetShedulePageState();
}

class _SetShedulePageState extends State<SetShedulePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Choose Date & Time'),
        // CalendarDatePicker(initialDate: initialDate, firstDate: firstDate, lastDate: lastDate, onDateChanged: onDateChanged)
      ],
      
    );
  }
}