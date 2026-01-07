import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement/project/data/services/api_caller.dart';
import 'package:taskmanagement/project/data/utils/urls.dart';
import 'package:taskmanagement/project/ui/screen/forget_password_verify_otp.dart';
import 'package:taskmanagement/project/ui/weights/screen_background.dart';
import 'package:taskmanagement/providers/network_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

 class _SignUpScreenState  extends State<SignUpScreen > {
 
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
                crossAxisAlignment: CrossAxisAlignment.start,
              
                children: [
                  const SizedBox(height: 100),
                  Text(
                    'Join With Us',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
              
                  const SizedBox(height: 10),
                  TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(hintText: 'Email'),
                      validator: (String ? value){
                        if(value == null || value.isEmpty){
                        return 'please enter your email';
                        }
              
                        final emailRegExp = RegExp(  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              
                        if(!emailRegExp.hasMatch(value)){
                        return 'Please enter valid email';
                        }
              
                        return null;
                        },
              
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(hintText: 'First Name'),
                    validator: (String ? value){
                      if(value == null || value.isEmpty){
                        return 'please enter your first name';
                      }
              
                      if(value.trim().length < 2){
                        return 'First name must be at least 2 cha';
                      }
              
                      return null;
                    },
              
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(hintText: 'Last Name'),
                      validator: (String ? value){
                        if(value == null || value.isEmpty){
                        return 'please enter your last name';
                        }
              
                        if(value.trim().length < 2){
                        return 'last name must be at least 2 cha';
                        }
              
                        return null;
                        },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                      controller: _mobileController,
                      decoration: InputDecoration(hintText: 'Mobile No'),
                    validator: (String ? value){
                      if(value == null || value.isEmpty){
                        return 'please enter your mobile number';
                      }
              
                      if(value.trim().length != 11){
                        return 'Enter valid phone number';
                      }
              
                      return null;
                    },
              
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(hintText: 'Password'),
                    obscureText: true,
                    validator: (String ? value){
                      if(value == null || value.isEmpty){
                        return 'please enter your password';
                      }
              
                      if(value.length <= 6){
                        return 'Enter password more than 6';
                      }
              
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
              
                  Visibility(
                    visible: !_signUpInProgress ,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: FilledButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ForgetPasswordVerifyOtp(),
                        //   ),
                       // );
                        if(_formKey.currentState!.validate()){
                          _signUp();
                        }
                                  
                      },
                      child: Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
              
                  const SizedBox(height: 35),
                  Center(
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: ("Allready have an account ? "),
                            children: [
                              TextSpan(
                                text: ("Sign in"),
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
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
  _clearTextField(){
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _mobileController.clear();
    _passwordController.clear();
  }


  Future<void> _signUp()async{
    final networkProvider = Provider.of<NetworkProvider>(context,listen: false);

    final result = networkProvider.register(
        email: _emailController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        mobile: _mobileController.text.trim(),
        password: _passwordController.text.trim());

    if(result != null){
      _clearTextField();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign Up success..!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 5),
        ),

      );
      Navigator.pop(context);
    }else{

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(networkProvider.errorMessage ?? 'Something wrong'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),

      );
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


