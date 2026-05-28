import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/appointment.dart';
import '../providers/appointment_provider.dart';
import '../widgets/app_widgets.dart';

class CancelAppointmentScreen extends StatefulWidget {
  const CancelAppointmentScreen({super.key});

  @override
  State<CancelAppointmentScreen> createState() =>
      _CancelAppointmentScreenState();
}

class _CancelAppointmentScreenState extends State<CancelAppointmentScreen> {
  final _appointmentNumberController = TextEditingController();
  Appointment? _foundAppointment;
  bool _isCancelled = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _appointmentNumberController.dispose();
    super.dispose();
  }

  void _lookup() {
    final appointment = context
        .read<AppointmentProvider>()
        .findById(_appointmentNumberController.text);
    setState(() {
      _foundAppointment =
          appointment?.status == AppointmentStatus.active ? appointment : null;
      _isCancelled = false;
    });
    if (_foundAppointment == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('appointment_not_found'.tr())),
      );
    }
  }

  Future<void> _cancel() async {
    if (_foundAppointment == null) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        icon: const Icon(Icons.warning_amber_rounded, size: 48),
        title: Text('cancel_confirm_title'.tr()),
        content: Text('cancel_confirm_message'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('keep_appointment'.tr()),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('cancel_appointment'.tr()),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    setState(() => _isLoading = true);
    await context
        .read<AppointmentProvider>()
        .cancelAppointment(_foundAppointment!.id);
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _isCancelled = true;
      _foundAppointment = null;
      _appointmentNumberController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPage(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
        child: Column(
          children: [
            KebeleHeader(
              title: 'cancel_appointment'.tr(),
              subtitle: 'cancel_subtitle'.tr(),
            ),
            Expanded(
              child: ListView(
                children: [
                  SoftCard(
                    child: Column(
                      children: [
                        TextField(
                          controller: _appointmentNumberController,
                          textCapitalization: TextCapitalization.characters,
                          decoration: InputDecoration(
                            labelText: 'appointment_number'.tr(),
                            hintText: 'appointment_number_hint'.tr(),
                            prefixIcon: const Icon(
                              Icons.confirmation_number_outlined,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        PrimaryButton(
                          label: 'lookup_appointment'.tr(),
                          icon: Icons.search_rounded,
                          onPressed: _lookup,
                        ),
                      ],
                    ),
                  ),
                  if (_foundAppointment != null) ...[
                    const SizedBox(height: 18),
                    AppointmentCard(appointment: _foundAppointment!),
                    const SizedBox(height: 18),
                    PrimaryButton(
                      label: 'cancel_appointment'.tr(),
                      icon: Icons.cancel_outlined,
                      isLoading: _isLoading,
                      onPressed: _cancel,
                    ),
                  ],
                  if (_isCancelled) ...[
                    const SizedBox(height: 18),
                    SoftCard(
                      child: Column(
                        children: [
                          const IconBubble(
                            icon: Icons.check_circle_outline_rounded,
                            size: 76,
                          ),
                          const SizedBox(height: 18),
                          Text(
                            'appointment_cancelled'.tr(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
