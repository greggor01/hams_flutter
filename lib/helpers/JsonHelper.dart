import 'dart:convert';

class JsonHelper {
  static List<dynamic> parseJSONArray(String json) {
    JsonCodec codec = new JsonCodec();
    var temp = codec.decode(json);
    return temp['result'];
  }
}
