import 'package:dash/constants/constants.dart';
import 'package:dash/features/tweet/view/create_tweet_screen.dart';
import 'package:dash/theme/pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class HomeView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomeView());
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 0;
  final appBar = UIConstants.appbar();

  void onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: IndexedStack(
        // It helps to maintain state. eg. If we scroll tweets and go on search page and then come to home again, it will not rebuild the page and stay in the original state.
        index: _page,
        children: UIConstants.bottomTabBarPages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, CreateTweetScreen.route());
        },
        child: const Icon(
          Icons.add,
          color: Pallete.whiteColor,
          size: 28,
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _page,
        onTap: onPageChange,
        backgroundColor: Pallete.backgroundColor,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
            _page == 0
                ? AssetsConstants.homeFilledIcon
                : AssetsConstants.homeOutlinedIcon,
            color: Pallete.whiteColor,
          )),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
            AssetsConstants.searchIcon,
            color: Pallete.whiteColor,
          )),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
            _page == 2
                ? AssetsConstants.notifFilledIcon
                : AssetsConstants.notifOutlinedIcon,
            color: Pallete.whiteColor,
          )),
        ],
      ),
    );
  }
}
