import 'package:flutter/material.dart';
import 'package:flutter_application_3/app/controllers/medication_controller.dart';
import 'widgets/build_header.dart';
import 'widgets/medication_form_widgets.dart';
import 'package:get/get.dart';

class AddMedicationView extends GetView<MedicationController> {
  AddMedicationView({super.key});
  final MedicationController medicationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(),
          buildForm(
            context,
            medicationController,
            medicationController.nameController,
            medicationController.timeControllers,
          ),
        ],
      ),
    );
  }
}
