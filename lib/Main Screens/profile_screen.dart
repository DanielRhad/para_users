import 'package:flutter/material.dart';
import 'package:para_users/Main%20Screens/main_screen.dart';
import 'package:para_users/Widgets/info_design_ui.dart';
import 'package:para_users/globals/global.dart';
import 'package:para_users/main.dart';

class ProfileScreen extends StatefulWidget
{

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}



class _ProfileScreenState extends State<ProfileScreen>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              borderRadius: const BorderRadius.all(Radius.circular(80)),
              elevation: 10,
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.20,
                backgroundColor: Colors.white,
                child: Icon(
                    Icons.add_a_photo_outlined,
                    size: MediaQuery.of(context).size.width * 0.20,
                    color: Colors.grey
                ),
              ),
            ),


            const SizedBox(height: 40,),
            Text(
              userModelCurrentInfo!.name!,
              style: const TextStyle(
                fontSize: 50.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.black,
                thickness: 2,
              ),
            ),

            const SizedBox(height: 38.0,),

            InfoDesignUIWidget(
              textInfo: userModelCurrentInfo!.email!,
              iconData: Icons.email,
            ),

            const SizedBox(height: 20,),

            ElevatedButton(
                onPressed: ()
                {
                  //MyApp.restartApp(context);
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> MainScreen()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                ),
                child: const Text(
                  "Close",
                  style: TextStyle(
                    color: Colors.white
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
