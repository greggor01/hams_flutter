import 'package:http/http.dart' as http;

import './models/InspectionStatus.dart';
import './helpers/JsonHelper.dart';

class Apis {
  static const String _serverURL =
      'https://hudson-ams-test-dev.azurewebsites.net/api/';
  static String _authHeader;

  static void setAuthHeader(String authHeader) {
    _authHeader = 'Bearer ' + authHeader;
  }

  static Future<http.Response> login(String username, String password) {
    var postEndpoint = _serverURL + 'account/authenticate';
    var body = {
      'usernameOrEmailAddress': username,
      'password': password,
      'tenancyName': 'Default'
    };
    return http.post(postEndpoint, headers: null, body: body);
  }

  static Future<List<InspectionStatus>> getSiteInspectionUpdateStatus() async {
    final response = await http.post(
        _serverURL +
            'services/app/siteInspectionSync/getSiteInspectionUpdateStatus',
        headers: {'Authorization': _authHeader},
        body: {});

    List<InspectionStatus> list = List<InspectionStatus>();

    // If server returns an OK response, parse the JSON
    if (response.statusCode == 200) {
      var tempList = JsonHelper.parseJSONArray(response.body);
      for (Map<String, dynamic> obj in tempList) {
        var inspection = InspectionStatus.fromJson(obj);
        list.add(inspection);
      }
      return list;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
