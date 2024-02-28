import 'package:flutter/material.dart';
import 'package:para_users/Main%20Screens/main_screen.dart';

class AboutScreen extends StatefulWidget
{

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}



class _AboutScreenState extends State<AboutScreen>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          //image
          Container(
            height: 230,
            child: Center(
              child: Image.asset(
                "images/1.gif",
                width: 200,
                height: 200,
              ),
            ),
          ),

          const SizedBox(height: 10,),
          Column(
            children: [
              const Text(
                "\"Para\"",
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(height: 20,),

              const Text(
                "Para Ride Hailing App" + "\n" +
                "The answer to your transportation problem." + "\n" +
                "20M + people are already using this application",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,

                ),
              ),

              const SizedBox(height: 50,),

              ElevatedButton(
                  onPressed: ()
                  {
                    //MyApp.restartApp(context);
                    //Navigator.push(context, MaterialPageRoute(builder: (c)=> MainScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen,
                    padding: EdgeInsets.symmetric(horizontal: 76, vertical: 15),
                  ),
                  child: const Text(
                    "Rate this App",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  )
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
        ],
      ),
    );
  }
}
