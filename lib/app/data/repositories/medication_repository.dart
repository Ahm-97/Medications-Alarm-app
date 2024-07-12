import '../models/medication_model.dart';

abstract class MedicationRepository {
  Future<void> addMedication(Medication medication);
  Future<List<Medication>> getMedications();
  Future<void> deleteMedication(int id);
}
