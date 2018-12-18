import '../enums.dart';

class EnumHelper {
  static String getInspectionStatusDisplayName(InspectionStatusEnum value) {
    String retVal = "Not Started";
    switch (value) {
      case InspectionStatusEnum.notStarted:
        retVal = "Not Started";
        break;
      case InspectionStatusEnum.started:
        retVal = "In Progress";
        break;
      case InspectionStatusEnum.submitted:
        retVal = "Submitted";
        break;
      case InspectionStatusEnum.approved:
        retVal = "Approved";
        break;
      case InspectionStatusEnum.rejected:
        retVal = "Rejected";
        break;
    }

    return retVal;
  }
}
