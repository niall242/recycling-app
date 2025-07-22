// confirmation text and a return home button

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart';
import 'widgets/page_header.dart';  
import 'theme_colors.dart';


double scale(BuildContext context, double base) {
  return context.watch<SettingsProvider>().largeText ? base + 8 : base;
}

class DetailsSavedPage extends StatelessWidget {
  const DetailsSavedPage({super.key});

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
                buttonIconColor: settings.highContrast ? Colors.white : Colors.black,
                buttonTextColor: settings.highContrast ? Colors.white : Colors.black,
                buttonBackgroundColor: ThemeColors.settings(context),
              ),
              const SizedBox(height: 24), 


              // Confirmation text
              Center(
                child: Text(
                  "Details saved 👍",
                  style: TextStyle(fontSize: scale(context, 24)),
                ),
              ),
              const SizedBox(height: 48),

              // Return to home screen button
              GestureDetector(
                onTap: () {
                  Navigator.popUntil(context, ModalRoute.withName('/')); 
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ThemeColors.mainTitleAlt(context),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "Return to home screen",
                      style: TextStyle(fontSize: scale(context, 24), color: Colors.white),
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
