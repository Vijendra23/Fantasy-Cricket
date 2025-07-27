import 'package:get_it/get_it.dart';
import '../../core/data_source/shared_preferences/shared_preferences_service_impl.dart';
import '../services/navigation/navigation_service_impl.dart';

/// Import the GetIt package for dependency injection

/// Create an instance of GetIt to act as the service locator
final serviceLocator = GetIt.instance;

/// Retrieve an instance of AppNavigationServiceImpl from the service locator
final navigationService = serviceLocator<AppNavigationServiceImpl>();

final sharedPreferencesService = serviceLocator<SharedPreferencesServiceImpl>();

/// Function to set up the service locator and register dependencies
void setupServiceLocator() {
  _singleton();
}

void _singleton() {
  serviceLocator.registerSingleton<SharedPreferencesServiceImpl>(
      SharedPreferencesServiceImpl());
  serviceLocator.registerSingleton(AppNavigationServiceImpl());
}

