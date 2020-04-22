import 'package:geolocator/geolocator.dart';

class LocationService {
  Geolocator locator = Geolocator();

  double _latitude = 0.0;
  double _londitude = 0.0;

  Future<bool> hasPermission() async {
    try {
      final status = await locator.checkGeolocationPermissionStatus();
      return (status == GeolocationStatus.granted) ||
          (status == GeolocationStatus.unknown);
    } catch (e) {
      throw e;
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await locator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.lowest);
      _latitude = position.latitude;
      _londitude = position.longitude;
    } catch (e) {
      throw e;
    }
  }

  Future<String> getPlaceForCurrentLocation() async {
    await _getCurrentLocation();

    List<Placemark> placemarkList =
        await locator.placemarkFromCoordinates(_latitude, _londitude);

    if (placemarkList.length > 0) {
      print('placemarkList.length ${placemarkList.length}');
      final placemark = placemarkList.first;

      print(
          'Placemark: country: ${placemark.country}, isoCountryCode: ${placemark.isoCountryCode} ');

      return placemark.isoCountryCode != null
          ? placemark.isoCountryCode.toLowerCase()
          : '';
    } else {
      return '';
    }
  }
}
