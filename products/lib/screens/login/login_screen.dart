import 'package:flutter/material.dart';
import 'package:products/providers/login_provider.dart';
import 'package:products/routes/routes_app.dart';
import 'package:products/screens/screens.dart';
import 'package:products/widgets/card_container.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  //Parametes.

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //global variables.
    final loginForm = Provider.of<LoginProvider>(context);

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: LoginBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Icon(Icons.person_pin,
                  size: size.width * 0.25, color: Colors.white),
              SizedBox(height: size.height * 0.045),
              CardContainer(
                child: Column(
                  children: [
                    Text(
                      "Login",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(height: size.height * 0.02),
                    Container(
                      child: Form(
                        key: loginForm.loginFormKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            CustomInput(
                              hint: 'Carlos@gamil.com',
                              icon: Icons.alternate_email,
                              label: "Email",
                              onChanged: (value) => loginForm.email = value,
                              validator: (value) {
                                String pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{3,}))$';
                                RegExp regExp = RegExp(pattern);

                                return regExp.hasMatch(value ?? "")
                                    ? null
                                    : "The Email is not well";
                              },
                            ),
                            SizedBox(height: size.height * 0.02),
                            CustomInput(
                              hint: '********',
                              icon: Icons.lock,
                              isPassword: true,
                              label: "Password",
                              onChanged: (value) => loginForm.pass = value,
                              validator: (value) =>
                                  value != null && value.length >= 6
                                      ? null
                                      : "The password is not well",
                            ),
                            SizedBox(height: size.height * 0.03),
                            SizedBox(
                              width: double.infinity,
                              child: MaterialButton(
                                onPressed: loginForm.isLoading
                                    ? null
                                    : () async {
                                        FocusScope.of(context).unfocus();

                                        if (!loginForm.isValidForm()) return;

                                        loginForm.isLoading = true;

                                        await Future.delayed(
                                            const Duration(seconds: 2));
                                            
                                        loginForm.isLoading = false;

                                        // ignore: use_build_context_synchronously
                                        Navigator.pushReplacementNamed(
                                            context, RoutesApp.home);
                                      },
                                disabledColor: Colors.grey,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                color: Colors.deepPurple,
                                child: Text(
                                  !loginForm.isLoading
                                      ? "Login"
                                      : "Wait a second",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Create an Account",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, RoutesApp.home),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(63, 63, 156, 1),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomInput extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  const CustomInput({
    Key? key,
    required this.label,
    required this.hint,
    required this.icon,
    this.onChanged,
    this.isPassword = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      onChanged: onChanged,
      validator: validator,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.deepPurple,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.deepPurple,
            width: 2,
          ),
        ),
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(
          icon,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
