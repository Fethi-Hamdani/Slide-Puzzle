import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:slidepuzzle/ViewModels/board_controller.dart';
import 'package:slidepuzzle/ViewModels/navigation.dart';
import 'package:slidepuzzle/firebase_options.dart';

import 'UI/Pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
          primaryColor: Colors.black,
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.black38, hoverColor: Colors.black45)),
      darkTheme: ThemeData(
          primaryColor: Colors.black,
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.black38, hoverColor: Colors.black45)),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => BoardController(),
          ),
          ChangeNotifierProvider(
            create: (context) => Navigation(),
          ),
        ],
        builder: (context, child) {
          double swidth = MediaQuery.of(context).size.width;
          double width = MediaQuery.of(context).size.width * 0.8;
          if (swidth >= 425) {
            width = MediaQuery.of(context).size.width * 0.4;
          }
          if (swidth >= 1000) {
            width = MediaQuery.of(context).size.width * 0.28;
          }

          Provider.of<BoardController>(context, listen: false)
              .init(width: width);

          return const Home();
        },
      ),
    );
  }
}
