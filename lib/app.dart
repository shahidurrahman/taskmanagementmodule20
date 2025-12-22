
import 'package:flutter/material.dart';
import 'package:taskmanagement/project/ui/screen/login_page.dart';
import 'package:taskmanagement/project/ui/screen/main_nav_bar_holder_screen.dart';
import 'package:taskmanagement/project/ui/screen/sign_up_screen.dart';
import 'package:taskmanagement/project/ui/screen/splash_screen.dart';
import 'package:taskmanagement/project/ui/screen/update_profile_screen.dart';
 class TaskManagement extends StatelessWidget {
   const TaskManagement({super.key});

   static GlobalKey <NavigatorState> navigator = GlobalKey<NavigatorState>();
 
   @override
   Widget build(BuildContext context) {
     return MaterialApp(

       theme: ThemeData(
         colorSchemeSeed: Colors.green,
         textTheme:TextTheme(
           titleLarge: TextStyle(
             fontSize: 28,
             fontWeight: FontWeight.w600,
           )

         ),

         inputDecorationTheme: InputDecorationTheme(
         fillColor: Colors.white,
         filled: true,
         hintStyle: TextStyle(color: Colors.grey),
         border: OutlineInputBorder(borderSide: BorderSide.none),
         enabledBorder: OutlineInputBorder(
           borderSide: BorderSide.none,
         ),
       ),
         
         filledButtonTheme: FilledButtonThemeData(
           
           style: FilledButton.styleFrom(
             
             backgroundColor: Colors.green,
             fixedSize: Size.fromWidth(double.maxFinite),
             padding: EdgeInsets.symmetric(vertical: 12),
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(8)
             )
           )
         )

       ),
      // home: SplashScreen(),
       initialRoute: '/SplashScreen',

       routes: {
         '/SplashScreen':(_) => SplashScreen(),
         '/Login': (_)=> LoginPage(),
         '/SignUp': (_)=> SignUpScreen(),
         '/NavBar': (_)=> MainNavBarHolderScreen(),
         '/updateProfile': (_)=> UpdateProfileScreen(),


       },


     );
   }
 }
 