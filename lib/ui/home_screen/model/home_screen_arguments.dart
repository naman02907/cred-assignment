class HomeScreenArguments {
  static final HomeScreenArguments _singleton = HomeScreenArguments._internal();

  factory HomeScreenArguments() {
    return _singleton;
  }

  HomeScreenStacks currentStack = HomeScreenStacks.home;

  HomeScreenArguments._internal();
}

enum HomeScreenStacks {
  home, emiSelection, bankSelection
}