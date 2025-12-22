import 'package:flutter/material.dart';
import 'package:taskmanagement/project/ui/controller/auth_controller.dart';
import 'package:taskmanagement/project/ui/screen/update_profile_screen.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProfileScreen()));
        },
        child: Row(
          children: [
            CircleAvatar(),
            SizedBox(height: 8,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Shahidur Rahman',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white
        
                  ),
                ),
                Text('sa.rahman1991@gmail.com',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white
        
                  ),
                )
              ],
            )
          ],
        
        ),
      ),
      actions: [

        IconButton(onPressed: (){
          AuthController.clearUserData();
          Navigator.pushNamedAndRemoveUntil(context, '/Login', (predicate)=>false);

        }, icon: Icon(Icons.logout))
      ],

    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}