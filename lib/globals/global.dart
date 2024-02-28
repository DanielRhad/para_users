import 'package:firebase_auth/firebase_auth.dart';
import 'package:para_users/Models/direction_details_info.dart';
import 'package:para_users/Models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';




final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
SharedPreferences? sharedPreferences;
UserModel? userModelCurrentInfo;
List dList = []; //online-active drivers Information List
DirectionDetailsInfo? tripDirectionDetailsInfo;
String? chosenDriverId="";
String cloudMessagingServerToken = "key=AAAAb5hkdPc:APA91bHMUsmsE-62RRpw86pGgV5CwD0VlWL2zeUv7V9Y4CIv6uzbKdJWC8Q3dC4gsw-ndr52HLma6AX65X90hVafp0gYfdfhk-e1H0_giyanblOujH3vqZFpPCWqtUZ45wTgbIBUWP5t";
String driverVehicleDetails = "";
String driverName = "";
String driverLocation = "";
String driverImageUrl = "";
double countRatingStars = 0.0;
String titleStarsRatings = "";
