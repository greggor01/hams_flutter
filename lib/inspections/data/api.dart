import 'package:http/http.dart' as http;

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

  static Future<http.Response> getSiteInspectionUpdateStatus() {
    return http.post(
        _serverURL +
            'services/app/siteInspectionSync/getSiteInspectionUpdateStatus',
        headers: {'Authorization': _authHeader},
        body: {});
  }
}
