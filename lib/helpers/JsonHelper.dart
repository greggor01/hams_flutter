import 'dart:convert';

class JsonHelper {
  static List<dynamic> parseJSONArray(String json) {
    JsonCodec codec = new JsonCodec();
    List<dynamic> list = codec.decode(json) as List;
    return list;
  }
}
