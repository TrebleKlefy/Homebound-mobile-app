// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
    NotificationModel({
        this.notification,
    });

    List<Notifications> notification;

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        notification: List<Notifications>.from(json["notification"].map((x) => Notifications.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "notification": List<dynamic>.from(notification.map((x) => x.toJson())),
    };
}

class Notifications {
    Notifications({
        this.id,
        this.type,
        this.notifiableType,
        this.notifiableId,
        this.data,
        this.readAt,
        this.createdAt,
        this.updatedAt,
    });

    String id;
    String type;
    String notifiableType;
    int notifiableId;
    Data data;
    dynamic readAt;
    DateTime createdAt;
    DateTime updatedAt;

    factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        id: json["id"],
        type: json["type"],
        notifiableType: json["notifiable_type"],
        notifiableId: json["notifiable_id"],
        data: Data.fromJson(json["data"]),
        readAt: json["read_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "notifiable_type": notifiableType,
        "notifiable_id": notifiableId,
        "data": data.toJson(),
        "read_at": readAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Data {
    Data({
        this.name,
        this.body,
        this.greeting,
        this.thanks,
    });

    String name;
    String body;
    String greeting;
    String thanks;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        body: json["body"],
        greeting: json["greeting"],
        thanks: json["thanks"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "body": body,
        "greeting": greeting,
        "thanks": thanks,
    };
}
