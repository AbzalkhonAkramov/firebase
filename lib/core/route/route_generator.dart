import 'package:flutter/material.dart';
import 'package:group415/core/route/route_names.dart';
import 'package:group415/pages/sign_up_page.dart';
import 'package:group415/pages/students_page.dart';
import '../../pages/home_page.dart';
import '../../pages/sign_in_page.dart';

class AppRoute {
  BuildContext context;

  AppRoute({required this.context});

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.signInPage:
        return MaterialPageRoute(builder: (_) => SignInPage());
      case RouteNames.signUpPage:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case RouteNames.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case RouteNames.studentsPage:
        return MaterialPageRoute(builder: (_) => const StudentsPage());

      // case RouteNames.byCategoryPage:
      //   final categoryData = routeSettings.arguments as Map<String, String>;
      //   return MaterialPageRoute(
      //       builder: (_) => ProductByCategoryPage(data: categoryData));
      default:
        return _errorRoute();
    }
  }

  Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('Page not found')),
          ),
    );
  }
}
