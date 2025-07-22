// a toggle button for large text
// a toggle button for high contrast

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart';
import 'widgets/page_header.dart'; 
import 'app_colors.dart';
import 'theme_colors.dart';


double scale(BuildContext context, double base) {
  return context.watch<SettingsProvider>().largeText ? base + 8 : base;
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageHeader(
                title: "Settings",
                showSettingsButton: false,
                titleBackgroundColor: ThemeColors.settings(context),
                titleTextColor: Colors.white,
                buttonIconColor: settings.highContrast ? Colors.white : Colors.black,
                buttonTextColor: settings.highContrast ? Colors.white : Colors.black,
                buttonBackgroundColor: ThemeColors.settings(context),
              ),
              Container (
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.settings,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Use large text",
                      style: TextStyle(fontSize: scale(context, 18)),
                    ),
                    Switch(
                      value: context.watch<SettingsProvider>().largeText,
                      onChanged: (value) {
                        context.read<SettingsProvider>().toggleLargeText(value);
                      },
                      activeColor: ThemeColors.mainTitleAlt(context), // thumb when on
                      activeTrackColor: ThemeColors.mainTitle(context), // track when on
                      inactiveThumbColor: Colors.black, // thumb when off
                      inactiveTrackColor: Colors.white, // track when off
                    ),

                  ],
                ),
              ),

              // High contrast toggle box
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.settings,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "High contrast mode",
                      style: TextStyle(fontSize: scale(context, 18)),
                    ),
                    Switch(
                      value: context.watch<SettingsProvider>().highContrast,
                      onChanged: (value) {
                        context.read<SettingsProvider>().toggleHighContrast(value);
                      },

                      activeColor: ThemeColors.mainTitleAlt(context), // thumb when on
                      activeTrackColor: ThemeColors.mainTitle(context), // track when on
                      inactiveThumbColor: Colors.black, // thumb when off
                      inactiveTrackColor: Colors.white, // track when off
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);  
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ThemeColors.mainTitleAlt(context),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "Save",
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
