// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

import 'package:dash/core/enums/tweet_type_enum.dart';

@immutable
class TweetModel {
  final String text;
  final List<String> link;
  final List<String> hashtag;
  final List<String> imageLink;
  final String uid;
  final TweetType tweetType;
  final DateTime tweetedAt;
  final List<String> likes;
  final List<String> commentIds;
  final String id;
  final int reshareCount;
  const TweetModel({
    required this.text,
    required this.link,
    required this.hashtag,
    required this.imageLink,
    required this.uid,
    required this.tweetType,
    required this.tweetedAt,
    required this.likes,
    required this.commentIds,
    required this.id,
    required this.reshareCount,
  });

  TweetModel copyWith({
    String? text,
    List<String>? link,
    List<String>? hashtag,
    List<String>? imageLink,
    String? uid,
    TweetType? tweetType,
    DateTime? tweetedAt,
    List<String>? likes,
    List<String>? commentIds,
    String? id,
    int? reshareCount,
  }) {
    return TweetModel(
      text: text ?? this.text,
      link: link ?? this.link,
      hashtag: hashtag ?? this.hashtag,
      imageLink: imageLink ?? this.imageLink,
      uid: uid ?? this.uid,
      tweetType: tweetType ?? this.tweetType,
      tweetedAt: tweetedAt ?? this.tweetedAt,
      likes: likes ?? this.likes,
      commentIds: commentIds ?? this.commentIds,
      id: id ?? this.id,
      reshareCount: reshareCount ?? this.reshareCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'link': link,
      'hashtag': hashtag,
      'imageLink': imageLink,
      'uid': uid,
      'tweetType': tweetType.type,
      'tweetedAt': tweetedAt.millisecondsSinceEpoch,
      'likes': likes,
      'commentIds': commentIds,
      'reshareCount': reshareCount,
    };
  }

  factory TweetModel.fromMap(Map<String, dynamic> map) {
    return TweetModel(
      text: map['text'] ?? "",
      link: List<String>.from(map['link']),
      hashtag: List<String>.from(map['hashtag']),
      imageLink: List<String>.from(map['imageLink']),
      uid: map['uid'] ?? "",
      tweetType: (map['tweetType'] as String).toEnum(),
      tweetedAt: DateTime.fromMillisecondsSinceEpoch(map['tweetedAt']),
      likes: List<String>.from(map['likes']),
      commentIds: List<String>.from(map['commentIds']),
      id: map['\$id'] ?? "",
      reshareCount: map['reshareCount']?.toInt() ?? 0,
    );
  }

  @override
  String toString() {
    return 'TweetModel(text: $text, link: $link, hashtag: $hashtag, imageLink: $imageLink, uid: $uid, tweetType: $tweetType, tweetedAt: $tweetedAt, likes: $likes, commentIds: $commentIds, id: $id, reshareCount: $reshareCount)';
  }

  @override
  bool operator ==(covariant TweetModel other) {
    if (identical(this, other)) return true;

    return other.text == text &&
        listEquals(other.link, link) &&
        listEquals(other.hashtag, hashtag) &&
        listEquals(other.imageLink, imageLink) &&
        other.uid == uid &&
        other.tweetType == tweetType &&
        other.tweetedAt == tweetedAt &&
        listEquals(other.likes, likes) &&
        listEquals(other.commentIds, commentIds) &&
        other.id == id &&
        other.reshareCount == reshareCount;
  }

  @override
  int get hashCode {
    return text.hashCode ^
        link.hashCode ^
        hashtag.hashCode ^
        imageLink.hashCode ^
        uid.hashCode ^
        tweetType.hashCode ^
        tweetedAt.hashCode ^
        likes.hashCode ^
        commentIds.hashCode ^
        id.hashCode ^
        reshareCount.hashCode;
  }
}
