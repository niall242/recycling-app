// This page shows recycling info for a specific district
// The district name is passed in as a required parameter so this page knows which district's data to show
// Fetches the list of materials for the district
// Displays the material name and its icon side by side
// A button navigates back to the home screen
// A button navigates to a page for updating details

import 'package:flutter/material.dart';
import 'update_details_page_1.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart';
import 'widgets/page_header.dart';
import 'theme_colors.dart';


double scale(BuildContext context, double base) {
  return context.watch<SettingsProvider>().largeText ? base + 8 : base;
}

class DistrictResultsPage extends StatelessWidget {
  final String districtName;

  const DistrictResultsPage({Key? key, required this.districtName}) : super(key: key);
  

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

  static const Map<String, String> materialIcons = {
    "Glass": 'assets/images/glass.png',
    "Metal": 'assets/images/metal.png',
    "Paper/Cardboard": 'assets/images/cardboard.png',
    "Plastic (PET/E)": 'assets/images/plasticPET-E.png',
    "Plastic (PVC)": 'assets/images/plasticPVC.png',
    "Plastic (HDPE)": 'assets/images/plasticHDPE.png',
    "Plastic (PP)": 'assets/images/plasticPP.png',
    "Small Household Electricals": 'assets/images/household1.png',
    "Garden Waste": 'assets/images/garden-waste.png',
  };

  @override
  Widget build(BuildContext context) {
    final List<String> materials = recyclingData[districtName] ?? [];
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
              Text(
                "Based on your district ($districtName), you can recycle the following:",
                style: TextStyle(fontSize: scale(context, 16)),
              ),
              const SizedBox(height: 16),

              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double maxWidth = constraints.maxWidth;
                    double itemWidth = (maxWidth - 12) / 2;

                    return SingleChildScrollView(
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: materials.map((material) {
                          return Container(
                            width: itemWidth,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: ThemeColors.district(context),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    material,
                                    style: TextStyle(fontSize: scale(context, 16)),
                                    softWrap: true,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Image.asset(
                                  materialIcons[material] ?? 'assets/images/default.png',
                                  width: 32,
                                  height: 32,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),

              GestureDetector(
                onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: ThemeColors.district(context),
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

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateDetailsPage1(districtName: districtName),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ThemeColors.informationWrong(context),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "Tap here if the information is wrong",
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
