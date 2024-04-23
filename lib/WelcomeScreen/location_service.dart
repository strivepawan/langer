import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  static Future<String> getCurrentCity() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      // Retrieve placemarks for the given coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);

      // Extract city name from the first placemark
      String cityName = placemarks[0].locality ?? 'Unknown City';

      // Return the city name
      return cityName;
    } on PlatformException catch (e) {
      print('Error fetching location: $e');
      return 'Location error';
    } catch (e) {
      print('General error: $e');
      return 'Error fetching location';
    }
  }
}
