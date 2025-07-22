// confirms picture sent
// some information on response time
// button back to home screen

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart'; 
import 'widgets/page_header.dart'; 
import 'theme_colors.dart';


double scale(BuildContext context, double base) {
  return context.watch<SettingsProvider>().largeText ? base + 8 : base;
}

class PictureSentPage extends StatelessWidget {
  const PictureSentPage({super.key});

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

              // Expanded wraps the message section to push the button to the bottom
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Picture sent 👍",
                      style: TextStyle(fontSize: scale(context, 24)),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Look out for an email from recycling@centrala.cea.com",
                      style: TextStyle(fontSize: scale(context, 18)),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "We try to respond within 5 working days",
                      style: TextStyle(fontSize: scale(context, 18)),
                    ),
                  ],
                ),
              ),

              // Return button pinned to bottom
              GestureDetector(
                onTap: () => Navigator.popUntil(context, ModalRoute.withName('/')),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ThemeColors.picture(context),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "Return to home screen",
                      style: TextStyle(color: Colors.white, fontSize: scale(context, 16)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
