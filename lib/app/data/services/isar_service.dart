import 'package:flutter_application_3/app/data/models/medication_model.dart';
import 'package:isar/isar.dart';

Future<Isar> initializeIsar(String directory) async {
  return await Isar.open([MedicationSchema], directory: directory);
}
