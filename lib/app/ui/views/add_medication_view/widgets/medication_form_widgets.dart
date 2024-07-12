import 'package:flutter/material.dart';
import 'package:flutter_application_3/app/controllers/medication_controller.dart';
import 'package:flutter_application_3/app/ui/widgets/custom_button.dart';
import 'package:flutter_application_3/app/ui/widgets/custom_text_field.dart';
import 'package:flutter_application_3/gen/assets.gen.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'medication_helpers.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: const Color(0xff7970e5),
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        context.go("/");
      },
      color: Colors.white,
    ),
  );
}

Widget buildForm(
    BuildContext context,
    MedicationController medicationController,
    TextEditingController nameController,
    List<TextEditingController> timeControllers) {
  return Expanded(
    flex: 5,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.white,
      ),
      child: ListView(
        children: [
          buildFormTitle(),
          const Gap(20),
          CustomTextField(
            controller: nameController,
            hintText: "Enter title here",
          ),
          const Gap(24),
          buildDosageSelector(medicationController),
          const Gap(24),
          buildDosesPerDaySelector(medicationController),
          const Gap(24),
          buildIntakeToggleButtons(medicationController),
          const Gap(24),
          buildMedicationTypeSelector(medicationController),
          const Gap(24),
          buildTimePickers(medicationController, context),
          const Gap(24),
          buildAddReminderButton(
              context, medicationController, nameController, timeControllers),
        ],
      ),
    ),
  );
}

Widget buildFormTitle() {
  return const Text(
    'Add Reminder',
    style: TextStyle(
      fontSize: 20,
      color: Colors.black,
    ),
  );
}

Widget buildDosageSelector(MedicationController controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        'Dosage',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      Row(
        children: [
          buildDosageButton(Icons.remove, controller.decreaseDosage),
          const Gap(10),
          Obx(() => Text(
                '${controller.dosage.value}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              )),
          const Gap(10),
          buildDosageButton(Icons.add, controller.increaseDosage),
        ],
      ),
    ],
  );
}

Widget buildDosesPerDaySelector(
  MedicationController controller,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        'Doses per day',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      Row(
        children: [
          buildDosageButton(Icons.remove, () {
            controller.decreaseDosesPerDay();
          }),
          const Gap(10),
          Obx(() => Text(
                '${controller.dosesPerDay.value}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              )),
          const Gap(10),
          buildDosageButton(Icons.add, () {
            controller.increaseDosesPerDay();
          }),
        ],
      ),
    ],
  );
}

Widget buildDosageButton(IconData icon, VoidCallback onPressed) {
  return CircleAvatar(
    radius: 16,
    child: IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      iconSize: 16,
    ),
  );
}

Widget buildIntakeToggleButtons(MedicationController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'In-take',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          Obx(() => OutlinedButton(
                onPressed: () {
                  controller.setIntake(true);
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: controller.isBeforeFoodSelected.value
                      ? Colors.yellow
                      : Colors.transparent,
                  side: BorderSide(
                    color: controller.isBeforeFoodSelected.value
                        ? Colors.yellow
                        : Colors.grey,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Before Food',
                  style: TextStyle(
                    color: controller.isBeforeFoodSelected.value
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              )),
          const SizedBox(width: 10),
          Obx(() => OutlinedButton(
                onPressed: () {
                  controller.setIntake(false);
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: controller.isBeforeFoodSelected.value
                      ? Colors.transparent
                      : Colors.yellow,
                  side: BorderSide(
                    color: controller.isBeforeFoodSelected.value
                        ? Colors.grey
                        : Colors.yellow,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'After Food',
                  style: TextStyle(
                    color: controller.isBeforeFoodSelected.value
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              )),
        ],
      ),
    ],
  );
}

Widget buildMedicationTypeSelector(MedicationController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Type of medication',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      const Gap(20),
      Row(
        children: [
          Obx(() =>
              buildSelectableImage(controller, 0, Assets.images.pills.path)),
          const Gap(10),
          Obx(() =>
              buildSelectableImage(controller, 1, Assets.images.tablet.path)),
          const Gap(10),
          Obx(() =>
              buildSelectableImage(controller, 2, Assets.images.syrup.path)),
        ],
      ),
    ],
  );
}

Widget buildTimePickers(MedicationController controller, BuildContext context) {
  return Obx(() => Column(
        children: List.generate(controller.timeControllers.length, (index) {
          return Column(
            children: [
              CustomTextField(
                controller: controller.timeControllers[index],
                hintText: "Select time for dose ${index + 1}",
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    controller.timeControllers[index].text =
                        pickedTime.format(context);
                  }
                },
              ),
              const Gap(24),
            ],
          );
        }),
      ));
}

Widget buildAddReminderButton(
    BuildContext context,
    MedicationController controller,
    TextEditingController nameController,
    List<TextEditingController> timeControllers) {
  return CustomButton(
    text: 'Add Reminder',
    onPressed: () {
      addReminder(context, controller, nameController, timeControllers);
    },
    color: const Color(0xff7970e5),
    textColor: Colors.white,
    borderRadius: 8.0,
    elevation: 0,
    padding: 14.0,
  );
}

Widget buildSelectableImage(
    MedicationController controller, int index, String imagePath) {
  return GestureDetector(
    onTap: () {
      controller.setSelectedImageIndex(index);
    },
    child: Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(
          color: controller.selectedImageIndex.value == index
              ? Colors.black
              : Colors.transparent,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(
        imagePath,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
      ),
    ),
  );
}
