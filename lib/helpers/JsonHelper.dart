import 'dart:convert';

class JsonHelper {
  static List<dynamic> parseJSONArray(String json) {
    var temp = JsonDecoder().convert(json);
    return temp['result'];
  }
}
