// A dynamic bridge between app’s color and the setting chosen by the user

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart';
import 'app_colors.dart';


class ThemeColors {
  static Color mainTitle(BuildContext context) =>
      context.watch<SettingsProvider>().highContrast
          ? AppColorsHighContrast.mainTitle
          : AppColors.mainTitle;

  static Color mainTitleAlt(BuildContext context) =>
      context.watch<SettingsProvider>().highContrast
          ? AppColorsHighContrast.mainTitleAlt
          : AppColors.mainTitleAlt;

  static Color location(BuildContext context) =>
      context.watch<SettingsProvider>().highContrast
          ? AppColorsHighContrast.location
          : AppColors.location;

  static Color locationIcon(BuildContext context) =>
      context.watch<SettingsProvider>().highContrast
          ? AppColorsHighContrast.locationIcon
          : AppColors.locationIcon;

  static Color district(BuildContext context) =>
      context.watch<SettingsProvider>().highContrast
          ? AppColorsHighContrast.district
          : AppColors.district;

  static Color districtIcon(BuildContext context) =>
      context.watch<SettingsProvider>().highContrast
          ? AppColorsHighContrast.districtIcon
          : AppColors.districtIcon;

  static Color material(BuildContext context) =>
      context.watch<SettingsProvider>().highContrast
          ? AppColorsHighContrast.material
          : AppColors.material;

  static Color materialIcon(BuildContext context) =>
      context.watch<SettingsProvider>().highContrast
          ? AppColorsHighContrast.materialIcon
          : AppColors.materialIcon;

  static Color picture(BuildContext context) =>
      context.watch<SettingsProvider>().highContrast
          ? AppColorsHighContrast.picture
          : AppColors.picture;

  static Color pictureIcon(BuildContext context) =>
      context.watch<SettingsProvider>().highContrast
          ? AppColorsHighContrast.pictureIcon
          : AppColors.pictureIcon;

  static Color settings(BuildContext context) =>
      context.watch<SettingsProvider>().highContrast
          ? AppColorsHighContrast.settings
          : AppColors.settings;

  static Color informationWrong(BuildContext context) =>
      context.watch<SettingsProvider>().highContrast
          ? AppColorsHighContrast.informationWrong
          : AppColors.informationWrong;
}
