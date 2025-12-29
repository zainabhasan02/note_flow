import 'package:flutter/material.dart';
import 'package:noteflow/core/constants/app_strings.dart';
import 'package:noteflow/core/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:noteflow/core/widgets/nav_drawer/nav_drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 0.85;

  bool isDrawerOpen = false;

  Widget currentScreen = HomeScreen();

  void openDrawer() {
    setState(() {
      xOffset = 230;
      yOffset = 150;
      isDrawerOpen = true;
    });
  }

  void closeDrawer() {
    setState(() {
      xOffset = 0;
      yOffset = 0;
      isDrawerOpen = false;
    });
  }

  void navigateTo(Widget screen) {
    setState(() {
      currentScreen = screen;
    });
    //closeDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NavDrawerWidget(onItemTap: navigateTo),
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.translationValues(xOffset, yOffset, 0)
            ..scale(isDrawerOpen ? scaleFactor : 1.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0),
          ),
          child: Scaffold(
            appBar: CustomAppBarWidget(
              screenTitle: AppStrings.appName,
              isDrawerOpen: isDrawerOpen,
              onMenuTap: openDrawer,
              onBackTap: closeDrawer,
            ),
            body: currentScreen,
          ),
        ),
      ],
    );
    /*return AnimatedContainer(
      height: double.infinity,
      transform:
          Matrix4.translationValues(xOffset, yOffset, 0)
            ..scale(isDrawerOpen ? scaleFactor : 1.00)
            ..rotateZ(isDrawerOpen ? -50 : 0),
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius:
            isDrawerOpen ? BorderRadius.circular(40) : BorderRadius.circular(0),
      ),
      child: Scaffold(
        appBar: CustomAppBarWidget(
          screenTitle: AppStrings.homeScreen,
          isDrawerOpen: isDrawerOpen,
          onMenuTap:
              () => setState(() {
                xOffset = 230;
                yOffset = 150;
                isDrawerOpen = true;
              }),
          onBackTap:
              () => setState(() {
                xOffset = 0;
                yOffset = 0;
                isDrawerOpen = false;
              }),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              */ /*Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isDrawerOpen
                        ? GestureDetector(
                          child: Icon(Icons.arrow_back_ios),
                          onTap: () {
                            setState(() {
                              xOffset = 0;
                              yOffset = 0;
                              isDrawerOpen = false;
                            });
                          },
                        )
                        : GestureDetector(
                          child: Icon(Icons.menu),
                          onTap: () {
                            setState(() {
                              xOffset = 230;
                              yOffset = 150;
                              isDrawerOpen = true;
                            });
                          },
                        ),
                    Text(
                      AppStrings.homeScreen,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: AppColors.blackColor,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(),
                  ],
                ),
              ),*/ /*
              SizedBox(height: 40),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: AppColors.babyBlue,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Icon(Icons.note_alt_outlined, size: 50),
                              ),
                              Text('appName1', style: TextStyle(fontSize: 25)),
                            ],
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: AppColors.babyBlue,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Icon(Icons.ac_unit, size: 50),
                              ),
                              Text('appName2', style: TextStyle(fontSize: 25)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: AppColors.babyBlue,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Icon(Icons.note_alt_outlined, size: 50),
                              ),
                              Text('appName1', style: TextStyle(fontSize: 25)),
                            ],
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: AppColors.babyBlue,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Icon(Icons.ac_unit, size: 50),
                              ),
                              Text('appName2', style: TextStyle(fontSize: 25)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );*/
  }
}
