import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Column(
          children: [
            CurrentLocDate(),
            CurrentWeatherSection(),
            DailyTips(),
            Expanded(child: WeeklyForecastList()),
          ],
        ),
      ),
      // BottomNavigationBar is now moved to MainPage, so it's commented out here
      /*bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Locations'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),*/
    );
  }
}





class CurrentLocDate extends StatelessWidget {
  const CurrentLocDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.black), // Location icon
          const SizedBox(width: 8), // Add space between the icon and the text
          Text(
            'Bangalore',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class CurrentWeatherSection extends StatelessWidget {
  const CurrentWeatherSection({super.key});

  @override
  Widget build(BuildContext context) {
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
            'March 12, 2024, 11:30 AM',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.energy_savings_leaf, color: Colors.white),
              const SizedBox(width: 5),
              Text(
                'Comfort level: Moderate',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.water_drop, color: Colors.white),
              const SizedBox(width: 5),
              Text(
                'Humidity: 28%',
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
                '27',
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