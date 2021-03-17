// To parse this JSON data, do
//
//     final checkIn = checkInFromJson(jsonString);

import 'dart:convert';

List<CheckIn> checkInFromJson(String str) =>
    List<CheckIn>.from(json.decode(str).map((x) => CheckIn.fromJson(x)));

String checkInToJson(List<CheckIn> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CheckIn {
  CheckIn({
    this.username,
    this.eventId,
    this.epochTime,
    this.eventName,
    this.datetime,
    this.readerId,
  });

  String username;
  int eventId;
  String epochTime;
  String eventName;
  DateTime datetime;
  String readerId;

  factory CheckIn.fromJson(Map<String, dynamic> json) => CheckIn(
        username: json["username"],
        eventId: json["event_id"],
        epochTime: json["epoch_time"],
        eventName: json["event_name"],
        datetime: DateTime.parse(json["datetime"]),
        readerId: json["reader_id"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "event_id": eventId,
        "epoch_time": epochTime,
        "event_name": eventName,
        "datetime": datetime.toIso8601String(),
        "reader_id": readerId,
      };
}
