import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:noteflow/core/constants/app_strings.dart';
import 'package:noteflow/core/routes/routes_name.dart';
import 'package:noteflow/core/services/shared_preference/app_preference.dart';
import 'package:noteflow/core/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:noteflow/core/widgets/custom_button/animated_custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _State();
}

class _State extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        screenTitle: AppStrings.login,
        isDrawerOpen: false,
        onMenuTap: null,
        onBackTap: null,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                AppStrings.login,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: AppStrings.email,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: [
                          // for preventing space in text field
                          FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.enterEmail;
                          }
                          if (!GetUtils.isEmail(value)) {
                            return AppStrings.enterValidEmail;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      TextFormField(
                        controller: passwordController,
                        obscureText: obscurePassword,
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                        decoration: InputDecoration(
                          labelText: AppStrings.password,
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon:
                                obscurePassword
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                            onPressed:
                                () => setState(
                                  () => obscurePassword = !obscurePassword,
                                ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.enterPassword;
                          }
                          if (value.length < 6) {
                            return AppStrings.passwordLengthTooShort;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 50),
                      AnimatedCustomButton(
                        title: AppStrings.login,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await AppPreference.setLogin(true);
                            Get.offAndToNamed(RoutesName.homeScreen);
                            Get.snackbar(
                              'Login',
                              'Login Successful!',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                      ),
                    ],
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
