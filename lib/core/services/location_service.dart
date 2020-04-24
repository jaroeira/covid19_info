import 'package:geolocator/geolocator.dart';

class LocationService {
  Geolocator locator = Geolocator();

  Position _position;

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
      _position = await locator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.lowest);
    } catch (e) {
      throw e;
    }
  }

  Future<String> getPlaceForCurrentLocation() async {
    await _getCurrentLocation();

    List<Placemark> placemarkList = await locator
        .placemarkFromPosition(_position)
        .timeout(Duration(seconds: 5));

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
