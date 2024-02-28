import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:para_users/Models/trips_history_model.dart';

class HistoryDesignUIWidget extends StatefulWidget
{
  TripsHistoryModel? tripsHistoryModel;

  HistoryDesignUIWidget({this.tripsHistoryModel});




  @override
  State<HistoryDesignUIWidget> createState() => _HistoryDesignUIWidgetState();
}

class _HistoryDesignUIWidgetState extends State<HistoryDesignUIWidget>
{
  String formatDateAndTime(String dateTimeFromDB)
  {
    DateTime dateTime = DateTime.parse(dateTimeFromDB);

    String formattedDateTime = "${DateFormat.MMMd().format(dateTime)}, ${DateFormat.y().format(dateTime)} - ${DateFormat.jm().format(dateTime)}";

    return formattedDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //driver Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    "Driver : " + widget.tripsHistoryModel!.driverName!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),
                ),

                const SizedBox(width: 12,),

                Text(
                  "Php " + widget.tripsHistoryModel!.fareAmount!,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10,),

            Row(
              children: [
                const Icon(
                  Icons.electric_rickshaw_outlined,
                  color: Colors.black,
                  size: 27,
                ),

                const SizedBox(width: 12,),

                Text(
                  widget.tripsHistoryModel!.vehicle_details!,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30,),

            //pick up address
            Row(
              children: [
                Image.asset(
                  "images/origin.png",
                  height: 25,
                  width: 25,
                ),

                 const SizedBox(width: 12,),
                
                Expanded(
                  child: Container(
                    child: Text(
                      widget.tripsHistoryModel!.originAddress!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black

                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10,),

            //drop off address
            Row(
              children: [
                Image.asset(
                  "images/destination.png",
                  height: 25,
                  width: 25,
                ),

                const SizedBox(width: 12,),

                Expanded(
                  child: Container(
                    child: Text(
                      widget.tripsHistoryModel!.destinationAddress!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black

                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20,),

            // trip time
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(""),
                Text(
                  formatDateAndTime(widget.tripsHistoryModel!.time!),
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                  )
                ),
              ],
            ),

            const SizedBox(height: 5,),

          ],
        ),
      ),
    );
  }
}
