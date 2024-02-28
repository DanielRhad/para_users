import 'package:flutter/material.dart';
import 'package:para_users/Main%20Screens/about_screen.dart';
import 'package:para_users/Main%20Screens/profile_screen.dart';
import 'package:para_users/Main%20Screens/trips_history_screen.dart';
import 'package:para_users/globals/global.dart';
import 'package:para_users/splashScreen/splash_screen.dart';



class MyDrawer extends StatefulWidget
{

  String? name;
  String? email;

  MyDrawer({this.name, this.email});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer>
{

  @override
  Widget build(BuildContext context)
  {
    return Drawer(
      child: ListView(
        children: [
          //drawer header
          Container(
            height: 120,
            color: Colors.grey,
            child: DrawerHeader(
              decoration: const  BoxDecoration(color: Colors.lightGreen),
              child: Column(
                children: [



                  const SizedBox(height: 20,),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.name.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10,),

                      Text(
                        widget.email.toString(),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
          // Add other Drawer items as needed

          const SizedBox(height: 12.0,),

          //drawer body
          GestureDetector(
            onTap: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> TripsHistoryScreen()));
            },
            child: const ListTile(
              leading: Icon(Icons.history, color: Colors.black,),
              title: Text(
                "History",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),

          const SizedBox(height: 15,),

          GestureDetector(
            onTap: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> ProfileScreen()));
            },
            child: const ListTile(
              leading: Icon(Icons.person_2_outlined, color: Colors.black,),
              title: Text(
                "Visit Profile",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),

          const SizedBox(height: 15,),

          GestureDetector(
            onTap: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> AboutScreen()));
            },
            child: const ListTile(
              leading: Icon(Icons.info_outline, color: Colors.black,),
              title: Text(
                "About",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),

          const SizedBox(height: 15,),

          GestureDetector(
            onTap: ()
            {
              fAuth.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
            },
            child: const ListTile(
              leading: Icon(Icons.logout, color: Colors.black,),
              title: Text(
                "Sign Out",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
