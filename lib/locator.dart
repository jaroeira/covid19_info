import 'package:covid19_info/core/viewmodels/world_cases_list_view_model.dart';
import 'package:get_it/get_it.dart';
import 'core/repositories/covid19_info_repository.dart';
import 'core/services/location_service.dart';
import 'core/viewmodels/country_detail_view_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => WorldCasesListViewModel());
  locator.registerFactory(() => CountryDetailViewModel());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => Covid19InfoRepository());
}
