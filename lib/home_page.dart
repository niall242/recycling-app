// Builds the main screen with a header and a short description
// Displays four clickable boxes to navigate to different features
// Adapts colors and sizes based on theme and accessibility settings


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart';
import 'widgets/page_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'theme_colors.dart';


double scale(BuildContext context, double base) {
  return context.watch<SettingsProvider>().largeText ? base + 8 : base; 
  // this listens for changes to settings. If large text is on, it adds +8 to the font size. This is included in all app pages
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { // _ before class name makes it private to this file
  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageHeader(
                title: "Centrala Recycling",
                icon: Icons.recycling,
                showBackButton: false,
                titleBackgroundColor: ThemeColors.mainTitle(context),
                titleTextColor: Colors.white,
                titleIconColor: Colors.white,
                buttonIconColor: settings.highContrast ? Colors.white : Colors.black,
                buttonTextColor: settings.highContrast ? Colors.white : Colors.black,
                buttonBackgroundColor: ThemeColors.settings(context),
              ),

              Text(
                "Use this app to find out what you can recycle in your area",
                style: TextStyle(fontSize: scale(context, 16)),
              ),
              SizedBox(height: 24),
              buildClickableBox(context, "Use your location", Icon(Icons.my_location, color: ThemeColors.locationIcon(context), size: 32), '/use-location', ThemeColors.location(context),),
              buildClickableBox(context, "Search by district", Icon(Icons.maps_home_work, color: ThemeColors.districtIcon(context), size: 32), '/search-district', ThemeColors.district(context)),
              buildClickableBox(context, "Search by material", FaIcon(FontAwesomeIcons.bottleWater, color: ThemeColors.materialIcon(context), size: 32), '/search-material', ThemeColors.material(context)),
              buildClickableBox(context, "Send us a picture of the material if you are unsure what it is", Icon(Icons.camera_alt, color: ThemeColors.pictureIcon(context), size: 32), '/send-picture', ThemeColors.picture(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildClickableBox(BuildContext context, String label, Widget icon, String routeName, Color backgroundColor) {
    return GestureDetector(
      onTap: () {
        if (routeName.isNotEmpty) {
          Navigator.pushNamed(context, routeName);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor, // use the passed color
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row( // one side icon, one side text
          children: [
            icon,
            SizedBox(width: 24),
            Flexible(
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(fontSize: scale(context, 18), color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
