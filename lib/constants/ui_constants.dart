import 'package:dash/constants/constants.dart';
import 'package:dash/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UIConstants {
  static AppBar appbar() {
    // If we create a separate reusable appbar and use in login view, it will give error because appbar requires a preferred sized widget and reusable appbar is simply a widget. So we create an AppVar appbar and use in login view
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        color: Pallete.blueColor,
        height: 50,
      ),
      centerTitle: true,
    );
  }
}
