import '../enums.dart';

class EnumHelper {
  static String getInspectionStatusDisplayName(InspectionStatus value) {
    String retVal = "Not Started";
    switch (value) {
      case InspectionStatus.notStarted:
        retVal = "Not Started";
        break;
      case InspectionStatus.started:
        retVal = "In Progress";
        break;
      case InspectionStatus.submitted:
        retVal = "Submitted";
        break;
      case InspectionStatus.approved:
        retVal = "Approved";
        break;
      case InspectionStatus.rejected:
        retVal = "Rejected";
        break;
    }

    return retVal;
  }
}
