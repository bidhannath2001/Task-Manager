import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_management/UI/widgets/screen_background.dart';

class ForgetPasswordOtpVerify extends StatefulWidget {
  const ForgetPasswordOtpVerify({super.key});

  @override
  State<ForgetPasswordOtpVerify> createState() =>
      _ForgetPasswordOtpVerifyState();
}

class _ForgetPasswordOtpVerifyState extends State<ForgetPasswordOtpVerify> {
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
                "PIN verification",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "A 6 digit verificaiton pin will be sent to your email address",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            PinCodeTextField(
              appContext: context,
              length: 6,
              keyboardType: TextInputType.number,
              backgroundColor: Colors.transparent,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                borderRadius: BorderRadius.circular(5),
                inactiveColor: Colors.green,
                selectedColor: Colors.blue,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            RichText(
              text: const TextSpan(
                  text: "Didn't receive the code? ",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: "RESEND", style: TextStyle(color: Colors.green))
                  ]),
            ),
            const SizedBox(height: 35),
            FilledButton(
              onPressed: () {},
              child: const Text(
                "VERIFY",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
