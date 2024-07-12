import 'package:flutter/material.dart';
import 'package:flutter_application_3/app/data/models/medication_model.dart';
import 'package:flutter_application_3/app/enums/medication_type.dart';
import 'package:flutter_application_3/core/common/constants/dimensions.dart';
import 'package:flutter_application_3/gen/assets.gen.dart';
import 'package:intl/intl.dart';

class MedicationItem extends StatelessWidget {
  final Medication medication;
  final VoidCallback onDelete;

  const MedicationItem(
      {required this.medication, required this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingMedium,
        vertical: Dimensions.marginSmall,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.paddingMedium,
        horizontal: Dimensions.marginMedium,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _buildMedicationDetails(context),
          ),
          Expanded(
            child: _buildMedicationImage(),
          ),
          _buildDeleteButton(),
        ],
      ),
    );
  }

  Column _buildMedicationDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          medication.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: Dimensions.marginSmall),
        Text(
          "${medication.dosage} ${_getMedicationTypeString(medication.medicationType)}",
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: Dimensions.marginSmall),
        Text(
          medication.isBeforeFood ? 'Before Food' : 'After Food',
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: Dimensions.marginSmall),
        ..._buildMedicationTimes(),
      ],
    );
  }

  List<Widget> _buildMedicationTimes() {
    return medication.times.map((time) {
      return Text(
        DateFormat('hh:mm a').format(time),
        style: TextStyle(
          color: Colors.grey[600],
        ),
      );
    }).toList();
  }

  Image _buildMedicationImage() {
    return Image.asset(
      _getMedicationImage(medication.medicationType),
      height: 70,
    );
  }

  IconButton _buildDeleteButton() {
    return IconButton(
      icon: const Icon(Icons.delete, color: Colors.red),
      onPressed: onDelete,
    );
  }

  String _getMedicationTypeString(MedicationType medicationType) {
    switch (medicationType) {
      case MedicationType.capsule:
        return 'capsule';
      case MedicationType.tablet:
        return 'tablet';
      case MedicationType.syrup:
        return 'syrup';
      default:
        return 'unknown';
    }
  }

  String _getMedicationImage(MedicationType medicationType) {
    switch (medicationType) {
      case MedicationType.capsule:
        return Assets.images.pills.path;
      case MedicationType.tablet:
        return Assets.images.tablet.path;
      case MedicationType.syrup:
        return Assets.images.syrup.path;
      default:
        return Assets.images.syrup.path;
    }
  }
}
