

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement/providers/auth_provider.dart';
import 'package:taskmanagement/providers/network_provider.dart';
import 'package:taskmanagement/providers/task_provider.dart';

import 'app.dart';

void  main(){
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_)=> AuthProvider()),
        ChangeNotifierProvider(create: (_)=> NetworkProvider()),
        ChangeNotifierProvider(create: (_)=> TaskProvider())
      ],
      child: TaskManagement(),
      )



  );

}