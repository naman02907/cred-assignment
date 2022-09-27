import 'package:cred_assignment/utils/event_broadcast.dart';
import 'package:flutter/material.dart';

import '../../../themes/app_colors.dart';
import '../model/home_screen_arguments.dart';

class EmiSelectionRoute extends StatefulWidget {
  const EmiSelectionRoute({Key? key}) : super(key: key);

  @override
  State<EmiSelectionRoute> createState() => _EmiSelectionRouteState();
}

class _EmiSelectionRouteState extends State<EmiSelectionRoute> {
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
    double stackHeight = _screenSize.height - 200;
    return AnimatedPositioned(
      bottom: HomeScreenArguments().currentStack != HomeScreenStacks.home
          ? 0
          : -stackHeight,
      duration: const Duration(milliseconds: 200),
      child: Container(
        height: stackHeight,
        width: _screenSize.width,
        decoration: const BoxDecoration(
          color: AppColors.colorNavyColor85,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: HomeScreenArguments().currentStack != HomeScreenStacks.emiSelection ? _getCollapsedStateWidget() : _getScreenContent(),
      ),
    );
  }

  Widget _getScreenContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "how do you wish to repay",
                style: TextStyle(fontSize: 20, color: AppColors.colorWhite),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 50, top: 20),
                child: Text(
                  "choose one of our recommended plans or make your own",
                  style: TextStyle(
                      fontSize: 14, color: AppColors.darkPrimaryColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _getEmiCard(Colors.cyan),
                      _getEmiCard(Colors.red),
                      _getEmiCard(Colors.black),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        _getBottomButton()
      ],
    );
  }

  Widget _getEmiCard(Color color) {
    return Container(
      /// 20 is left padding and 16 is spacing between cards and 40 is last peeping card width
      margin: const EdgeInsets.only(right: 20),
      width: (_screenSize.width - 20 - 2 * 16 - 40) / 2,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
    );
  }

  Widget _getBottomButton() {
    return GestureDetector(
      onTap: () {
        EventsBroadcast.get().send(ChangeHomeScreenStack(currentStack: HomeScreenStacks.bankSelection));
      },
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.colorNavyColorLight,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        height: 70,
        width: _screenSize.width,
        child: const Center(
          child: Text(
            "Select your bank account",
            style: TextStyle(color: AppColors.colorWhite),
          ),
        ),
      ),
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
                "EMI",
                style:
                TextStyle(fontSize: 16, color: AppColors.darkPrimaryColor),
              ),
              Text(
                "\u20B94247 /month",
                style:
                TextStyle(fontSize: 20, color: AppColors.darkPrimaryColor),
              )
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "duration",
                style:
                TextStyle(fontSize: 16, color: AppColors.darkPrimaryColor),
              ),
              Text(
                "12 months",
                style:
                TextStyle(fontSize: 20, color: AppColors.darkPrimaryColor),
              )
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              EventsBroadcast.get().send(
                  ChangeHomeScreenStack(currentStack: HomeScreenStacks.emiSelection));
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
}
