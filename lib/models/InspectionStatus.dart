import 'package:intl/intl.dart';

import '../enums.dart';
import '../helpers/EnumHelper.dart';

class InspectionStatus {
  String name;
  DateTime scheduled;
  DateTime completed;
  InspectionStatusEnum status;
  bool hasFollowups;
  int filesToSync;
  int year;

  InspectionStatus();

  factory InspectionStatus.fromJson(Map<String, dynamic> inspectionMap) {
    InspectionStatus obj = new InspectionStatus();
    obj.name = inspectionMap['name'];
    obj.scheduled = inspectionMap['scheduled'] == null
        ? null
        : DateTime.parse(inspectionMap['scheduled']);
    obj.completed = inspectionMap['completed'] == null
        ? null
        : DateTime.parse(inspectionMap['completed']);
    obj.status = InspectionStatusEnum.values[inspectionMap['status']];
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
