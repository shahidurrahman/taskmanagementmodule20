import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement/project/ui/controller/auth_controller.dart';
import 'package:taskmanagement/project/ui/screen/update_profile_screen.dart';
import 'package:taskmanagement/providers/auth_provider.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userModel = authProvider.userModel;
    final profilePhoto = userModel?.photo ?? '';

    return AppBar(
      backgroundColor: Colors.green,
      title: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
          );
        },
        child: Row(
          children: [
            CircleAvatar(
              child: profilePhoto.isNotEmpty ?
              Image.memory(jsonDecode(profilePhoto)) : Icon(Icons.person),
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Text('${userModel!.firstName} ${userModel.lastName}',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: Colors.white),
                ),
                Text(
                  userModel.email,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            authProvider.logout();
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/Login',
              (predicate) => false,
            );
          },
          icon: Icon(Icons.logout),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
