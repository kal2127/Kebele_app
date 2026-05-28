import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app.dart';
import '../models/appointment.dart';
import '../providers/appointment_provider.dart';
import '../widgets/app_widgets.dart';

class EditAppointmentScreen extends StatefulWidget {
  const EditAppointmentScreen({super.key});

  @override
  State<EditAppointmentScreen> createState() => _EditAppointmentScreenState();
}

class _EditAppointmentScreenState extends State<EditAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  String? _selectedAppointmentId;
  DateTime? _selectedDate;
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _selectAppointment(Appointment appointment) {
    setState(() {
      _selectedAppointmentId = appointment.id;
      _selectedDate = appointment.appointmentDate;
      _phoneController.text = appointment.phoneNumber;
    });
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now.add(const Duration(days: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 120)),
      helpText: 'select_appointment_date'.tr(),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_selectedAppointmentId == null || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('select_appointment_validation'.tr())),
      );
      return;
    }

    setState(() => _isLoading = true);
    await context.read<AppointmentProvider>().updateAppointment(
          id: _selectedAppointmentId!,
          phoneNumber: _phoneController.text,
          appointmentDate: _selectedDate!,
        );
    if (!mounted) return;
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('appointment_updated'.tr())),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appointments = context.watch<AppointmentProvider>().activeAppointments;
    final selectedAppointment = _selectedAppointmentId == null
        ? null
        : context.read<AppointmentProvider>().findById(_selectedAppointmentId!);

    return Scaffold(
      body: AppPage(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
        child: Column(
          children: [
            KebeleHeader(
              title: 'edit_appointment'.tr(),
              subtitle: 'edit_subtitle'.tr(),
            ),
            Expanded(
              child: appointments.isEmpty
                  ? _EmptyAppointmentState(message: 'no_active_appointments'.tr())
                  : Form(
                      key: _formKey,
                      child: ListView(
                        padding: const EdgeInsets.only(bottom: 120),
                        children: [
                          SoftCard(
                            child: Column(
                              children: [
                                DropdownButtonFormField<String>(
                                  value: _selectedAppointmentId,
                                  decoration: InputDecoration(
                                    labelText: 'appointment_number'.tr(),
                                    prefixIcon: const Icon(
                                      Icons.confirmation_number_outlined,
                                    ),
                                  ),
                                  items: appointments
                                      .map(
                                        (appointment) => DropdownMenuItem(
                                          value: appointment.id,
                                          child: Text(
                                            '${appointment.id} - '
                                            '${appointment.serviceTitleKey.tr()}',
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (id) {
                                    final appointment = appointments.firstWhere(
                                      (item) => item.id == id,
                                    );
                                    _selectAppointment(appointment);
                                  },
                                  validator: (value) => value == null
                                      ? 'select_appointment_validation'.tr()
                                      : null,
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    labelText: 'phone_number'.tr(),
                                    prefixIcon: const Icon(Icons.phone_outlined),
                                  ),
                                  validator: (value) {
                                    final phone = value?.trim() ?? '';
                                    if (phone.length < 9) {
                                      return 'phone_validation'.tr();
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: _pickDate,
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: 'appointment_date'.tr(),
                                      prefixIcon: const Icon(
                                        Icons.calendar_month_outlined,
                                      ),
                                    ),
                                    child: Text(
                                      _selectedDate == null
                                          ? 'select_date'.tr()
                                          : DateFormat.yMMMEd(
                                              context.locale.languageCode,
                                            ).format(_selectedDate!),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (selectedAppointment != null) ...[
                            const SizedBox(height: 18),
                            AppointmentCard(appointment: selectedAppointment),
                          ],
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: appointments.isEmpty
          ? null
          : SafeArea(
              minimum: const EdgeInsets.fromLTRB(24, 8, 24, 20),
              child: PrimaryButton(
                label: 'save_changes'.tr(),
                icon: Icons.save_outlined,
                isLoading: _isLoading,
                onPressed: _submit,
              ),
            ),
    );
  }
}

class _EmptyAppointmentState extends StatelessWidget {
  const _EmptyAppointmentState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SoftCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const IconBubble(icon: Icons.event_busy_outlined, size: 76),
            const SizedBox(height: 18),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 18),
            PrimaryButton(
              label: 'book_appointment'.tr(),
              onPressed: () => Navigator.pushNamed(
                context,
                AppRoutes.bookAppointment,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
