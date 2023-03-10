import 'dart:io';

import 'package:dash/apis/storage_api.dart';
import 'package:dash/apis/tweet_api.dart';
import 'package:dash/core/enums/tweet_type_enum.dart';
import 'package:dash/core/utils.dart';
import 'package:dash/features/auth/controller/auth_controller.dart';
import 'package:dash/models/tweet_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tweetControllerProvider =
    StateNotifierProvider<TweetController, bool>((ref) {
  return TweetController(
      ref: ref,
      tweetAPI: ref.watch(tweetAPIProvider),
      storageAPI: ref.watch(storageAPIProvider));
});

class TweetController extends StateNotifier<bool> {
  final TweetAPI _tweetAPI;
  final StorageAPI _storageAPI;
  final Ref _ref;
  TweetController(
      {required Ref ref,
      required TweetAPI tweetAPI,
      required StorageAPI storageAPI})
      : _ref = ref,
        _tweetAPI = tweetAPI,
        _storageAPI = storageAPI,
        super(false);

  void shareTweet(
      {required List<File> images,
      required String text,
      required BuildContext context}) {
    if (text.isEmpty) {
      showSnackbar(context, "Please enter text!");
      return;
    }

    if (images.isNotEmpty) {
      _shareImageTweet(images: images, text: text, context: context);
    } else {
      _shareTextTweet(text: text, context: context);
    }
  }

  void _shareImageTweet(
      {required List<File> images,
      required String text,
      required BuildContext context}) async {
    state = true;
    final links = _getLinkFromText(text);
    final hashtags = _getHashtagFromText(text);
    final user = _ref.read(currentUserDetailsProvider).value!;
    final imageLinks = await _storageAPI.uploadImage(images);

    TweetModel tweet = TweetModel(
        text: text,
        link: links,
        hashtag: hashtags,
        imageLink: imageLinks,
        uid: user.uid,
        tweetType: TweetType.image,
        tweetedAt: DateTime.now(),
        likes: [],
        commentIds: [],
        id: "",
        reshareCount: 0);

    final res = await _tweetAPI.shareTweet(tweet);
    state = false;
    res.fold((l) => showSnackbar(context, l.message), (r) => null);
  }

  void _shareTextTweet(
      {required String text, required BuildContext context}) async {
    state = true;
    final links = _getLinkFromText(text);
    final hashtags = _getHashtagFromText(text);
    final user = _ref.read(currentUserDetailsProvider).value!;

    TweetModel tweet = TweetModel(
        text: text,
        link: links,
        hashtag: hashtags,
        imageLink: [],
        uid: user.uid,
        tweetType: TweetType.text,
        tweetedAt: DateTime.now(),
        likes: [],
        commentIds: [],
        id: "",
        reshareCount: 0);

    final res = await _tweetAPI.shareTweet(tweet);
    state = false;
    res.fold((l) => showSnackbar(context, l.message), (r) => null);
  }

  List<String> _getLinkFromText(String text) {
    List<String> link = [];
    List<String> wordsInSentence = text.split(" ");

    for (String word in wordsInSentence) {
      if (word.startsWith("https://") || word.startsWith("www.")) {
        link.add(word);
      }
    }
    return link;
  }

  List<String> _getHashtagFromText(String text) {
    List<String> hashtag = [];
    List<String> wordsInSentence = text.split(" ");

    for (String word in wordsInSentence) {
      if (word.startsWith("#")) {
        hashtag.add(word);
      }
    }
    return hashtag;
  }
}
