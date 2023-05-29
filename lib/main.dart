import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_test_app/providers/themeProvider.dart';
import 'package:my_test_app/providers/userProvider.dart';
import 'package:my_test_app/router.dart';
import 'package:my_test_app/screens/splashscreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My Text App',
          theme: themeProvider.themeData, 
          onGenerateRoute: (settings) => generateRoute(settings),
          home: const SplashScreen(),
        );
      },
    );
  }
}