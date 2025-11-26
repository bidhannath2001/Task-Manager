import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management/UI/screens/forget_password_otp_verify.dart';
import 'package:task_management/UI/screens/login_page.dart';
import 'package:task_management/UI/widgets/screen_background.dart';

class ForgetPasswordEmailVerify extends StatelessWidget {
  const ForgetPasswordEmailVerify({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 150,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Your Email Address",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "A 6 digit verificaiton pin will be sent to your email address",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              TextFormField(
                  decoration: const InputDecoration(
                hintText: "Email",
              )),
              const SizedBox(
                height: 25,
              ),
              FilledButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ForgetPasswordOtpVerify()));
                  },
                  child: const Icon(Icons.arrow_forward_ios_rounded)),
              const SizedBox(height: 35),
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: "Sign in",
                      style: const TextStyle(color: Colors.green),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
