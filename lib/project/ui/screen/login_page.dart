import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement/project/data/models/user_model.dart';
import 'package:taskmanagement/project/data/services/api_caller.dart';
import 'package:taskmanagement/project/data/utils/urls.dart';
import 'package:taskmanagement/project/ui/controller/auth_controller.dart';
import 'package:taskmanagement/project/ui/screen/forget_password_email_verify.dart';
import 'package:taskmanagement/project/ui/screen/main_nav_bar_holder_screen.dart';
import 'package:taskmanagement/project/ui/screen/sign_up_screen.dart';
import 'package:taskmanagement/project/ui/weights/screen_background.dart'
    hide ScreenBackground;
import 'package:taskmanagement/providers/auth_provider.dart';
import 'package:taskmanagement/providers/network_provider.dart';

import '../weights/screen_background.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signInProgress = false;

  @override
  Widget build(BuildContext context) {
    void _onTapSignUp() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUpScreen()),
      );
    }

    void _onTapForgetPassword() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ForgetPasswordEmailVerify()),
      );
    }

    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 130),
                  Text(
                    'Get Started With',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 25),
              
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(hintText: 'E-mail'),
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
                  SizedBox(height: 10),
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
              
                  const SizedBox(height: 20),
              
                  FilledButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                       _signIn();
                      }

                    },
                    child: Icon(Icons.arrow_circle_right_outlined),
                  ),
                  const SizedBox(height: 30),
              
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: _onTapForgetPassword,
                          child: Text('Forget Password ?'),
                        ),
              
                        RichText(
                          text: TextSpan(
                            text: ("Don't have account ? "),
                            children: [
                              TextSpan(
                                text: ("Sign up"),
                                style: TextStyle(color: Colors.green),
                                recognizer: TapGestureRecognizer()..onTap = _onTapSignUp,
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
    _passwordController.clear();
  }

  Future<void> _signIn()async{
    final networkProvider = Provider.of<NetworkProvider>(context,listen: false);
    final authProvider = Provider.of<AuthProvider>(context,listen: false);

    final result = await networkProvider.login(email: _emailController.text.trim(), password: _passwordController.text);

    if(result != null ){
      await authProvider.saveUserData(result['user'], result['token']);
      ApiCaller.accessToken = result['token'];

      _clearTextField();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login success..!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 5),
        ),

      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainNavBarHolderScreen()));
    }else{

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(networkProvider.errorMessage?? 'something wrong'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),

      );
    }
  }

    @override
    void dispose() {
      _emailController.dispose();
      _passwordController.dispose();
      super.dispose();
    }
}
