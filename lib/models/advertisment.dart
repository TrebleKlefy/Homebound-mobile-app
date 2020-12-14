// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

AvertisementModel avertisementModelFromJson(String str) =>
    AvertisementModel.fromJson(json.decode(str));

String avertisementModelToJson(AvertisementModel data) =>
    json.encode(data.toJson());

class AvertisementModel {
  AvertisementModel({
    this.advertisments,
    this.images,
  });

  List<Advertisment> advertisments;
  List<List<Imagery>> images;

  factory AvertisementModel.fromJson(Map<String, dynamic> json) =>
      AvertisementModel(
        advertisments: List<Advertisment>.from(
            json["advertisments"].map((x) => Advertisment.fromJson(x))),
        images: List<List<Imagery>>.from(json["images"]
            .map((x) => List<Imagery>.from(x.map((x) => Imagery.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "advertisments":
            List<dynamic>.from(advertisments.map((x) => x.toJson())),
        "images": List<dynamic>.from(
            images.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class Advertisment {
  Advertisment({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.rooms,
    this.bathRooms,
    this.kitchenRooms,
    this.street,
    this.apartmentNumber,
    this.amenity,
    this.description,
    this.phoneNumber,
    this.email,
    this.contract,
    this.buildingtype,
    this.price,
    this.parish,
    this.photoName,
    // this.photoDescription,
    this.images,
    this.name,
    this.feature,
    this.userId,
    // this.approved,
    this.user,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int rooms;
  int bathRooms;
  int kitchenRooms;
  String street;
  String apartmentNumber;
  String amenity;
  String description;
  String phoneNumber;
  String email;
  String contract;
  String buildingtype;
  String price;
  String parish;
  String photoName;
  dynamic photoDescription;
  String images;
  String name;
  int feature;
  int userId;
  // int approved;
  User user;

  factory Advertisment.fromJson(Map<String, dynamic> json) => Advertisment(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        rooms: json["rooms"],
        bathRooms: json["bath_rooms"],
        kitchenRooms: json["kitchen_rooms"],
        street: json["street"],
        apartmentNumber: json["apartment_number"],
        amenity: json["amenity"],
        description: json["description"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        contract: json["contract"],
        buildingtype: json["buildingtype"],
        price: json["price"],
        parish: json["parish"],
        photoName: json["photo_name"],
        // photoDescription: json["photo_description"],
        images: json["images"],
        name: json["name"],
        feature: json["feature"],
        userId: json["user_id"],
        // approved: json["approved"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "rooms": rooms,
        "bath_rooms": bathRooms,
        "kitchen_rooms": kitchenRooms,
        "street": street,
        "apartment_number": apartmentNumber,
        "amenity": amenity,
        "description": description,
        "phone_number": phoneNumber,
        "email": email,
        "contract": contract,
        "buildingtype": buildingtype,
        "price": price,
        "parish": parish,
        "photo_name": photoName,
        "photo_description": photoDescription,
        "images": images,
        "name": name,
        "feature": feature,
        "user_id": userId,
        // "approved": approved,
        "user": user.toJson(),
      };
}

class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.emailVerifiedAt,
    this.profilePhoto,
    this.usertype,
    this.gender,
    this.trn,
    this.notificationPreference,
    this.approved,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String firstName;
  String lastName;
  String email;
  dynamic emailVerifiedAt;
  dynamic profilePhoto;
  String usertype;
  String gender;
  String trn;
  String notificationPreference;
  int approved;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        profilePhoto: json["profile_photo"],
        usertype: json["usertype"],
        gender: json["gender"],
        trn: json["trn"],
        notificationPreference: json["notification_preference"],
        approved: json["approved"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "profile_photo": profilePhoto,
        "usertype": usertype,
        "gender": gender,
        "trn": trn,
        "notification_preference": notificationPreference,
        "approved": approved,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
      };
}

class Imagery {
  Imagery({
    this.id,
    // this.createdAt,
    // this.updatedAt,
    this.images,
    this.thumbnailimages,
    this.advertismentId,
    this.userId,
    this.advertId,
  });

  int id;
  // DateTime createdAt;
  // DateTime updatedAt;
  String images;
  String thumbnailimages;
  int advertismentId;
  String userId;
  String advertId;

  factory Imagery.fromJson(Map<String, dynamic> json) => Imagery(
        id: json["id"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        images: json["images"],
        thumbnailimages:json["thumbnailimages"],
        advertismentId: json["advertisment_id"],
        userId: json["user_id"],
        advertId: json["advert_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        "images": images,
        "thumbnailimages": thumbnailimages,
        "advertisment_id": advertismentId,
        "user_id": userId,
        "advert_id": advertId,
      };
}
