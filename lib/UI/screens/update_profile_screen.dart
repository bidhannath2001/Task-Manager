import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_management/UI/widgets/custom_appbar.dart';
import 'package:task_management/UI/widgets/image_picker.dart';
import 'package:task_management/UI/widgets/screen_background.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;
  Future<void>_pickImage()async{
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
    if(image!=null){
      _selectedImage = image;
      setState(() {

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Text(
                  "Update Profile",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                PhotoMaker(onTap: _pickImage,
                selectedImage: _selectedImage,),
                const SizedBox(height: 15),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'First name'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Last name'),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Mobile'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Password'),
                ),
                const SizedBox(
                  height: 16,
                ),
                FilledButton(
                    onPressed: () {},
                    child: const Icon(Icons.arrow_forward_ios_rounded)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
