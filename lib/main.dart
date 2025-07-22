import 'package:flutter/material.dart'; // Flutter's material design library; gives you scaffold, appbar, text etc.
import 'package:provider/provider.dart'; // shares app state (like settings or user preferences)
import 'settings_provider.dart';
import 'home_page.dart'; 
import 'settings_page.dart';
import 'use_location_page.dart';
import 'search_by_district_page.dart';
import 'search_by_material_page.dart';
import 'send_picture_page.dart';
import 'picture_sent_page.dart';

void main() { // the main entry point
  runApp(
    ChangeNotifierProvider( // makes settings provider available to entire widget tree, and automatically changes
      create: (_) => SettingsProvider(), 
      child: CentralaApp(), // start the app with CentralaApp, but wrap it in a provider so everything inside can access SettingsProvider
    ),
  );
}

class CentralaApp extends StatelessWidget { // inherits the stateless widget parent
  const CentralaApp({Key? key}) : super(key: key); // // optional key to uniquely identify this widget; passed to parent class
  @override 
  Widget build(BuildContext context) {
    return MaterialApp( // building the actual app UI
      title: 'Centrala Recycling',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      builder: (context, child) => child!, // allows all routes to work
      initialRoute: '/', // optional, but helps clarity
      routes: { // a map of named routes
        '/': (context) => HomePage(),
        '/settings': (context) => SettingsPage(),
        '/use-location': (context) => UseLocationPage(),
        '/search-district': (context) => SearchByDistrictPage(),
        '/search-material': (context) => SearchByMaterialPage(),
        '/send-picture': (context) => SendPicturePage(),
        '/picture-sent': (context) => PictureSentPage(),
      },
    );
  }
}

