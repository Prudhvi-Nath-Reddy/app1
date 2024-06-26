

String befday(String startDate) {
  // Parse the start date string into a DateTime object
  DateTime start = DateTime.parse(startDate);
  // Calculate the day before the start date
  DateTime dayBefore = start.subtract(Duration(days: 1));
  // Format the DateTime object to a string in 'YYYY-MM-DD' format
  String formattedDate = "${dayBefore.year.toString().padLeft(4, '0')}-${dayBefore.month.toString().padLeft(2, '0')}-${dayBefore.day.toString().padLeft(2, '0')}";

  return formattedDate;
}
String nexday(String startDate) {
  // Parse the start date string into a DateTime object
  DateTime start = DateTime.parse(startDate);
  // Calculate the day before the start date
  DateTime dayBefore = start.add(Duration(days: 1));
  // Format the DateTime object to a string in 'YYYY-MM-DD' format
  String formattedDate = "${dayBefore.year.toString().padLeft(4, '0')}-${dayBefore.month.toString().padLeft(2, '0')}-${dayBefore.day.toString().padLeft(2, '0')}";

  return formattedDate;
}
String today()
{

  DateTime now = DateTime.now();

  // Format the date as 'YYYY-MM-DD'
  String tod = "${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
  return tod ;

}
class FavoriteLocation {
  final String cityName;
  final double temperature;
  final String comfortLevel;
  final double humidity;

  FavoriteLocation(
      {required this.cityName,
        required this.temperature,
        required this.comfortLevel,
        required this.humidity});
}
// class Singleton {
//   static final Singleton _singleton = Singleton._internal();
//
//   String mapurl2 = "https://harsha-deep.github.io/projects/gee-humidity/map1.html";
//   String bardate = today() ;
//   String prelev = "--.--" ;
//   List<FavoriteLocation> favoriteLocations =  [];
//   factory Singleton() {
//     return _singleton;
//   }
//
//   Singleton._internal();
// }
class Singleton {
  static final Singleton _singleton = Singleton._internal();

  List<FavoriteLocation> favoriteLocations = [];

  String mapurl2 = "https://harsha-deep.github.io/projects/gee-humidity/map1.html";
  String bardate = today(); // Ensuring today's date is captured
  String prelev = "--.--";

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal();

  // Add a location to the list
  void addLocation(FavoriteLocation location) {
    favoriteLocations.add(location);
  }

  // Remove a location from the list
  void removeLocation(int index) {
    if (index >= 0 && index < favoriteLocations.length) {
      favoriteLocations.removeAt(index);
    }
  }

  // Get all locations
  List<FavoriteLocation> getLocations() {
    return favoriteLocations;
  }
}


class gvars {
  static var mapurl = "https://harsha-deep.github.io/projects/gee-humidity/map1.html";
}

