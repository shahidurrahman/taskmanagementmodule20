import 'package:flutter/material.dart';
import 'package:taskmanagement/project/ui/screen/forget_password_verify_otp.dart';
import 'package:taskmanagement/project/ui/weights/screen_background.dart';

class ForgetPasswordEmailVerify extends StatelessWidget {
  const ForgetPasswordEmailVerify({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ScreenBackground(child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 130),
            Text(
              'Your Email Address',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 10),
            Text(
              'A 6 digits OTP will be sent to your email address',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(

                color: Colors.grey
              )
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Email'
              ),
            ),
            const SizedBox(height: 16),

            FilledButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPasswordVerifyOtp()));
                
              },
              child: Icon(Icons.arrow_circle_right_outlined),
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



    );
  }
}
