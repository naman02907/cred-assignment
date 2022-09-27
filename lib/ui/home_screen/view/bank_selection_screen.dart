import 'package:flutter/material.dart';

import '../../../themes/app_colors.dart';
import '../../../utils/event_broadcast.dart';
import '../model/home_screen_arguments.dart';

class BankSelectionRoute extends StatefulWidget {
  const BankSelectionRoute({Key? key}) : super(key: key);

  @override
  State<BankSelectionRoute> createState() => _BankSelectionState();
}

class _BankSelectionState extends State<BankSelectionRoute> {
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
    double stackHeight = _screenSize.height - 300;
    return AnimatedPositioned(
      bottom: HomeScreenArguments().currentStack == HomeScreenStacks.bankSelection
          ? 0
          : -stackHeight,
      duration: const Duration(milliseconds: 200),
      child: Container(
        height: stackHeight,
        width: _screenSize.width,
        decoration: const BoxDecoration(
          color: AppColors.colorNavyColor95,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: _getScreenContent(),
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
            children: const [
              Text(
                "where should we send your money",
                style: TextStyle(fontSize: 20, color: AppColors.colorWhite),
              ),
              Padding(
                padding: EdgeInsets.only(right: 50, top: 20),
                child: Text(
                  "choose one of our recommended plans or make your own",
                  style: TextStyle(
                      fontSize: 14, color: AppColors.darkPrimaryColor),
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
            "Tap for one click kyc",
            style: TextStyle(color: AppColors.colorWhite),
          ),
        ),
      ),
    );
  }
}
