import 'package:flutter_application_3/app/ui/views/medication_list_view/medication_list_view.dart';
import 'package:go_router/go_router.dart';
import '../ui/views/add_medication_view/add_medication_view.dart';

final GoRouter router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MedicationListView(),
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) => AddMedicationView(),
    ),
  ],
);
