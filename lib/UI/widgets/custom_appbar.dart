import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/UI/controller/auth_controller.dart';
import 'package:task_management/UI/screens/update_profile_screen.dart';
import 'package:task_management/providers/auth_provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userModel = authProvider.userModel;
    final profilePhoto = "";
    return AppBar(
      backgroundColor: Colors.green,
      title: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const UpdateProfileScreen())),
        child: Row(
          children: [
            CircleAvatar(
              child: profilePhoto.isNotEmpty
                  ? Image.memory(jsonDecode(profilePhoto))
                  : Icon(Icons.person),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${userModel!.firstName} ${userModel!.lastName}",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${userModel!.email}",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            )
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            authProvider.logout();
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          },
          icon: const Icon(Icons.logout),
          color: Colors.white,
        )
      ],
    );
  }
}
