import 'package:flutter/material.dart';
import 'package:glamourme/view/style.dart';
import 'package:table_calendar/table_calendar.dart';

import '../widgets/specialist_overview.dart';

class SetShedulePage extends StatefulWidget {
  const SetShedulePage({Key? key}) : super(key: key);

  @override
  State<SetShedulePage> createState() => _SetShedulePageState();
}

class _SetShedulePageState extends State<SetShedulePage> {
  List<String> availablityList = [
    '10:00 AM',
    '12:00 AM',
    '03:00 PM',
    '03:00 PM'
  ];
  List<Widget> widgetList() {
    return [
      Text(availablityList[0]),
      Text(availablityList[1]),
      Text(availablityList[2]),
      Text(availablityList[3])
    ];
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Date & Time',
          style: titleTextStyle(),
        ),
        SizedBox(
          height: padding,
        ),
        // CalendarDatePicker(initialDate: initialDate, firstDate: firstDate, lastDate: lastDate, onDateChanged: onDateChanged)
        Container(
          height: height * .2,
          width: width,
          decoration: BoxDecoration(
              color: whiteColor, borderRadius: BorderRadius.circular(4)),
          child: TableCalendar(
              calendarStyle: CalendarStyle(rangeHighlightColor: primaryColor),
              calendarFormat: CalendarFormat.week,
              focusedDay: DateTime.now(),
              firstDay: DateTime.utc(2010, 10, 20),
              lastDay: DateTime.utc(2040, 10, 20)),
        ),
        SizedBox(
          height: padding,
        ),
        Container(
          height: height * .1,
          width: width,
          decoration: BoxDecoration(
              color: whiteColor, borderRadius: BorderRadius.circular(4)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widgetList()),
          // child: ListView.builder(

          //   scrollDirection: Axis.horizontal,
          //   itemCount: availablityList.length,
          //   itemBuilder: (context,index){
          //   return Center(child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 10),
          //     child: Text(availablityList[index]),
          //   ));
          // }),
        ),
        SizedBox(
                  height: padding,
                ),
                Text('Hair Specialist',style: titleTextStyle(),),
                 SizedBox(
                  height: padding,
                ),
               GridView.builder(  
                 shrinkWrap: true,
                 physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,  
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(  
                  crossAxisCount: 2,  
                  crossAxisSpacing: 15,  
                  mainAxisSpacing: 10  
              ),  
              itemBuilder: (BuildContext context, int index){  
                return SpecialistOverview(height: height, width: width);  
              },  
            ), 
      ],
    );
  }
}
