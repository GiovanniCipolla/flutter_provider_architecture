// presentation/providers/reminder_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_provider_architecture/data/models/reminder.dart';
import 'package:flutter_provider_architecture/data/repositories/reminder_repository.dart';

class ReminderProvider with ChangeNotifier {
  final ReminderRepository _reminderRepository;
  List<Reminder> _reminders = [];

  ReminderProvider(this._reminderRepository);

  List<Reminder> get reminders => _reminders;

  Future<void> fetchReminders() async {
    try {
      _reminders = await _reminderRepository.getReminders();
      notifyListeners();
    } catch (e) {
      // Gestisci l'errore
    }
  }
}
