import 'package:covid19_info/core/viewmodels/world_cases_list_view_model.dart';
import 'package:get_it/get_it.dart';

import 'core/services/location_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => WorldCasesListViewModel());
  locator.registerLazySingleton(() => LocationService());
}
