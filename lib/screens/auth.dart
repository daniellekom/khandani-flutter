import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isSignUp = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  void toggleSignUp() {
    setState(() {
      isSignUp = !isSignUp;
    });
  }

  Future<void> authenticate() async {}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final spacing = SizedBox(height: size.height * 0.02);
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      // appBar: AppBar(title: const Text('Auth'),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.10),
            Image.asset('assets/images/logo.png'),
            Container(
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              height: size.height * 0.40,
              width: size.width * 0.90,
              child: Column(
                children: [
                  spacing,
                  OurTextField(labelText: 'Email', controller: emailController),
                  spacing,
                  OurTextField(
                    labelText: 'Password',
                    obscure: true,
                    controller: passwordController,
                  ),
                  spacing,
                  AuthButton(isSignUp: isSignUp, onTap: authenticate),
                  const Spacer(),
                  ToggleSignUpBtn(
                      toggleSignUp: toggleSignUp, isSignUp: isSignUp)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ToggleSignUpBtn extends StatelessWidget {
  final bool isSignUp;
  final void Function() toggleSignUp;
  const ToggleSignUpBtn({
    Key? key,
    required this.isSignUp,
    required this.toggleSignUp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toggleSignUp,
      child: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isSignUp
                    ? 'Already have an account?'
                    : 'Don\'t have an account? ',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                isSignUp ? 'Sign in' : 'Sign Up',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
    );
  }
}

class AuthButton extends StatelessWidget {
  final bool isSignUp;
  final void Function() onTap;
  const AuthButton({Key? key, required this.isSignUp, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(30),
        ),
        margin: const EdgeInsets.only(top: 16),
        child: Container(
          alignment: Alignment.center,
          // height: 60,
          // width: 350,
          height: size.height * 0.05,
          width: size.width * 0.75,
          child: Text(
            isSignUp ? 'Sign Up' : 'Sign In',
          ),
        ),
      ),
    );
  }
}

class OurTextField extends StatelessWidget {
  final String labelText;
  final bool obscure;
  final TextEditingController controller;
  const OurTextField({
    Key? key,
    required this.labelText,
    this.obscure = false,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.white)),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        obscureText: obscure,
        decoration: InputDecoration(
            border: InputBorder.none,
            labelText: labelText,
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
