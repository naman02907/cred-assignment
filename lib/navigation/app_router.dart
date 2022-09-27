// import 'package:cred_assignment/navigation/app_routes.dart';
// import 'package:cred_assignment/ui/home_screen/view/home_screen.dart';
// import 'package:flutter/material.dart';
//
// class AppRouter {
//   PageRoute onGenerateRoute(RouteSettings routeSettings) {
//     return CustomRoute(
//         builder: (context) {
//           return _getNavigationWidget(context, routeSettings.name,
//               params: routeSettings.arguments);
//         },
//         settings: routeSettings);
//   }
//
//   Widget _getNavigationWidget(BuildContext context, route, {dynamic params}) {
//     switch(route) {
//       case AppRoutes.homePage:
//         return const HomeScreen();
//       // case AppRoutes.bottomSheet1:
//       //   return c
//     }
//   }
// }
//
// class CustomRoute<T> extends MaterialPageRoute<T> {
//   CustomRoute({required WidgetBuilder builder, RouteSettings? settings})
//       : super(builder: builder, settings: settings);
//
//   @override
//   Duration get transitionDuration => const Duration(milliseconds: 150);
//
//   @override
//   Widget buildTransitions(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation, Widget child) {
//     return FadeTransition(opacity: animation, child: child);
//   }
// }