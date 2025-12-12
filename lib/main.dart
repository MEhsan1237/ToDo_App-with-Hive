
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_project/notes_model/notes_model.dart';
import 'package:hive_project/provider/provider_class.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'main_screen/main_screen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.deepOrange
  ));
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>("notes");
  await Hive.openBox('settings');


  runApp(ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        cardColor:  Colors.white,
        scaffoldBackgroundColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
          cardColor:  Colors.white,
          scaffoldBackgroundColor: Colors.black,
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.black),


          ),
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          dialogBackgroundColor: Colors.white,
          textTheme: TextTheme(
            bodySmall: TextStyle(
              color: Colors.black
            ),


            bodyMedium: TextStyle(
              color: Colors.black,
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black
          )
      ),

      home: const MyAppHive(),
    );
  }
}
