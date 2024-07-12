import 'package:flutter_application_3/app/bindings/dependency_injection.dart';
import 'package:flutter_application_3/app/data/services/isar_service.dart';
import 'package:flutter_application_3/app/data/services/notification_service.dart';
import 'package:flutter_application_3/app/ui/views/app.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Baghdad'));

  await initializeNotifications(flutterLocalNotificationsPlugin);

  final dir = await getApplicationDocumentsDirectory();
  final isar = await initializeIsar(dir.path);

  initializeDependencies(isar, flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}
