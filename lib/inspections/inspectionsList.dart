import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './data/InspectionClass.dart';
import '../helpers/JsonHelper.dart';
import '../helpers/EnumHelper.dart';
import '../inspections/data/api.dart';

class InspectionsListState extends State<InspectionsList> {
  Map<String, bool> _tapInProgress = Map<String, bool>();
  Future<http.Response> inspectionStatusResponse;
  List<InspectionClass> _inspections = List<InspectionClass>();

  @override
  void initState() {
    super.initState();
    inspectionStatusResponse = Apis.getSiteInspectionUpdateStatus();
  }

  void _onTapInspection(inspection) {
    print(inspection.name);
  }

  void _onTapRefresh(inspection) {
    print('refresh ' + inspection.name);
  }

  void _onTapDownRefresh(TapDownDetails details, InspectionClass inspection) {
    setState(() {
      _tapInProgress[inspection.name] = true;
    });
  }

  void _onTapUpRefresh(TapUpDetails details, inspection) {
    setState(() {
      _tapInProgress[inspection.name] = false;
    });
  }

  void _onTapCancelRefresh(inspection) {
    setState(() {
      _tapInProgress[inspection.name] = false;
    });
  }

  Widget _buildInspection(inspection) {
    return Container(
      height: 50,
      // padding: EdgeInsets.only(left: 10, right: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.grey[300],
        elevation: 1,
        child: InkWell(
            onTap: () {
              _onTapInspection(inspection);
            },
            splashColor: Colors.blueGrey,
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(flex: 4, child: Text(inspection.name)),
                  Expanded(
                      flex: 1,
                      child: Text(inspection.getScheduledForDisplay())),
                  Expanded(
                      flex: 1,
                      child: Text(inspection.getCompletedForDisplay())),
                  Expanded(
                    flex: 1,
                    child: Text(EnumHelper.getInspectionStatusDisplayName(
                        inspection.status)),
                  ),
                  Expanded(
                      flex: 1,
                      child:
                          inspection.hasFollowups ? Text('Yes') : Text('No')),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(inspection.filesToSync.toString()),
                        inspection.filesToSync != 0
                            ? Material(
                                elevation: 2,
                                color: Colors.blueGrey[100],
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(100),
                                    splashColor: Colors.blueGrey[400],
                                    onTap: () {
                                      _onTapRefresh(inspection);
                                    },
                                    child: Icon(Icons.refresh),
                                  ),
                                ))
                            : Spacer()
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  List<Widget> _buildInspections() {
    List<Widget> list = new List<Widget>();
    /*var inspectionsList = JsonHelper.parseJSONArray(
        '[{"name":"1400 Bellview Apartments","scheduled":"2018-10-20T14:18:58.36Z","completed":null,"status":0,"hasFollowups":false,"year":2018,"filesToSync":1},{"name":"123 Cherry Lane","scheduled":null,"completed":null,"status":1,"hasFollowups":false,"year":2018,"filesToSync":1},{"name":"Hudson Property","scheduled":"2018-10-20T14:18:58.36Z","completed":null,"status":4,"hasFollowups":false,"year":2018,"filesToSync":0},{"name":"Westview Condominiums","scheduled":null,"completed":"2018-10-30T14:18:58.36Z","status":3,"hasFollowups":false,"year":2018,"filesToSync":0},{"name":"An Apartment Complex","scheduled":null,"completed":null,"status":0,"hasFollowups":false,"year":2018,"filesToSync":1},{"name":"Beechwood Condos","scheduled":null,"completed":null,"status":2,"hasFollowups":false,"year":2018,"filesToSync":1},{"name":"Kings Crossing","scheduled":null,"completed":"2018-10-30T14:18:58.36Z","status":2,"hasFollowups":false,"year":2018,"filesToSync":1},{"name":"Greenville Apartments","scheduled":null,"completed":null,"status":3,"hasFollowups":false,"year":2018,"filesToSync":1},{"name":"Knights Shadow Properties","scheduled":null,"completed":null,"status":3,"hasFollowups":false,"year":2018,"filesToSync":0},{"name":"Perry on Main Apartments","scheduled":null,"completed":null,"status":1,"hasFollowups":false,"year":2018,"filesToSync":1},{"name":"Eastville","scheduled":null,"completed":null,"status":0,"hasFollowups":false,"year":2017,"filesToSync":1},{"name":"Bay North","scheduled":null,"completed":null,"status":4,"hasFollowups":false,"year":2017,"filesToSync":0},{"name":"Buzzards Bay Skyrise","scheduled":null,"completed":"2018-10-30T14:18:58.36Z","status":1,"hasFollowups":false,"year":2017,"filesToSync":1},{"name":"123 Cherry Lane","scheduled":null,"completed":null,"status":1,"hasFollowups":false,"year":2017,"filesToSync":1},{"name":"Hudson Property","scheduled":"2018-10-20T14:18:58.36Z","completed":null,"status":4,"hasFollowups":false,"year":2017,"filesToSync":0},{"name":"Westview Condominiums","scheduled":null,"completed":"2018-10-30T14:18:58.36Z","status":3,"hasFollowups":false,"year":2017,"filesToSync":0},{"name":"An Apartment Complex","scheduled":null,"completed":null,"status":0,"hasFollowups":false,"year":2017,"filesToSync":1},{"name":"Kings Crossing","scheduled":null,"completed":"2018-10-30T14:18:58.36Z","status":2,"hasFollowups":false,"year":2018,"filesToSync":1},{"name":"Greenville Apartments","scheduled":null,"completed":null,"status":3,"hasFollowups":false,"year":2018,"filesToSync":1},{"name":"Knights Shadow Properties","scheduled":null,"completed":null,"status":3,"hasFollowups":false,"year":2018,"filesToSync":0},{"name":"Perry on Main Apartments","scheduled":null,"completed":null,"status":1,"hasFollowups":false,"year":2017,"filesToSync":1}]');
    for (Map<String, dynamic> obj in inspectionsList) {
      var inspection = InspectionClass.fromMap(obj);
      if (widget.selectedYear == inspection.year) {
        list.add(_buildInspection(inspection));
      }
    }*/

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(top: 10),
      child: ListView(
          padding: EdgeInsets.only(left: 10, right: 10),
          children: _buildInspections()),
    ));
  }
}

class InspectionsList extends StatefulWidget {
  int selectedYear;
  @override
  InspectionsListState createState() => new InspectionsListState();

  InspectionsList(this.selectedYear);
}
