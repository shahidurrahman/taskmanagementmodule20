import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmanagement/project/data/models/user_model.dart';
import 'package:taskmanagement/project/data/services/api_caller.dart';
import 'package:taskmanagement/project/data/utils/urls.dart';
import 'package:taskmanagement/project/ui/controller/auth_controller.dart';
import 'package:taskmanagement/project/ui/weights/photo_picker.dart';
import 'package:taskmanagement/project/ui/weights/screen_background.dart';
import 'package:taskmanagement/project/ui/weights/snack_bar.dart';
import 'package:taskmanagement/project/ui/weights/tm_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserModel user = AuthController.userModel!;
    emailController.text = user.email;
    firstNameController.text = user.firstName;
    lastNameController.text = user.lastName;
    mobileController.text = user.mobile;
  }

  Future<void> _pickImage() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );
    if (image != null) {
      _selectedImage = image;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const SizedBox(height: 50),
                Text(
                  'Update Profile',
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                photo_picker(onTap: _pickImage, selectedPhoto: _selectedImage),

                const SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(hintText: 'Email'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter your email';
                    }

                    final emailRegExp = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );

                    if (!emailRegExp.hasMatch(value)) {
                      return 'Please enter valid email';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(hintText: 'First Name'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter your first name';
                    }

                    if (value.trim().length < 2) {
                      return 'First name must be at least 2 cha';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(hintText: 'Last Name'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter your last name';
                    }

                    if (value.trim().length < 2) {
                      return 'last name must be at least 2 cha';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: mobileController,
                  decoration: InputDecoration(hintText: 'Mobile No'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter your mobile number';
                    }

                    if (value.trim().length != 11) {
                      return 'Enter valid phone number';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(hintText: 'Password'),
                    validator: (String? value) {
                      if ((value != null && value.isNotEmpty) && value.length < 6) {
                        return 'Enter a password more than 6 letters';
                      }

                      return null;
                    },
                ),
                const SizedBox(height: 16),

                FilledButton(
                  onPressed: () {
                    // if(_formKey.currentState!.validate()){
                    //   _signUp();
                    // }

                    if (_formkey.currentState!.validate()) {
                      updateProfile();

                    }
                  },
                  child: Icon(Icons.arrow_circle_right_outlined),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isloding = false;
  Future<void> updateProfile() async {
    bool isloding = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "email": emailController.text,
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "mobile": mobileController.text,
    };
    if (passwordController.text.isNotEmpty) {
      requestBody['password'] = passwordController.text;
    }

    String? encodedPhoto;

    if (_selectedImage != null) {
      List<int> bytes = await _selectedImage!.readAsBytes();
      encodedPhoto = jsonEncode(bytes);
      requestBody['photo'] = encodedPhoto;
    }
    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.updateProfileUrl,
      body: requestBody,
    );
    isloding = false;
    setState(() {});
    if (response.isSuccess) {
      UserModel model1 = UserModel(
        id: AuthController.userModel!.id,
        email: emailController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        mobile: mobileController.text,
        photo: encodedPhoto ?? AuthController.userModel!.photo,
      );
      AuthController.updateUserData(model1);
      showSnackBarMessage(context, 'Profile Update');
    }else {
      showSnackBarMessage(context, response.errorMessage!);

    }
  }
}
