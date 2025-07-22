// This page is the first step in updating recycling details for a district
// conatins a description of what update is and a confrim button

import 'package:flutter/material.dart';
import 'update_details_page_2.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart'; 
import 'widgets/page_header.dart'; 
import 'theme_colors.dart';


double scale(BuildContext context, double base) {
  return context.watch<SettingsProvider>().largeText ? base + 8 : base;
}

const Map<String, List<String>> recyclingData = {
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

class UpdateDetailsPage1 extends StatelessWidget {
  final String districtName;

  const UpdateDetailsPage1({super.key, required this.districtName});

  @override
  Widget build(BuildContext context) {
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
                title: "Update details",
                titleBackgroundColor: ThemeColors.district(context),
                titleTextColor: Colors.white,
                buttonIconColor: settings.highContrast ? Colors.white : Colors.black,
                buttonTextColor: settings.highContrast ? Colors.white : Colors.black,
                buttonBackgroundColor: ThemeColors.settings(context),
              ),

              // Description
              Text(
                "We try to keep the records up to date, but if you think the recycling is wrong for that district, you can update the details:",
                style: TextStyle(fontSize: scale(context, 16)),
              ),
              const SizedBox(height: 32),

              // District update button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateDetailsPage2(
                        districtName: districtName,
                        initiallyAccepted: recyclingData[districtName] ?? [],
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ThemeColors.district(context),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "Update for $districtName",
                      style: TextStyle(
                        fontSize: scale(context, 18),
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
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
