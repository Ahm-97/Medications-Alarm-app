import 'package:flutter_application_3/app/controllers/medication_controller.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

import '../data/repositories/medication_repository_impl.dart';

void initializeDependencies(Isar isar,
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
  final medicationRepository = MedicationRepositoryImpl(isar);
  Get.put(
    MedicationController(medicationRepository, flutterLocalNotificationsPlugin),
  );
}
