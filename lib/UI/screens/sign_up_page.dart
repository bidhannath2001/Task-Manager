import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/UI/screens/login_page.dart';
import 'package:task_management/UI/widgets/screen_background.dart';
import 'package:task_management/providers/network_provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signUpInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Join with us",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      final emailRegExp =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegExp.hasMatch(value)) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      hintText: "First Name",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your first name";
                      }
                      if (value.trim().length < 2) {
                        return "Please enter a valid first name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      hintText: "Last Name",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your last name";
                      }
                      if (value.trim().length < 2) {
                        return "Please enter a valid last name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _mobileController,
                    decoration: const InputDecoration(
                      hintText: "Mobile",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your mobile number";
                      }
                      if (value.trim().length != 11) {
                        return "Please enter a valid mobile number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      if (value.trim().length < 6) {
                        return "Please enter a valid password";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: !_signUpInProgress,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: FilledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _signUp();
                          }
                        },
                        child: const Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
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
        ),
      ),
    );
  }

  _clearForm() {
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _mobileController.clear();
    _passwordController.clear();
  }

  Future<void> _signUp() async {
    final networkProvider =
        Provider.of<NetworkProvider>(context, listen: false);
    final result = networkProvider.register(
        email: _emailController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        mobile: _mobileController.text.trim(),
        password: _passwordController.text);
    if (result != null) {
      _clearForm();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Successfully Registered'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(networkProvider.errorMessage ?? 'Registration Failed'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
