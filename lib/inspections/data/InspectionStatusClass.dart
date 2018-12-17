import 'package:intl/intl.dart';

import '../../enums.dart';
import '../../helpers/EnumHelper.dart';

class InspectionStatusClass {
  String name;
  DateTime scheduled;
  DateTime completed;
  InspectionStatus status;
  bool hasFollowups;
  int filesToSync;
  int year;

  InspectionStatusClass();

  factory InspectionStatusClass.fromJson(Map<String, dynamic> inspectionMap) {
    InspectionStatusClass obj = new InspectionStatusClass();
    obj.name = inspectionMap['name'];
    obj.scheduled = inspectionMap['scheduled'] == null
        ? null
        : DateTime.parse(inspectionMap['scheduled']);
    obj.completed = inspectionMap['completed'] == null
        ? null
        : DateTime.parse(inspectionMap['completed']);
    obj.status = InspectionStatus.values[inspectionMap['status']];
    obj.hasFollowups = inspectionMap['hasFollowups'];
    obj.filesToSync = inspectionMap['filesToSync'];
    obj.year = inspectionMap['year'];

    return obj;
  }

  String getScheduledForDisplay() {
    if (scheduled == null) {
      return "";
    }

    return DateFormat.yMMMd().format(scheduled);
  }

  String getCompletedForDisplay() {
    if (completed == null) {
      return "";
    }

    return DateFormat.yMMMd().format(completed);
  }

  String getStatusForDisplay() {
    return EnumHelper.getInspectionStatusDisplayName(status);
  }
}
