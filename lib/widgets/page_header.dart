// A header template that can show/hide buttons.
// It is used on most pages.
// Accepts colors and styles for accessibility and theme.
// Maintains consistent spacing even when buttons are hidden.



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../settings_provider.dart';


double scale(BuildContext context, double base) {
  return context.watch<SettingsProvider>().largeText ? base + 8 : base;
}

class PageHeader extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final double? fontSize;
  final bool showBackButton;
  final bool showSettingsButton;
  final Color? titleTextColor;
  final Color? titleBackgroundColor;
  final Color? titleIconColor;
  final Color? buttonIconColor;
  final Color? buttonTextColor;
  final Color? buttonBackgroundColor;

  const PageHeader({
    Key? key,
    this.title,
    this.icon,
    this.fontSize,
    this.showBackButton = true,
    this.showSettingsButton = true,
    this.titleTextColor,
    this.titleBackgroundColor,
    this.titleIconColor,
    this.buttonIconColor,
    this.buttonTextColor,
    this.buttonBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top row with Go Back and Settings
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (showBackButton)
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: buttonBackgroundColor ?? Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, color: buttonIconColor ?? Colors.green),
                      const SizedBox(width: 8),
                      Text(
                        "Go back",
                        style: TextStyle(
                          fontSize: scale(context, 16),
                          color: buttonTextColor ?? Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              const SizedBox(width: 88), // reserve space for symmetry

            if (showSettingsButton)
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/settings'),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: buttonBackgroundColor ?? Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.settings, color: buttonIconColor ?? Colors.green),
                      const SizedBox(width: 8),
                      Text(
                        "Settings",
                        style: TextStyle(
                          fontSize: scale(context, 16),
                          color: buttonTextColor ?? Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              const SizedBox(width: 88),
          ],
        ),
        const SizedBox(height: 8),

        if (title != null)
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(top: 8, bottom: 24),
            decoration: BoxDecoration(
              color: titleBackgroundColor ?? Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                if (icon != null)
                  Icon(icon, size: 48, color: titleIconColor ?? Colors.green),
                if (icon != null) const SizedBox(width: 12),
                Flexible(
                  child: Center(
                    child: Text(
                      title!,
                      style: TextStyle(
                        fontSize: scale(context, fontSize ?? 28),
                        fontWeight: FontWeight.bold,
                        color: titleTextColor ?? Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
