import 'package:flutter/material.dart';
import 'package:hams_flutter/inspections/inspectionsList.dart';
import './header.dart';

class InspectionsState extends State<Inspections> {
  int selectedYear = DateTime.now().year;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Header(onSelectedYearChanged: (year) {
            setState(() {
              selectedYear = year;
            });
          }),
          Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(flex: 4, child: Text('Property Name')),
                    Expanded(flex: 1, child: Text('Scheduled')),
                    Expanded(flex: 1, child: Text('Completed')),
                    Expanded(flex: 1, child: Text('Status')),
                    Expanded(flex: 1, child: Text('Followups')),
                    Expanded(flex: 1, child: Text('Sync'))
                  ])),
          InspectionsList(selectedYear)
        ],
      ),
    );
  }
}

class Inspections extends StatefulWidget {
  @override
  InspectionsState createState() => new InspectionsState();
}
