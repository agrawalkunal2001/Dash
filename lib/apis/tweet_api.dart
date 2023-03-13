import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:dash/constants/appwrite_constants.dart';
import 'package:dash/core/core.dart';
import 'package:dash/core/providers.dart';
import 'package:dash/models/tweet_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final tweetAPIProvider = Provider((ref) {
  return TweetAPI(db: ref.watch(appwriteDatabaseProvider));
});

abstract class ITweetAPI {
  FutureEither<Document> shareTweet(TweetModel tweet);
}

class TweetAPI implements ITweetAPI {
  final Databases _db;
  TweetAPI({required Databases db}) : _db = db;

  @override
  FutureEither<Document> shareTweet(TweetModel tweet) async {
    try {
      final document = await _db.createDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.tweetsCollectionId,
          documentId: ID.unique(),
          data: tweet.toMap());

      return right(document);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(e.message ?? "Some unexpected error occurred!", st),
      );
    } catch (e, st) {
      return left(
        Failure(e.toString(), st),
      );
    }
  }
}
