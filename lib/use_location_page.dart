// A toggle to enable GPS simulation
// Permission handling with fallbacks
// Navigation to district results based on a random choice
// User guidance text

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart'; 
import 'district_results_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart'; 
import 'widgets/page_header.dart'; 
import 'theme_colors.dart';
import 'app_colors.dart';


double scale(BuildContext context, double base) {
  return context.watch<SettingsProvider>().largeText ? base + 8 : base;
}

class UseLocationPage extends StatefulWidget {
  const UseLocationPage({Key? key}) : super(key: key);
  @override
  _UseLocationPageState createState() => _UseLocationPageState();
}

class _UseLocationPageState extends State<UseLocationPage> {
  bool gpsEnabled = false;

  final List<String> districtList = [ 
    'Erean', 'Brunad', 'Bylyn', 'Docia',
    'Marend', 'Pryn', 'Zord', 'Yaean',
    'Frestin', 'Stonyam', 'Ryall', 'Ruril',
  ];

  Future<void> openDeviceSettings() async {
    const url = 'app-settings:';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to open settings"))
      );
    }
  }

  void simulateLocationAndNavigate() { // picks a random district when GPS is enabled
    if (gpsEnabled) {
      final randomDistrict = districtList[Random().nextInt(districtList.length)];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DistrictResultsPage(districtName: randomDistrict),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enable GPS first"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageHeader(
              title: "Use your location",
              titleBackgroundColor: ThemeColors.location(context),
              titleTextColor: Colors.white,
              buttonIconColor: settings.highContrast ? Colors.white : Colors.black,
              buttonTextColor: settings.highContrast ? Colors.white : Colors.black,
              buttonBackgroundColor: ThemeColors.settings(context),
              ),


              // GPS Toggle
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: AppColors.settings,
                  borderRadius: BorderRadius.circular(12),
                //  border: Border.all(color: Colors.black),
                ),
                child: Row(
                  children: [
                    Switch(
                      value: gpsEnabled,

                      onChanged: (value) async {
                        if (value) {
                          // Request permission
                          var status = await Permission.location.request();

                          if (status.isGranted) {
                            print("GPS permission granted.");
                            
                            // Open system GPS settings
                            bool opened = await Geolocator.openLocationSettings();
                            if (!opened) {
                              print("Failed to open location settings.");
                            }

                            setState(() {
                              gpsEnabled = true;
                            });

                          } else if (status.isPermanentlyDenied) {
                            // User has permanently denied permission, open app settings
                            await openAppSettings();
                          } else {
                            print("GPS permission denied.");
                          }
                        } else {
                          setState(() {
                            gpsEnabled = false;
                          });
                        }
                      },
                      activeColor: ThemeColors.mainTitleAlt(context), // thumb when on
                      activeTrackColor: ThemeColors.mainTitle(context), // track when on
                      inactiveThumbColor: Colors.black, // thumb when off
                      inactiveTrackColor: Colors.white, // track when off
                    ),
                    const SizedBox(width: 12),
                    Text("Turn on GPS", style: TextStyle(fontSize: scale(context, 16))),
                  ],
                ),
              ),

              // Search Button
              GestureDetector(
                onTap: simulateLocationAndNavigate,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ThemeColors.location(context),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "Search",
                      style: TextStyle(color: Colors.white, fontSize: scale(context, 16)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
