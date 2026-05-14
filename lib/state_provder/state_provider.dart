import 'package:assignment_1/app/my_app.dart';
import 'package:assignment_1/state_provder/theme_logic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget stateProvider() {
  return MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => ThemeLogic())],
    child: MyApp(),
  );
}
