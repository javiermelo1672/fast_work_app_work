// To parse this JSON data, do
//
//     final workModel = workModelFromJson(jsonString);

import 'dart:convert';

WorkModel workModelFromJson(String str) => WorkModel.fromJson(json.decode(str));

String workModelToJson(WorkModel data) => json.encode(data.toJson());

class WorkModel {
  WorkModel({
    this.data,
  });

  WorkyModel data;

  factory WorkModel.fromJson(Map<String, dynamic> json) => WorkModel(
        data: WorkyModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class WorkyModel {
  WorkyModel({
    this.image,
    this.title,
    this.description,
    this.price,
    this.type,
    this.listPlaces,
    this.state,
    this.userId,
    this.userInfo,
    this.userWorker,
    this.createdAt,
  });

  String image;
  String title;
  String description;
  String price;
  String type;
  List<ListPlace> listPlaces;
  String state;
  String userId;
  UserInfo userInfo;
  UserWorker userWorker;
  String createdAt;

  factory WorkyModel.fromJson(Map<String, dynamic> json) => WorkyModel(
        image: json["image"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        type: json["type"],
        listPlaces: List<ListPlace>.from(
            json["list_places"].map((x) => ListPlace.fromJson(x))),
        state: json["state"],
        userId: json["user_id"],
        userInfo: UserInfo.fromJson(json["user_info"]),
        userWorker: UserWorker.fromJson(json["user_worker"]),
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "title": title,
        "description": description,
        "price": price,
        "type": type,
        "list_places": List<dynamic>.from(listPlaces.map((x) => x.toJson())),
        "state": state,
        "user_id": userId,
        "user_info": userInfo.toJson(),
        "user_worker": userWorker.toJson(),
        "created_at": createdAt,
      };
}

class ListPlace {
  ListPlace({
    this.place,
    this.placeDescription,
  });

  String place;
  String placeDescription;

  factory ListPlace.fromJson(Map<String, dynamic> json) => ListPlace(
        place: json["place"],
        placeDescription: json["place_description"],
      );

  Map<String, dynamic> toJson() => {
        "place": place,
        "place_description": placeDescription,
      };
}

class UserInfo {
  UserInfo({
    this.name,
    this.profilePhoto,
  });

  String name;
  String profilePhoto;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        name: json["name"],
        profilePhoto: json["profile_photo"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "profile_photo": profilePhoto,
      };
}

class UserWorker {
  UserWorker({
    this.name,
    this.profilePhoto,
    this.id,
  });

  String name;
  String profilePhoto;
  String id;

  factory UserWorker.fromJson(Map<String, dynamic> json) => UserWorker(
        name: json["name"],
        profilePhoto: json["profile_photo"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "profile_photo": profilePhoto,
        "id": id,
      };
}
