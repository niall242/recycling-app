
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_recycling_app/settings_provider.dart';
import 'package:flutter_recycling_app/theme_colors.dart';
import 'package:flutter_recycling_app/use_location_page.dart';

void main() {
  group('SettingsProvider Tests', () {
    test('UT01 - toggleHighContrast sets highContrast to true', () {
      final provider = SettingsProvider();
      provider.toggleHighContrast(true);
      expect(provider.highContrast, true);
    });

    test('UT02 - toggleLargeText sets largeText to true', () {
      final provider = SettingsProvider();
      provider.toggleLargeText(true);
      expect(provider.largeText, true);
    });
  });

  group('ThemeColors Tests', () {
    testWidgets('UT03 - mainTitle returns correct color based on contrast', (tester) async {
      final provider = SettingsProvider();
      provider.toggleHighContrast(true);

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: provider,
          child: Builder(
            builder: (context) {
              final color = ThemeColors.mainTitle(context);
              expect(color, isNotNull); // checks we get a color back
              return Container();
            },
          ),
        ),
      );
    });
  });

  group('Scale Function Tests', () {
    testWidgets('UT04 - scale returns base+8 when largeText is true', (tester) async {
      final provider = SettingsProvider();
      provider.toggleLargeText(true);

      double result = 0.0;

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: provider,
          child: Builder(
            builder: (context) {
              result = scale(context, 16);
              return Container();
            },
          ),
        ),
      );

      expect(result, 24.0);
    });

    testWidgets('UT05 - scale returns base when largeText is false', (tester) async {
      final provider = SettingsProvider();
      provider.toggleLargeText(false);

      double result = 0.0;

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: provider,
          child: Builder(
            builder: (context) {
              result = scale(context, 16);
              return Container();
            },
          ),
        ),
      );

      expect(result, 16.0);
    });
  });
}
