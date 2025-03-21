import 'package:flutter/material.dart';
import 'package:flutter_provider_architecture/core/api_client.dart';
import 'package:flutter_provider_architecture/data/repositories/auth_repository.dart';
import 'package:flutter_provider_architecture/data/repositories/reminder_repository.dart';
import 'package:flutter_provider_architecture/data/repositories/user_repository.dart';
import 'package:flutter_provider_architecture/presentation/providers/auth_provider.dart';
import 'package:flutter_provider_architecture/presentation/providers/reminder_provider.dart';
import 'package:flutter_provider_architecture/presentation/providers/user_privder.dart';
import 'package:flutter_provider_architecture/presentation/screens/login_scren.dart';
import 'package:provider/provider.dart';

// Il MultiProvider è uno strumento essenziale in Flutter per:
// Centralizzare la configurazione delle dipendenze.
// Condividere lo stato tra i widget.
// Rendere il codice modulare e scalabile.

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => ApiClient()),
        Provider(
            create: (context) => AuthRepository(context.read<ApiClient>())),
        ChangeNotifierProvider(
            create: (context) => AuthProvider(context.read<AuthRepository>())),
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
            create: (context) =>
                UserProvider(UserRepository(context.read<ApiClient>())),
            update: (context, authProvider, userProvider) => UserProvider(
                  UserRepository(context.read<ApiClient>()),
                )),
        ChangeNotifierProxyProvider<AuthProvider, ReminderProvider>(
            create: (context) =>
                ReminderProvider(ReminderRepository(context.read<ApiClient>())),
            update: (context, authProvider, reminderProvider) =>
                ReminderProvider(
                    ReminderRepository(context.read<ApiClient>()))),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Provider Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
