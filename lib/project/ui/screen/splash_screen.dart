import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement/project/ui/controller/auth_controller.dart';
import 'package:taskmanagement/providers/auth_provider.dart';

import '../util/asset_paths.dart';
import '../weights/screen_background.dart';
import 'login_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    final authProvider = Provider.of<AuthProvider>(context,listen: false);

    await authProvider.loadUserData();

    if(authProvider.isLoggedIn){
      Navigator.pushReplacementNamed(context, '/NavBar');
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground
          (child: Center(child: SvgPicture.asset(AssetPaths.logoSVG, height: 200))),

      );

  }
}
