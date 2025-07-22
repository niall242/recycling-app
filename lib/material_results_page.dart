// This page shows a list of districts for the specified material
// The material name is passed in as a required parameter so this page knows which material's data to show
// A button navigates back to the home screen


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart'; 
import 'widgets/page_header.dart'; 
import 'theme_colors.dart';


double scale(BuildContext context, double base) {
  return context.watch<SettingsProvider>().largeText ? base + 8 : base;
}

class MaterialResultsPage extends StatelessWidget {
  final String materialName;
  const MaterialResultsPage({super.key, required this.materialName});

  static const Map<String, List<String>> recyclingData = {
    "Erean": ["Glass", "Metal", "Paper/Cardboard", "Plastic (PET/E)", "Plastic (PVC)", "Plastic (HDPE)", "Small Household Electricals", "Garden Waste"],
    "Brunad": ["Glass", "Metal", "Paper/Cardboard", "Plastic (PET/E)", "Plastic (HDPE)", "Garden Waste"],
    "Bylyn": ["Glass", "Metal", "Paper/Cardboard", "Plastic (PET/E)", "Plastic (HDPE)", "Small Household Electricals", "Garden Waste"],
    "Docia": ["Glass", "Metal", "Paper/Cardboard", "Plastic (PET/E)", "Plastic (HDPE)", "Garden Waste"],
    "Marend": ["Glass", "Metal", "Paper/Cardboard", "Plastic (PET/E)", "Plastic (HDPE)", "Small Household Electricals", "Garden Waste"],
    "Pryn": ["Glass", "Metal", "Paper/Cardboard", "Plastic (PET/E)", "Plastic (HDPE)", "Small Household Electricals"],
    "Zord": ["Glass", "Metal", "Paper/Cardboard", "Plastic (PET/E)", "Plastic (PVC)", "Plastic (HDPE)", "Plastic (PP)", "Garden Waste"],
    "Yaean": ["Glass", "Metal", "Paper/Cardboard", "Plastic (PET/E)", "Plastic (PVC)", "Plastic (HDPE)", "Plastic (PP)"],
    "Frestin": ["Glass", "Metal", "Paper/Cardboard", "Plastic (PET/E)", "Plastic (PVC)", "Plastic (HDPE)", "Plastic (PP)", "Garden Waste"],
    "Stonyam": ["Glass", "Metal", "Paper/Cardboard", "Plastic (PET/E)", "Plastic (PVC)", "Plastic (HDPE)"],
    "Ryall": ["Glass", "Metal", "Paper/Cardboard", "Plastic (PET/E)", "Plastic (PVC)", "Plastic (HDPE)", "Garden Waste"],
    "Ruril": ["Glass", "Metal", "Paper/Cardboard", "Plastic (PET/E)", "Plastic (PVC)", "Plastic (HDPE)", "Garden Waste"],
  };

  List<String> getMatchingDistricts(String material) {
    return recyclingData.entries
        .where((entry) => entry.value.contains(material))
        .map((entry) => entry.key)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> districts = getMatchingDistricts(materialName);
    final settings = context.watch<SettingsProvider>();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageHeader(
                title: "Results",
                titleBackgroundColor: ThemeColors.material(context),
                titleTextColor: Colors.white,
                buttonIconColor: settings.highContrast ? Colors.white : Colors.black,
                buttonTextColor: settings.highContrast ? Colors.white : Colors.black,
                buttonBackgroundColor: ThemeColors.settings(context),
              ),


              Text(
                "You can recycle this material ($materialName) in the following districts:",
                style: TextStyle(fontSize: scale(context, 16)),
              ),
              const SizedBox(height: 16),

              // Grid of distrcit boxes
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 3.5,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        children: districts.map((district) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: ThemeColors.material(context),
                              // border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                district,
                                style: TextStyle(fontSize: scale(context, 16)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    // Return to home button
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: ThemeColors.material(context),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            "Return to home",
                            style: TextStyle(color: Colors.white, fontSize: scale(context, 16)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
