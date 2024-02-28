import 'package:flutter/material.dart';
import 'package:para_users/Main%20Screens/main_screen.dart';
import 'package:para_users/Widgets/history_design_ui.dart';
import 'package:para_users/infoHandler/app_info.dart';
import 'package:provider/provider.dart';

class TripsHistoryScreen extends StatefulWidget {

  @override
  State<TripsHistoryScreen> createState() => _TripsHistoryScreenState();
}



class _TripsHistoryScreenState extends State<TripsHistoryScreen>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Trips History"
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: ()
          {
            //MyApp.restartApp(context);
            Navigator.push(context, MaterialPageRoute(builder: (c)=> MainScreen()));
          },
        ),
      ),
      body: ListView.separated(
        separatorBuilder: (context, i)=> const Divider(
          color: Colors.black54,
          thickness: 2,
          height: 2,
        ),
        itemBuilder: (context, i)
        {
          return Card(
            child: HistoryDesignUIWidget(
              tripsHistoryModel: Provider.of<AppInfo>(context, listen: false).allTripsHistoryInformationList[i],
            ),
          );
        },
        itemCount: Provider.of<AppInfo>(context, listen: false).allTripsHistoryInformationList.length,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
      ),
    );
  }
}
