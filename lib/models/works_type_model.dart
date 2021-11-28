import 'dart:convert';

WorksData worksDataFromJson(String str) => WorksData.fromJson(json.decode(str));

String worksDataToJson(WorksData data) => json.encode(data.toJson());

class WorksData {
  WorksData({
    this.message,
    this.data,
  });

  String message;
  List<WorkData> data;

  factory WorksData.fromJson(Map<String, dynamic> json) => WorksData(
        message: json["message"],
        data:
            List<WorkData>.from(json["data"].map((x) => WorkData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class WorkData {
  WorkData({
    this.id,
    this.data,
  });

  String id;
  Data data;

  factory WorkData.fromJson(Map<String, dynamic> json) => WorkData(
        id: json["id"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.name,
    this.id,
  });

  String name;
  String id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
