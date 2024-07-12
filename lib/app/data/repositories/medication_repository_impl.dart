import 'package:isar/isar.dart';
import '../models/medication_model.dart';
import 'medication_repository.dart';

class MedicationRepositoryImpl implements MedicationRepository {
  final Isar _isar;

  MedicationRepositoryImpl(this._isar);

  @override
  Future<void> addMedication(Medication medication) async {
    await _isar.writeTxn(() async {
      await _isar.collection<Medication>().put(medication);
    });
  }

  @override
  Future<List<Medication>> getMedications() async {
    return await _isar.collection<Medication>().where().findAll();
  }

  @override
  Future<void> deleteMedication(int id) async {
    await _isar.writeTxn(() async {
      await _isar.collection<Medication>().delete(id);
    });
  }
}
