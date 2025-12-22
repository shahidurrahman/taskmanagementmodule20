import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taskmanagement/project/ui/screen/forget_password_verify_otp.dart';
import 'package:taskmanagement/project/ui/screen/reset_password_screen.dart';
import 'package:taskmanagement/project/ui/weights/screen_background.dart';

class ForgetPasswordVerifyOtp extends StatelessWidget {
  const ForgetPasswordVerifyOtp({super.key});

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
              'PIN Verification',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 10),
            Text(
                'A 6 digits OTP sent to your email address',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(

                    color: Colors.grey
                )
            ),
            const SizedBox(height: 10),
            // PinCodeTextField(
            //
            //   length: 6,
            //   keyboardType: TextInputType.number,
            //   obscureText: false,
            //   animationType: AnimationType.fade,
            //   pinTheme: PinTheme(
            //     shape: PinCodeFieldShape.box,
            //     borderRadius: BorderRadius.circular(7),
            //     fieldHeight: 50,
            //     fieldWidth: 40,
            //     activeFillColor: Colors.white,
            //     inactiveColor: Colors.grey.shade300,
            //     selectedColor: Colors.green
            //   ),
            //   animationDuration: Duration(milliseconds: 300),
            //   backgroundColor: Colors.transparent,
            //   enableActiveFill: true,
            //   appContext: context,

            PinCodeTextField(
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(7),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  inactiveColor: Colors.grey.shade300,
                  selectedColor: Colors.green
              ),
              animationDuration: Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              appContext: context,




            ),
            const SizedBox(height: 16),

            FilledButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPasswordScreen()));

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
