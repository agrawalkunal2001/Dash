class AppwriteConstants {
  static const String databaseId = "63d749570a4527739b68";
  static const String projectId = "63d747ce99fce9855f00";
  static const String endPoint =
      "http://172.17.3.33/v1"; // End point helps flutter app communicate with appwrite
  static const String usersCollectionId = "63e20eca996daf67ca75";
  static const String tweetsCollectionId = "63fdd72ed9dc046335ad";
  static const String imagesBucketId = "640f03f11fc46f5cb0aa";

  static String imageURL(String imageId) =>
      "$endPoint/storage/buckets/$imagesBucketId/files/$imageId/view?project=$projectId&mode=admin";
}
