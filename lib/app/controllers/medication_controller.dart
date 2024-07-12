import 'package:flutter_application_3/app/data/models/medication_model.dart';
import 'package:flutter_application_3/app/data/repositories/medication_repository_impl.dart';
import 'package:flutter_application_3/app/enums/medication_type.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;

class MedicationController extends GetxController {
  final MedicationRepositoryImpl medicationRepository;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var medications = <Medication>[].obs;
  var isLoading = true.obs;
  var dosage = 1.obs;
  var selectedImageIndex = (-1).obs;
  var isBeforeFoodSelected = true.obs;
  var dosesPerDay = 1.obs;
  var timeControllers = <TextEditingController>[TextEditingController()].obs;
  final TextEditingController nameController = TextEditingController();

  MedicationController(
    this.medicationRepository,
    this.flutterLocalNotificationsPlugin,
  );

  @override
  void onInit() {
    fetchMedications();
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    for (var controller in timeControllers) {
      controller.dispose();
    }
    super.onClose();
  }

  void addMedication(Medication medication) async {
    await medicationRepository.addMedication(medication);
    fetchMedications();
    _scheduleNotification(medication);
  }

  void fetchMedications() async {
    try {
      isLoading(true);
      var meds = await medicationRepository.getMedications();
      medications.assignAll(meds);
    } finally {
      isLoading(false);
    }
  }

  void deleteMedication(int id) async {
    await medicationRepository.deleteMedication(id);
    fetchMedications();
  }

  void increaseDosage() {
    dosage.value++;
  }

  void decreaseDosage() {
    if (dosage.value > 1) dosage.value--;
  }

  void setIntake(bool beforeFood) {
    isBeforeFoodSelected.value = beforeFood;
  }

  void setSelectedImageIndex(int index) {
    selectedImageIndex.value = index;
  }

  void increaseDosesPerDay() {
    dosesPerDay.value++;
    timeControllers.add(TextEditingController());
  }

  void decreaseDosesPerDay() {
    if (dosesPerDay.value > 1) {
      dosesPerDay.value--;
      timeControllers.removeLast().dispose();
    }
  }

  MedicationType getMedicationType(int index) {
    switch (index) {
      case 0:
        return MedicationType.capsule;
      case 1:
        return MedicationType.tablet;
      case 2:
        return MedicationType.syrup;
      default:
        return MedicationType.unknown;
    }
  }

  void _scheduleNotification(Medication medication) async {
    for (var i = 0; i < medication.times.length; i++) {
      final time = medication.times[i];
      final scheduledDate = tz.TZDateTime.from(time, tz.local);

      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'medication_reminder_channel_id',
        'Medication Reminders',
        channelDescription: 'Reminder notifications for medication',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
      );

      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.zonedSchedule(
        medication.id.hashCode + i,
        'Medication Reminder',
        'Time to take your ${medication.name}',
        scheduledDate,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }
}
