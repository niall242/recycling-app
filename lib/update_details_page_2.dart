// This page shows two lists side-by-side: Not Accepted and Accepted.
// Each material can be swiped left or right to move between lists.
// At the bottom, a Save button navigates to a confirmation page.

import 'package:flutter/material.dart';
import 'details_saved_page.dart';
import 'widgets/page_header.dart';
import 'package:provider/provider.dart';         
import 'settings_provider.dart';             
import 'theme_colors.dart';


double scale(BuildContext context, double base) {
  return base;
}

class UpdateDetailsPage2 extends StatefulWidget {
  final String districtName;
  final List<String> initiallyAccepted;

  const UpdateDetailsPage2({
    Key? key,
    required this.districtName,
    required this.initiallyAccepted,
  }) : super(key: key);

  @override
  State<UpdateDetailsPage2> createState() => _UpdateDetailsPage2State();
}

class _UpdateDetailsPage2State extends State<UpdateDetailsPage2> {
  late List<String> accepted;
  late List<String> notAccepted;

  final Map<String, dynamic> materialIcons = {
    "Glass": 'assets/images/glass.png',
    "Metal": 'assets/images/metal.png',
    "Paper/Cardboard": 'assets/images/cardboard.png',
    "Plastic (PET/E)": 'assets/images/plasticPET-E.png',
    "Plastic (PVC)": 'assets/images/plasticPVC.png',
    "Plastic (HDPE)": 'assets/images/plasticHDPE.png',
    "Plastic (PP)": 'assets/images/plasticPP.png',
    "Small Household Electricals": {
      "image1": 'assets/images/household1.png',
      "image2": 'assets/images/household2.png',
    },
    "Garden Waste": 'assets/images/garden-waste.png',
  };

  final List<String> allMaterials = [
    "Glass",
    "Metal",
    "Paper/Cardboard",
    "Plastic (PET/E)",
    "Plastic (PVC)",
    "Plastic (HDPE)",
    "Plastic (PP)",
    "Small Household Electricals",
    "Garden Waste",
  ];

  @override
  void initState() {
    super.initState();
    accepted = List.from(widget.initiallyAccepted);
    notAccepted = allMaterials.where((item) => !accepted.contains(item)).toList();
  }

  Widget buildSwipableItem(String material, bool isAcceptedList) {
    return Dismissible(
      key: ValueKey(material),
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        color: ThemeColors.mainTitleAlt(context),
        child: const Icon(Icons.check, color: Colors.white),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: ThemeColors.informationWrong(context),
        child: const Icon(Icons.cancel, color: Colors.white),
      ),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        setState(() {
          if (isAcceptedList) {
            accepted.remove(material);
            if (!notAccepted.contains(material)) notAccepted.add(material);
          } else {
            notAccepted.remove(material);
            if (!accepted.contains(material)) accepted.add(material);
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3.5),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: ThemeColors.district(context),
          // border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Text(material, style: TextStyle(fontSize: scale(context, 14)))),
            const SizedBox(width: 8),
            material == "Small Household Electricals"
                ? Column(
                    children: [
                      Image.asset('assets/images/household1.png', width: 32, height: 32),
                      SizedBox(height: 6),
                      Image.asset('assets/images/household2.png', width: 32, height: 32),
                    ],
                  )
                : Image.asset(
                    materialIcons[material],
                    width: 32,
                    height: 32,
                  ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            children: [
              PageHeader(
                buttonIconColor: settings.highContrast ? Colors.white : Colors.black,
                buttonTextColor: settings.highContrast ? Colors.white : Colors.black,
                buttonBackgroundColor: ThemeColors.settings(context),
              ),
              Text(
                "Swipe left or right to move materials into or out of the Accepted list for your district (${widget.districtName})",
                style: TextStyle(fontSize: scale(context, 15)),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Row(
                  children: [
                    // Not Accepted
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          // color: AppColors.settings,
                          border: Border.all(color: Colors.grey, width: 2.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text("Not Accepted", style: TextStyle(fontSize: scale(context, 16), fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Expanded(
                              child: ListView(
                                children: notAccepted.map((m) => buildSwipableItem(m, false)).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Accepted
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: ThemeColors.mainTitleAlt(context), width: 2.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text("Accepted", style: TextStyle(fontSize: scale(context, 16), fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Expanded(
                              child: ListView(
                                children: accepted.map((m) => buildSwipableItem(m, true)).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DetailsSavedPage()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
