import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/curved_shape_widget.dart';
import '../../data/models/signup_model.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'widgets/custom_text_form_field.dart';
import 'login_screen.dart';
import 'widgets/having_account_widget.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    final paddingBottom = mediaQuery.viewInsets.bottom;

    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.blueColor.withOpacity(0.75),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: screenHeight -
                mediaQuery.padding.top -
                mediaQuery.padding.bottom,
          ),
          child: IntrinsicHeight(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: CurvedShapeWidget(
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.1),
                        Image.asset(
                          'assets/images/tennis-ball.png',
                          height: screenHeight * 0.1,
                          width: screenWidth * 0.2,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: screenWidth * 0.08,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.06,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.3),
                      CustomTextFormField(
                        controller: nameController,
                        labelText: 'Name',
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      CustomTextFormField(
                        controller: emailController,
                        labelText: 'Email',
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      CustomTextFormField(
                        controller: passwordController,
                        labelText: 'Password',
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is AuthSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Signup successful!')),
                            );
                          } else if (state is AuthError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return const CircularProgressIndicator();
                          }
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.xBlueColor.withOpacity(0.75),
                                  AppColors.xgreenColor.withOpacity(0.75),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                final signupModel = SignupModel(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                context.read<AuthCubit>().signUp(signupModel);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05,
                                  vertical: screenHeight * 0.02,
                                ),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.045,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      HavingAccountWidget(
                        screenWidth: screenWidth,
                        msgText: ' Already have an account? ',
                        buttonText: 'Login',
                        navTo: LoginScreen(),
                      ),
                      SizedBox(height: paddingBottom),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
