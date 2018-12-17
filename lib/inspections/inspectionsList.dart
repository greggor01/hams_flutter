import 'package:flutter/material.dart';

import './data/InspectionStatusClass.dart';
import '../helpers/EnumHelper.dart';
import '../inspections/data/api.dart';

class InspectionsListState extends State<InspectionsList> {
  Map<String, bool> _tapInProgress = Map<String, bool>();
  Future<List<InspectionStatusClass>> inspectionStatusResponse;

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

  void _onTapDownRefresh(
      TapDownDetails details, InspectionStatusClass inspection) {
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
                      child: inspection.hasFollowups != null &&
                              inspection.hasFollowups == true
                          ? Text('Yes')
                          : Text('No')),
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

  List<Widget> _buildInspections(List<InspectionStatusClass> inspections) {
    List<Widget> list = new List<Widget>();
    for (var inspection in inspections) {
      if (widget.selectedYear == inspection.year) {
        list.add(_buildInspection(inspection));
      }
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<InspectionStatusClass>>(
      future: inspectionStatusResponse,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: ListView(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  children: _buildInspections(snapshot.data)),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner
        return CircularProgressIndicator();
      },
    );
  }
}

class InspectionsList extends StatefulWidget {
  final int selectedYear;
  @override
  InspectionsListState createState() => new InspectionsListState();

  InspectionsList(this.selectedYear);
}
