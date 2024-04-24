import 'package:flutter/material.dart';
import 'main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CurrentLocDate(),
            CurrentWeatherSection(),
            DailyTips(),
            Expanded(child: WeeklyForecastList()),
          ],
        ),
      ),

    );
  }
}



class CurrentLocDate extends StatefulWidget {
  const CurrentLocDate({super.key});

  @override
  State<CurrentLocDate> createState() => _CurrentLocDateState();
}

class _CurrentLocDateState extends State<CurrentLocDate> {
  String _currentLocation = 'Fetching location...';
  Map<String, int> regionCodes = {
    'Andaman and Nicobar Islands': 1484,
    'Andhra Pradesh': 1485,
    'Assam': 1487,
    'Delhi': 1489,
    'Goa': 1490,
    'Gujarat': 1491,
    'Haryana': 1492,
    'Himachal Pradesh': 1493,
    'Karnataka': 1494,
    'Kerala': 1495,
    'Lakshadweep': 1496,
    'Maharashtra': 1498,
    'Manipur': 1500,
    'Meghalaya': 1501,
    'Mizoram': 1502,
    'Nagaland': 1503,
    'Orissa': 1504,
    'Punjab': 1505,
    'Rajasthan': 1506,
    'Sikkim': 1507,
    'Tamil Nadu': 1508,
    'Tripura': 1509,
    'West Bengal': 1511,
    'Arunachal Pradesh': 70072,
    'Bihar': 70073,
    'Chandigarh': 70074,
    'Chhattisgarh': 70075,
    'Dadra and Nagar Haveli': 70076,
    'Daman and Diu': 70077,
    'Jharkhand': 70078,
    'Madhya Pradesh': 70079,
    'Puducherry': 70080,
    'Uttar Pradesh': 70081,
    'Uttarakhand': 70082,
    'Telangana': 1485, // Note: Telangana has the same code as Andhra Pradesh.
  };
  @override
  void initState() {
    super.initState();
    _determinePosition();

  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _currentLocation = 'Location services are disabled.';
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _currentLocation = 'Location permissions are denied';
        });
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      setState(() {
        _currentLocation = 'Location permissions are permanently denied, we cannot request permissions.';
      });
      return;
    }
    // When we reach here, permissions are granted and we can continue accessing the device's location.
    Position position = await Geolocator.getCurrentPosition();
    try {
      // Use the geocoding package for reverse geocoding
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      // print(place) ;
      setState(() {
        _currentLocation = '${place.administrativeArea}';
      });
    } catch (e) {
      setState(() {
        _currentLocation = "Failed to get location";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.black),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  collectionName,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class CurrentWeatherSection extends StatelessWidget {
  const CurrentWeatherSection({super.key});
  String determineLevel(String s) {
    // Convert the input string to an integer for comparison
    int value = int.tryParse(s) ?? 0;

    if (value >= 0 && value <= 40) {
      return "Low";
    } else if (value > 40 && value <= 70) {
      return "Moderate";
    } else {
      return "High";
    }
  }



  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    var _currentDateTime = DateFormat.yMMMMd('en_US').add_jm().format(now);
    // DateTime now = DateTime.now();

    int year = now.year;
    int month = now.month;
    int day = now.day;
    // For hours in 24-hour format, you can use the `hour` property directly.
    int hours = now.hour;
    int minutes = now.minute;


    // Printing each component to check
    // print("Year: $year");
    // print("Month: $month");
    // print("Day: $day");
    // print("Time: $hours:$minutes");
    var s = data[0]["humidity"][hours].toStringAsFixed(0);
    // var s = '77.5';
    String comfort = determineLevel(s);


    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(

        color: Colors.blueAccent,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        // border: Border.all(
        //   color: Colors.white, // Color of the border
        //   width: 8.0, // Width of the border
        // ),
      ),
      child: Column(
        children: [
          Text(
            _currentDateTime,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.energy_savings_leaf, color: Colors.white),
              const SizedBox(width: 5),
              Text(
                'Comfort level: '+comfort,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.water_drop, color: Colors.white),
              const SizedBox(width: 5),
              Text(
                'Humidity: '+s+'%',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Icon(Icons.thermostat, color: Colors.white,size: 100,),
              const SizedBox(height: 10),
              Text(

                '28',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white,fontSize: 70),

              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DailyTips extends StatelessWidget {
  const DailyTips({super.key});

  @override
  Widget build(BuildContext context) {
    // This would be where your list of weekly forecasts goes
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 16.0,top: 16.0,bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration:BoxDecoration(

        color: Colors.white54,
        border: Border.all(
          width: 2 ,
          color: Colors.black ,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),

      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Today's Temperature",
              ),


            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Almost as same as Yesterday",
              ),

            ],
          ),

        ],
      ),

    );
  }
}

class WeeklyForecastList extends StatelessWidget {
  const WeeklyForecastList({super.key});

  @override
  Widget build(BuildContext context) {
    // This would be where your list of weekly forecasts goes
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 16.0,top: 16.0,bottom: 32),
      padding: const EdgeInsets.all(16.0),
      decoration:BoxDecoration(

        color: Colors.white54,
        border: Border.all(
          width: 2 ,
          color: Colors.black ,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),

      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Yesterday",
              ),
              Text("Today"),
              Text("Monday"),
              Text("Tuesday"),
              Text("Wednesday"),
              Text("Thursday"),
              Text("Friday"),

            ],
          ),
          SizedBox(width: 20,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Moderate",
              ),
              Text("Moderate"),
              Text("Moderate"),
              Text("Moderate"),
              Text("Moderate"),
              Text("Low"),

              Text("Moderate"),
            ],
          ),

        ],
      ),

    );
  }
}
