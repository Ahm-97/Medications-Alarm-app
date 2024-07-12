import 'package:flutter_application_3/app/ui/views/medication_list_view/widgets/medication_item.dart';
import 'package:flutter_application_3/core/common/constants/dimensions.dart';
import '../../../controllers/medication_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicationListView extends GetView<MedicationController> {
  const MedicationListView({super.key});

  @override
  Widget build(BuildContext context) {
    final MedicationController medicationController = Get.find();

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Obx(() {
        return _buildBody(context, medicationController);
      }),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Medications List',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => context.go('/add'),
          color: Colors.white,
        ),
      ],
    );
  }

  Widget _buildBody(
      BuildContext context, MedicationController medicationController) {
    if (medicationController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    } else if (medicationController.medications.isEmpty) {
      return _buildNoMedicationsMessage(context);
    } else {
      return _buildMedicationList(medicationController);
    }
  }

  Center _buildNoMedicationsMessage(BuildContext context) {
    return Center(
      child: Text(
        'No medications found',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  ListView _buildMedicationList(MedicationController medicationController) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.paddingMedium,
      ),
      itemCount: medicationController.medications.length,
      itemBuilder: (context, index) {
        final medication = medicationController.medications[index];
        return MedicationItem(
          medication: medication,
          onDelete: () => medicationController.deleteMedication(medication.id!),
        );
      },
    );
  }
}
