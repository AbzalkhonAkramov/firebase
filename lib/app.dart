import 'package:flutter/material.dart';

import 'core/route/route_generator.dart';
import 'core/route/route_names.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RouteNames.signUpPage,
      onGenerateRoute: AppRoute(context: context).onGenerateRoute,
    );
  }
}
