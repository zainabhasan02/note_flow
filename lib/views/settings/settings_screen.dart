import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteflow/data/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theme',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 15),
            Consumer<ThemeProvider>(
              builder: (_, provider, __) {
                return SwitchListTile(
                  title: Text(
                    provider.getThemeValue()
                        ? 'Dark Mode Enabled'
                        : 'Light Mode Enabled',
                  ),
                  subtitle: Text('Change theme mode'),
                  value: provider.getThemeValue(),
                  onChanged: (value) {
                    provider.updateTheme(value: value);
                  },
                );
              },
            ),
            Text(
              'Localization',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
