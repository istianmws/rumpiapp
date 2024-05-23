// To parse this JSON data, do
//
//     final commentsModel = commentsModelFromJson(jsonString);

import 'dart:convert';

CommentsModel commentsModelFromJson(String str) => CommentsModel.fromJson(json.decode(str));

String commentsModelToJson(CommentsModel data) => json.encode(data.toJson());

class CommentsModel {
    int? id;
    int? userId;
    int? feedId;
    String? body;
    DateTime? createdAt;
    DateTime? updatedAt;
    Feed? feed;
    User? user;

    CommentsModel({
        this.id,
        this.userId,
        this.feedId,
        this.body,
        this.createdAt,
        this.updatedAt,
        this.feed,
        this.user,
    });

    factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
        id: json["id"],
        userId: json["user_id"],
        feedId: json["feed_id"],
        body: json["body"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        feed: json["feed"] == null ? null : Feed.fromJson(json["feed"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "feed_id": feedId,
        "body": body,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "feed": feed?.toJson(),
        "user": user?.toJson(),
    };
}

class Feed {
    int? id;
    int? userId;
    String? content;
    DateTime? createdAt;
    DateTime? updatedAt;
    bool? liked;

    Feed({
        this.id,
        this.userId,
        this.content,
        this.createdAt,
        this.updatedAt,
        this.liked,
    });

    factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        id: json["id"],
        userId: json["user_id"],
        content: json["content"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        liked: json["liked"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "content": content,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "liked": liked,
    };
}

class User {
    int? id;
    String? name;
    String? username;
    String? email;
    dynamic emailVerifiedAt;
    DateTime? createdAt;
    DateTime? updatedAt;

    User({
        this.id,
        this.name,
        this.username,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
