import '../data/di/injector.dart';
import '../domain/di/injector.dart';
import '../presentation/di/injector.dart';

Future<void> configureInjector() async {
  await configureDataDependencies();
  await configureDomainDependencies();
  await configurePresentationDependencies();
}
