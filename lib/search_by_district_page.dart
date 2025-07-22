// A grid with 2 columns showing all districts as buttons.
// Each button is a GestureDetector that navigates to the district results page when tapped.
// Buttons have consistent theming, rounded corners, and scaled text to prevent overflow.

import 'package:flutter/material.dart';
import 'district_results_page.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart'; 
import 'widgets/page_header.dart'; 
import 'theme_colors.dart';


double scale(BuildContext context, double base) {
  return context.watch<SettingsProvider>().largeText ? base + 8 : base;
}


class SearchByDistrictPage extends StatelessWidget {
  
  SearchByDistrictPage({super.key});
  final List<String> districts = [
    "Brunad", "Bylyn", "Docia", "Erean", "Frestin", "Marend",
    "Pryn", "Ruril", "Ryall", "Stonyam", "Yaean", "Zord"
  ];

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
                title: "Search by district",
                titleBackgroundColor: ThemeColors.district(context),
                titleTextColor: Colors.white,
                buttonIconColor: settings.highContrast ? Colors.white : Colors.black,
                buttonTextColor: settings.highContrast ? Colors.white : Colors.black,
                buttonBackgroundColor: ThemeColors.settings(context),
              ),

              // Instruction text
              Text(
                "Choose your district below:",
                style: TextStyle(fontSize: scale(context, 20)),
              ),
              SizedBox(height: 16),

              // Grid of district buttons
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 3.5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: districts.map((district) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DistrictResultsPage(districtName: district),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ThemeColors.district(context),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            district,
                            style: TextStyle(fontSize: scale(context, 20), color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
