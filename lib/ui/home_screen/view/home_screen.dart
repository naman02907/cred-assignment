import 'package:cred_assignment/themes/app_colors.dart';
import 'package:cred_assignment/ui/home_screen/model/home_screen_arguments.dart';
import 'package:cred_assignment/ui/home_screen/view/bank_selection_screen.dart';
import 'package:cred_assignment/utils/event_broadcast.dart';
import 'package:flutter/material.dart';

import 'emi_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Size _screenSize;

  @override
  void initState() {
    EventsBroadcast.get().on().listen((event) {
      if (event is ChangeHomeScreenStack) {
        setState(() {
          HomeScreenArguments().currentStack = event.currentStack;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if(HomeScreenArguments().currentStack == HomeScreenStacks.bankSelection) {
          EventsBroadcast.get().send(
              ChangeHomeScreenStack(currentStack: HomeScreenStacks.emiSelection));
          return false;
        }
        if(HomeScreenArguments().currentStack == HomeScreenStacks.emiSelection) {
          EventsBroadcast.get().send(
              ChangeHomeScreenStack(currentStack: HomeScreenStacks.home));
          return false;
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.colorNavyColor65,
          body: Container(
            child: Stack(
              children: [
                _getHomeScreenContent(),
                const EmiSelectionRoute(),
                const BankSelectionRoute(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getHomeScreenContent() {
    return Column(
      children: [
        _getTopAppBarIcons(),
        Container(
          width: _screenSize.width,
          height: _screenSize.height - 60 - MediaQuery.of(context).padding.top,
          decoration: const BoxDecoration(
            color: AppColors.colorNavyColor75,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: HomeScreenArguments().currentStack != HomeScreenStacks.home
              ? _getCollapsedStateWidget()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _getTopHeaderTexts(),
                    _getCreditAmountCard(),
                    const Spacer(),
                    _getBottomButton(),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _getCollapsedStateWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "credit amount",
                style:
                    TextStyle(fontSize: 16, color: AppColors.darkPrimaryColor),
              ),
              Text(
                "\u20B91,50,000",
                style:
                    TextStyle(fontSize: 20, color: AppColors.darkPrimaryColor),
              )
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              EventsBroadcast.get().send(
                  ChangeHomeScreenStack(currentStack: HomeScreenStacks.home));
            },
            icon: const Icon(
              Icons.arrow_drop_down,
              color: AppColors.colorWhite,
            ),
          )
        ],
      ),
    );
  }

  Widget _getTopAppBarIcons() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Row(
        children: const [
          Icon(
            Icons.cancel_rounded,
            color: AppColors.colorWhite,
          ),
          Spacer(),
          Icon(
            Icons.question_mark,
            color: AppColors.colorWhite,
          )
        ],
      ),
    );
  }

  Widget _getTopHeaderTexts() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "nikunj, how much do you need?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16, right: 40),
            child: Text(
              "move the dial and set the any amount you need upto \u20B9 487,891",
              style: TextStyle(
                color: AppColors.darkPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getCreditAmountCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      width: double.infinity,
      height: 350,
      decoration: BoxDecoration(
          color: AppColors.colorWhite, borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("credit amount"),
                Text(
                  "\u20B9 1,50,000",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "stash in instant, money will be credited in instance",
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getBottomButton() {
    return GestureDetector(
      onTap: () {
        EventsBroadcast.get().send(
            ChangeHomeScreenStack(currentStack: HomeScreenStacks.emiSelection));
      },
      child: Container(
        decoration: const BoxDecoration(
            color: AppColors.colorNavyColorLight,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        height: 70,
        width: _screenSize.width,
        child: const Center(
          child: Text(
            "Proceed to EMI selection",
            style: TextStyle(color: AppColors.colorWhite),
          ),
        ),
      ),
    );
  }
}
