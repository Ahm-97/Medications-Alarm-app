import 'package:flutter_application_3/app/enums/medication_type.dart';
import 'package:isar/isar.dart';
part 'medication_model.g.dart';

@Collection()
class Medication {
  Id? id;
  late String name;
  late int dosage;
  @enumerated
  late MedicationType medicationType;
  late bool isBeforeFood;
  late int dosesPerDay;
  late List<DateTime> times;
}
