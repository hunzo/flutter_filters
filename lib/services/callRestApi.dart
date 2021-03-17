import 'dart:convert';

import 'package:http/http.dart' as Http;
import '../models/checkIn.dart';

class CallApis {
  var url = Uri.parse("https://oauth2.nida.ac.th:8443/itc/checkin");
  Map<String, String> headers = {
    "Content-type": "application/json",
    "x-api-key": "8W2txB0jy9QxbpO2yQAdoamIbBLnE07o"
  };

  Future<List<CheckIn>> fetchUsers() async {
    print("Call APis");
    // final rs = await Http.get(Uri.parse("https://oauth2.nida.ac.th:8443"),
    final rs = await Http.get(url, headers: headers);
    // print(rs.body);
    // return null;

    // try {
    if (rs.statusCode == 200) {
      // final List<CheckIn> users = checkInFromJson(rs.body);

      var ret = parseRespones(rs.body);

      // print(ret);
      return ret;
    } else {
      return null;
    }
    // } catch (e) {
    // return e;
    // }
  }

  List<CheckIn> parseRespones(String response) {
    final parsed = jsonDecode(response).cast<Map<String, dynamic>>();
    return parsed.map<CheckIn>((json) => CheckIn.fromJson(json)).toList();
  }
}
