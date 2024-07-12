import 'package:flutter/material.dart';
import 'package:flutter_application_3/app/controllers/medication_controller.dart';
import 'package:flutter_application_3/app/data/models/medication_model.dart';
import 'package:go_router/go_router.dart';

void addReminder(
    BuildContext context,
    MedicationController controller,
    TextEditingController nameController,
    List<TextEditingController> timeControllers) {
  try {
    if (nameController.text.isNotEmpty &&
        timeControllers.every((controller) => controller.text.isNotEmpty) &&
        controller.selectedImageIndex.value != -1) {
      final List<DateTime> times = timeControllers
          .map((controller) => parseTime(controller.text))
          .toList();
      final medication = Medication()
        ..name = nameController.text
        ..dosage = controller.dosage.value
        ..medicationType =
            controller.getMedicationType(controller.selectedImageIndex.value)
        ..isBeforeFood = controller.isBeforeFoodSelected.value
        ..dosesPerDay = controller.dosesPerDay.value
        ..times = times;
      controller.addMedication(medication);
      context.go('/');
    }
  } catch (e) {
    print('Error adding medication: $e');
  }
}

DateTime parseTime(String timeString) {
  final now = DateTime.now();
  final timeParts = timeString.split(' ');
  final time = timeParts[0].split(':');
  final hour = int.parse(time[0]);
  final minute = int.parse(time[1]);
  final period = timeParts[1];
  final isPm = period.toLowerCase() == 'pm';

  return DateTime(
    now.year,
    now.month,
    now.day,
    isPm ? hour + 12 : hour,
    minute,
  );
}
