import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pira/firebase_options.dart';
import 'package:pira/models/petrol_expense_item.dart';
import 'package:pira/pages/create/create.dart';
import 'package:pira/pages/home/home.dart';
import 'package:pira/services/pira/pira_service.dart';
import 'package:provider/provider.dart';

import 'services/auth/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const PiraApp());
}

class PiraApp extends StatelessWidget {
  const PiraApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      catchError: null,
      create: (BuildContext context) =>
          PiraService().fetchUserConsumptionDocument(),
      // initialData: null,
      initialData: const <PetrolExpenseItem>[],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pira',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AuthGate(),
        routes: {
          "/home": (context) => const HomePage(),
          "/create": (context) => const CreatePage(),
        },
      ),
    );
  }
}
