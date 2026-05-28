import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/appointment.dart';
import '../models/kebele_service.dart';

class AppointmentProvider extends ChangeNotifier {
  AppointmentProvider(this._prefs) {
    _loadAppointments();
  }

  static const _appointmentsKey = 'local_appointments';

  final SharedPreferences _prefs;
  final List<Appointment> _appointments = [];
  final Random _random = Random();

  List<Appointment> get appointments => List.unmodifiable(_appointments);

  List<Appointment> get activeAppointments => _appointments
      .where((appointment) => appointment.status == AppointmentStatus.active)
      .toList();

  Appointment? findById(String id) {
    final normalized = id.trim().toUpperCase();
    for (final appointment in _appointments) {
      if (appointment.id.toUpperCase() == normalized) {
        return appointment;
      }
    }
    return null;
  }

  Future<Appointment> bookAppointment({
    required String fullName,
    required String phoneNumber,
    required KebeleService service,
    required DateTime appointmentDate,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    final appointment = Appointment(
      id: _generateAppointmentId(),
      fullName: fullName.trim(),
      phoneNumber: phoneNumber.trim(),
      serviceId: service.id,
      serviceTitleKey: service.titleKey,
      appointmentDate: appointmentDate,
      createdAt: DateTime.now(),
    );
    _appointments.insert(0, appointment);
    await _saveAppointments();
    notifyListeners();
    return appointment;
  }

  Future<void> updateAppointment({
    required String id,
    required String phoneNumber,
    required DateTime appointmentDate,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final index = _appointments.indexWhere((appointment) => appointment.id == id);
    if (index == -1) return;

    _appointments[index] = _appointments[index].copyWith(
      phoneNumber: phoneNumber.trim(),
      appointmentDate: appointmentDate,
    );
    await _saveAppointments();
    notifyListeners();
  }

  Future<void> cancelAppointment(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final index = _appointments.indexWhere((appointment) => appointment.id == id);
    if (index == -1) return;

    _appointments[index] = _appointments[index].copyWith(
      status: AppointmentStatus.cancelled,
    );
    await _saveAppointments();
    notifyListeners();
  }

  void _loadAppointments() {
    final rawAppointments = _prefs.getStringList(_appointmentsKey) ?? [];
    _appointments
      ..clear()
      ..addAll(
        rawAppointments.map(
          (raw) => Appointment.fromJson(jsonDecode(raw) as Map<String, dynamic>),
        ),
      );
  }

  Future<void> _saveAppointments() {
    final encoded = _appointments
        .map((appointment) => jsonEncode(appointment.toJson()))
        .toList();
    return _prefs.setStringList(_appointmentsKey, encoded);
  }

  String _generateAppointmentId() {
    final number = 100000 + _random.nextInt(900000);
    return 'KBL-$number';
  }
}
