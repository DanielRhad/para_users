import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart'  as fStorage;
import 'package:para_users/Authentications/login_screen.dart';
import 'package:para_users/Widgets/error_dialog.dart';
import 'package:para_users/Widgets/progress_dialog.dart';
import 'package:para_users/globals/global.dart';
import 'package:shared_preferences/shared_preferences.dart';




class SignUpScreen extends StatefulWidget
{
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}



class _SignUpScreenState extends State<SignUpScreen>
{


  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  String userImageUrl = "";




  Future<void> _getImage(ImageSource source) async
  {
    imageXFile = await _picker.pickImage(source: source);

    setState(() {
      imageXFile;
    });
  }

  void showPhotoOption()
  {
    showDialog(context: context, builder: (context)
    {
      return AlertDialog(
        title: Text("Upload Profile Picture"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: ()
              {
                Navigator.pop(context);
                _getImage(ImageSource.gallery);
              },
              leading: Icon(Icons.photo_album),
              title: Text(
                  "Select From Gallery"
              ),
            ),
            ListTile(
              onTap: ()
              {
                Navigator.pop(context);
                _getImage(ImageSource.camera);
              },
              leading: Icon(Icons.camera_alt),
              title: Text(
                  "Take a picture"
              ),
            )
          ],
        ),
      );
    });
  }


  Future<void> saveUserDataToFireStore(User firebaseUser) async
  {
    if(firebaseUser != null)
    {
      Map userMap =
      {
        "id": firebaseUser.uid,
        "name": firebaseUser.displayName,
        "email": firebaseUser.email,
        "userImageUrl": firebaseUser.photoURL,
      };

      DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");
      usersRef.child(firebaseUser.uid).set(userMap);

      FirebaseFirestore.instance.collection("users").doc(firebaseUser.uid).set({
        "userUid": firebaseUser.uid,
        "userEmail": firebaseUser. displayName,
        "userName": firebaseUser.email,
        "userPhotoUrl": firebaseUser.photoURL,
        "status": "approved",
      });

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been Created.");
      Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been Created.");
    }
  }


  validateForm() async
  {
    if(imageXFile == null)
    {
      showDialog(
          context: context,
          builder: (c)
          {
            return ErrorDialog(
              message: "Please select an image.",
            );
          }
      );
    }
    else if(nameTextEditingController.text.length < 3)
    {
      Fluttertoast.showToast(msg: "name must be at least 3 Characters.");
    }
    else if(!emailTextEditingController.text.contains("@"))
    {
      Fluttertoast.showToast(msg: "Email address is not Valid.");
    }
    else if(passwordTextEditingController.text.length < 6)
    {
      Fluttertoast.showToast(msg: "Password must be at least 6 Characters.");
    }
    else
    {
      saveUserInfoNow();
    }
  }


  saveUserInfoNow() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: "Processing, Please wait...",);
        }
    );

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    fStorage.Reference reference = fStorage.FirebaseStorage.instance.ref().child("users").child(fileName);
    fStorage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));
    fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    await taskSnapshot.ref.getDownloadURL().then((url) {
      userImageUrl = url;
    });

    final User? firebaseUser = (
        await fAuth.createUserWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error Occurred, Please input correct email and password.");
        })
    ).user;

    if(firebaseUser != null)
    {
      Map userMap =
      {
        "id": firebaseUser.uid,
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "userImageUrl": userImageUrl,
      };

      DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");
      usersRef.child(firebaseUser.uid).set(userMap);

      FirebaseFirestore.instance.collection("users").doc(firebaseUser.uid).set({
        "userUid": firebaseUser.uid,
        "userEmail": emailTextEditingController.text.trim(),
        "userName": nameTextEditingController.text.trim(),
        "userPhotoUrl": userImageUrl,
        "status": "approved",
      });

      //save data locally
      sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences!.setString("uid", firebaseUser.uid);
      await sharedPreferences!.setString("email", emailTextEditingController.text.trim());
      await sharedPreferences!.setString("name", nameTextEditingController.text.trim());
      await sharedPreferences!.setString("photoUrl", userImageUrl);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been Created.");
      Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been Created.");
    }
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

              const SizedBox(height: 70,),

              const Text(
                "Register as a User",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.lightGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40,),

              InkWell(
                onTap: ()
                {
                  showPhotoOption();
                },
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.20,
                  backgroundColor: Colors.grey,
                  backgroundImage: imageXFile == null ? null : FileImage(File(imageXFile!.path)),
                  child: imageXFile == null
                      ?
                  Icon(
                      Icons.add_a_photo_outlined,
                      size: MediaQuery.of(context).size.width * 0.20,
                      color: Colors.white
                  ) : null,

                ),
              ),

              const SizedBox(height: 15,),

              TextField(
                controller: nameTextEditingController,
                style: const TextStyle(
                    color: Colors.black
                ),
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Name",
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

              const SizedBox(height: 20,),

              ElevatedButton(
                onPressed: ()
                {
                  validateForm();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                ),
                child: const Text(
                  "Create Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),

              const SizedBox(height: 20,),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                        color: Colors.grey[700]
                    ),
                  ),
                  const SizedBox(width: 4,),
                  TextButton(
                    child: const Text(
                      "Login here.",
                      style: TextStyle(
                          color: Colors.lightGreen,
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
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
