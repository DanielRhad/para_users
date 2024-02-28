import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:para_users/Authentications/signup_screen.dart';
import 'package:para_users/Widgets/login_dialog.dart';
import 'package:para_users/Widgets/progress_dialog.dart';
import 'package:para_users/globals/global.dart';
import 'package:para_users/splashScreen/splash_screen.dart';




class LoginScreen extends StatefulWidget
{

  @override
  _LoginScreenState createState() => _LoginScreenState();
}




class _LoginScreenState extends State<LoginScreen>
{

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();



  validateForm()
  {
    if(!emailTextEditingController.text.contains("@"))
    {
      Fluttertoast.showToast(msg: "Email address is not Valid.");
    }
    else if(passwordTextEditingController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Password is required.");
    }
    else
    {
      loginUserNow();
    }
  }

  loginUserNow() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: "Processing, Please wait...",);
        }
    );


    final User? firebaseUser = (
        await fAuth.signInWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error occurred, Please input correct email and password");
        })
    ).user;

    if(firebaseUser != null)
    {
      readDataAndSetDataLocally(firebaseUser);
      readDataAndSetDataUsingDatabase(firebaseUser);
    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occurred during Login.");
    }
  }

  Future readDataAndSetDataUsingDatabase(User firebaseUser) async
  {
    FirebaseDatabase.instance.ref()
        .child("users")
        .child(firebaseUser.uid)
        .get();

    Navigator.pop(context);
  }

  Future readDataAndSetDataLocally(User firebaseUser) async
  {
    await FirebaseFirestore.instance.collection("users")
        .doc(firebaseUser.uid)
        .get()
        .then((snapshot) async {
      if(snapshot.exists)
      {
        if(snapshot.data()!["status"] == "approved")
        {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
        }
        else
        {
          fAuth.signOut();
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (c)
              {
                return LoginDialog(
                    message: "Admin has Blocked your account, due to your recent violations"
                );
              }
          );
        }
      }
      else
      {
        Fluttertoast.showToast(msg: "No record exists with this email.");
        fAuth.signOut();
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  "images/1.gif",
                  width: 200,
                  height: 200,
                ),
              ),

              const SizedBox(height: 10,),

              const Text(
                "Login as a User",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.lightGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20,),

              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                    color: Colors.black
                ),
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Email",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 15,),

              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(
                    color: Colors.black
                ),
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "Password",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 50,),

              ElevatedButton(
                onPressed: () async
                {
                  validateForm();
                },

                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                  padding: EdgeInsets.symmetric(horizontal: 140, vertical: 15),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20,),




              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Do not have an account?",
                    style: TextStyle(
                        color: Colors.grey[700]
                    ),
                  ),
                  const SizedBox(width: 4,),
                  TextButton(
                    child: const Text(
                      "Register Now.",
                      style: TextStyle(
                          color: Colors.lightGreen,
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> SignUpScreen()));
                    },
                  ),
                ],
              ),



            ],
          ),
        ),
      ),
    );
  }
}
