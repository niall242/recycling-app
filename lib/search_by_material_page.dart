// Two columns conatining all the materials
// Materials have their own icons, and are clicakble buttons
// Navigates to MaterialResultsPage on tap


import 'package:flutter/material.dart';
import 'material_results_page.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart'; 
import 'widgets/page_header.dart'; 
import 'theme_colors.dart';


double scale(BuildContext context, double base) {
  return context.watch<SettingsProvider>().largeText ? base + 8 : base;
}

class SearchByMaterialPage extends StatelessWidget {
  const SearchByMaterialPage({super.key});

  final List<Map<String, dynamic>> materials = const [
    {"name": "Glass", "image": 'assets/images/glass.png'},
    {"name": "Metal", "image": 'assets/images/metal.png'},
    {"name": "Paper/Cardboard", "image": 'assets/images/cardboard.png'},
    {"name": "Plastic (PET/E)", "image": 'assets/images/plasticPET-E.png'},
    {"name": "Plastic (PVC)", "image": 'assets/images/plasticPVC.png'},
    {"name": "Plastic (HDPE)", "image": 'assets/images/plasticHDPE.png'},
    {"name": "Plastic (PP)", "image": 'assets/images/plasticPP.png'},
    {
    "name": "Small Household Electricals",
    "image": 'assets/images/household1.png',
    "image2": 'assets/images/household2.png',
    },
    {"name": "Garden Waste", "image": 'assets/images/garden-waste.png'},
  ];

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
                title: "Search by material",
                titleBackgroundColor: ThemeColors.material(context),
                titleTextColor: Colors.white,
                buttonIconColor: settings.highContrast ? Colors.white : Colors.black,
                buttonTextColor: settings.highContrast ? Colors.white : Colors.black,
                buttonBackgroundColor: ThemeColors.settings(context),
              ),
              // Instruction text
              Text(
                "Choose your material below:",
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
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MaterialResultsPage(
                                    materialName: material["name"],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: itemWidth,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: ThemeColors.material(context),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      material["name"],
                                      style: TextStyle(fontSize: scale(context, 16)),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  material["name"] == "Small Household Electricals"
                                    ? Column(
                                        children: [
                                          Image.asset('assets/images/household1.png', width: 32, height: 32),
                                          SizedBox(height: 6),
                                          Image.asset('assets/images/household2.png', width: 32, height: 32),
                                        ],
                                      )
                                    : Image.asset(
                                        material["image"],
                                        width: 32,
                                        height: 32,
                                      ),
                                ],
                              ),


                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}