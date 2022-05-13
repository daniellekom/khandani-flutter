import 'package:auth/screens/home.dart';
import 'package:auth/utils/validators.dart';
import 'package:auth/widgets/our_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool isSignUp = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  void toggleSignUp() {
    setState(() {
      isSignUp = !isSignUp;
    });
  }

  Future<void> authenticate() async {
    try {
      if (!formKey.currentState!.validate()) return;
      if (isSignUp) {
        await signUp();
      } else {
        await signIn();
      }
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const HomeScreen()));
    } catch (e) {
      print('exception $e');
    }
  }

  Future<void> signUp() async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    if (credential.user != null) {
      await _firestore.collection('users').doc(credential.user!.uid).set({
        "email": emailController.text,
        "userId": credential.user!.uid,
        "created": DateTime.now().millisecondsSinceEpoch,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      });
    }
  }

  Future<void> signIn() async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    if (credential.user != null) {
      await _firestore.collection('users').doc(credential.user!.uid).update({
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final spacing = SizedBox(height: size.height * 0.02);
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      // appBar: AppBar(title: const Text('Auth'),),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.10),
                Image.asset('assets/images/logo.png'),
                spacing,
                spacing,
                OurTextField(
                    validate: Validator.email,
                    labelText: 'Email',
                    controller: emailController),
                spacing,
                OurTextField(
                  validate: Validator.password,
                  labelText: 'Password',
                  obscure: true,
                  controller: passwordController,
                ),
                spacing,
                AuthButton(isSignUp: isSignUp, onTap: authenticate),
                // const Spacer(),
                ToggleSignUpBtn(toggleSignUp: toggleSignUp, isSignUp: isSignUp)
              ],
            ),
          ),
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
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                isSignUp ? 'Sign in' : 'Sign Up',
                style: const TextStyle(
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
