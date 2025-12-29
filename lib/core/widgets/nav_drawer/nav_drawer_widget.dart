import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteflow/core/constants/app_colors.dart';
import 'package:noteflow/core/constants/app_strings.dart';
import 'package:noteflow/core/utils/utility.dart';
import 'package:noteflow/views/bmi/bmi_screen.dart';
import 'package:noteflow/views/home/home_screen.dart';
import 'package:noteflow/views/notes/notes_screen.dart';

class NavDrawerWidget extends StatelessWidget {
  final Function(Widget) onItemTap;

  const NavDrawerWidget({super.key, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: double.infinity,
      //height: double.infinity,
      color: AppColors.babyBlue,
      padding: const EdgeInsets.only(top: 50, left: 30),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/woman.png'),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                AppStrings.appName,
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(height: 50),

          RowScreenWidget(
            icon: Icons.home,
            text: 'Home',
            onTap: () => onItemTap(HomeScreen()),
          ),
          SizedBox(height: 20),
          RowScreenWidget(
            icon: Icons.note_alt_outlined,
            text: 'My Notes',
            onTap: () => onItemTap(NotesScreen()),
          ),
          SizedBox(height: 20),
          RowScreenWidget(
            icon: Icons.info_outline_sharp,
            text: 'BMI',
            onTap: () => onItemTap(BmiScreen()),
          ),
          SizedBox(height: 20),
          RowScreenWidget(
            icon: Icons.settings,
            text: 'Settings',
            onTap: () => onItemTap(HomeScreen()),
          ),
          SizedBox(height: 20),
          RowScreenWidget(
            icon: Icons.info_outline,
            text: 'About',
            onTap: () => onItemTap(Container()),
          ),
          SizedBox(height: 20),
          RowScreenWidget(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {
              Utility.showConfirmDialog(
                'Logout',
                'Are you sure want to logout?',
              );
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class RowScreenWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const RowScreenWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 10),
            Text(text, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
