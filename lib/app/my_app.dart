import 'package:assignment_1/state_provder/theme_logic.dart';
import 'package:assignment_1/views/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLightMode = context.watch<ThemeLogic>().isLight;

    const primaryColor = Colors.deepPurple;
    const onPrimaryColor = Colors.white;

    final secondaryColor = Colors.grey.shade300;
    final shadowColor = Colors.black.withOpacity(0.08);

    const darkPrimary = Color.fromARGB(255, 39, 179, 160);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),

      themeMode: isLightMode ? ThemeMode.light : ThemeMode.dark,

      // LIGHT THEME
      theme: ThemeData(
        brightness: Brightness.light,

        scaffoldBackgroundColor: Colors.white,

        colorScheme: ColorScheme.light(
          primary: primaryColor,
          onPrimary: onPrimaryColor,
          onInverseSurface: Colors.green.shade700,
          surface: Colors.white,
          onSurface: Colors.black,

          secondary: secondaryColor,

          outline: Colors.grey.shade700,

          shadow: shadowColor,

          error: Colors.red,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),

        cardColor: Colors.white,

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: secondaryColor,

          iconColor: primaryColor,
          prefixIconColor: primaryColor,

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),

        listTileTheme: const ListTileThemeData(iconColor: primaryColor),
      ),

      // DARK THEME
      darkTheme: ThemeData(
        brightness: Brightness.dark,

        scaffoldBackgroundColor: const Color(0xFF121212),

        colorScheme: ColorScheme.dark(
          primary: darkPrimary,
          onPrimary: Colors.black,
          surfaceContainer: Colors.grey.shade800,
          surface: const Color(0xFF1E1E1E),
          onSurface: Colors.white,
          onInverseSurface: Colors.green.shade500,

          secondary: Colors.grey.shade800,

          outline: Colors.grey.shade500,

          shadow: Colors.black54,

          error: Colors.redAccent,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          foregroundColor: Colors.white,
          elevation: 0,
        ),

        cardColor: const Color(0xFF1E1E1E),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade900,

          iconColor: darkPrimary,
          prefixIconColor: darkPrimary,

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade700),
            borderRadius: BorderRadius.circular(12),
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: darkPrimary, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),

        listTileTheme: const ListTileThemeData(
          iconColor: darkPrimary,
          textColor: Colors.white,
        ),
      ),
    );
  }
}
