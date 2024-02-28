import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:para_users/globals/global.dart';
import 'package:para_users/main.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

class RateDriverScreen extends StatefulWidget
{
  String? assignedDriverId;

  RateDriverScreen({this.assignedDriverId});


  @override
  State<RateDriverScreen> createState() => _RateDriverScreenState();
}

class _RateDriverScreenState extends State<RateDriverScreen>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        backgroundColor: Colors.green,
        child: Container(
          margin: const EdgeInsets.all(8),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const SizedBox(height: 22.0,),

              const Text(
                "Rate Trip Experience",
                style: TextStyle(
                  fontSize: 22,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 22.0,),

              const Divider(height: 4.0, thickness: 4.0,),

              const SizedBox(height: 22.0,),

              SmoothStarRating(
                rating: countRatingStars,
                allowHalfRating: false,
                starCount: 5,
                color: Colors.yellow,
                borderColor: Colors.black,
                size: 46,
                onRatingChanged: (valueOfStarsChose)
                {
                  countRatingStars = valueOfStarsChose;

                  if(countRatingStars == 1)
                  {
                    setState(() {
                      titleStarsRatings = "Very Bad";
                    });
                  }

                  if(countRatingStars == 2)
                  {
                    setState(() {
                      titleStarsRatings = "Bad";
                    });
                  }

                  if(countRatingStars == 3)
                  {
                    setState(() {
                      titleStarsRatings = "Good";
                    });
                  }

                  if(countRatingStars == 4)
                  {
                    setState(() {
                      titleStarsRatings = "Very Good";
                    });
                  }

                  if(countRatingStars == 5)
                  {
                    setState(() {
                      titleStarsRatings = "Excellent";
                    });
                  }
                },
              ),

              const SizedBox(height: 12.0,),

              Text(
                titleStarsRatings,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),

              const SizedBox(height: 18.0,),
              
              ElevatedButton(
                onPressed: ()
                {
                  DatabaseReference rateDriverRef = FirebaseDatabase.instance
                      .ref()
                      .child("drivers")
                      .child(widget.assignedDriverId!)
                      .child("ratings");

                  rateDriverRef.once().then((snap)
                  {
                    //
                    if(snap.snapshot.value == null)
                    {
                      rateDriverRef.set(countRatingStars.toString());


                      Future.delayed(const Duration(milliseconds: 4000), ()
                      {
                        MyApp.restartApp(context);
                      });
                    }
                    else
                    {
                      double pastRatings = double.parse(snap.snapshot.value.toString());
                      double newAverageRatings = (pastRatings + countRatingStars) / 2;
                      rateDriverRef.set(newAverageRatings.toString());

                      Future.delayed(const Duration(milliseconds: 4000), ()
                      {
                        MyApp.restartApp(context);
                      });
                    }
                    Fluttertoast.showToast(msg: "You have rate the driver Successfully");
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15,),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 10.0,),
            ],
          ),
        ),
      ),
    );
  }
}
