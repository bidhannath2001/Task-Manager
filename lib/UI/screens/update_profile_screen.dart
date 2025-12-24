import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_management/UI/controller/auth_controller.dart';
import 'package:task_management/UI/widgets/custom_appbar.dart';
import 'package:task_management/UI/widgets/image_picker.dart';
import 'package:task_management/UI/widgets/screen_background.dart';
import 'package:task_management/UI/widgets/snackbar.dart';
import 'package:task_management/data/models/user_model.dart';
import 'package:task_management/data/services/api_caller.dart';
import 'package:task_management/data/utils/urls.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;
  Future<void> _pickImage() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _selectedImage = image;
      setState(() {});
    }
  }

  @override
  initState() {
    super.initState();
    UserModel userData = AuthController.userModel!;
    _emailController.text = userData.email;
    _firstNameController.text = userData.firstName;
    _lastNameController.text = userData.lastName;
    _mobileController.text = userData.mobile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "Update Profile",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  PhotoMaker(
                    onTap: _pickImage,
                    selectedImage: _selectedImage,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(hintText: 'Email'),
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
                    height: 15,
                  ),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(hintText: 'First name'),
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
                    height: 16,
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(hintText: 'Last name'),
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
                    height: 15,
                  ),
                  TextFormField(
                    controller: _mobileController,
                    decoration: const InputDecoration(hintText: 'Mobile'),
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
                    height: 16,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(hintText: 'Password'),
                    validator: (value) {
                      if ((value != null && value.isNotEmpty) &&
                          value.length < 6) {
                        return "Please enter your password";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FilledButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              updateProfile();
                            }
                          },
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isLoading = false;
  Future<void> updateProfile() async {
    setState(() {
      _isLoading = true;
    });
    Map<String, dynamic> requestBody = {
      "email": _emailController.text,
      "firstName": _firstNameController.text,
      "lastName": _lastNameController.text,
      "mobile": _mobileController.text,
    };
    if (_passwordController.text.isNotEmpty) {
      requestBody["password"] = _passwordController.text;
    }
    String? encodedPhoto;
    if (_selectedImage != null) {
      List<int> imageBytes = await _selectedImage!.readAsBytes();
      encodedPhoto = jsonEncode(imageBytes);
      requestBody["photo"] = encodedPhoto;
    }

    ApiResponse response = await ApiCaller.postRequest(
        url: Urls.updateProfileUrl, body: requestBody);
    setState(() {
      _isLoading = false;
    });
    if (response.isSuccess) {
      UserModel model = UserModel(
          id: AuthController.userModel!.id,
          email: _emailController.text,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          mobile: _mobileController.text,
          photo: encodedPhoto ?? AuthController.userModel!.photo);
      AuthController.updateUserData(model);
      showSnackBarMessage(context, "Profile Updated");
    } else {
      showSnackBarMessage(context, response.errorMessage.toString());
    }
  }
}
