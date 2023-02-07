import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

String getNameFromEmail(String email) {
  return email.split("@")[0]; // Split email at @ and take first element
}
