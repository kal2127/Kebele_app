import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app.dart';
import '../data/local_services_data.dart';
import '../models/kebele_service.dart';
import '../providers/appointment_provider.dart';
import '../widgets/app_widgets.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key, this.initialService});

  final KebeleService? initialService;

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();

  KebeleService? _selectedService;
  DateTime? _selectedDate;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedService = widget.initialService;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    super.dispose();
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
    if (_selectedService == null || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('complete_required_fields'.tr())),
      );
      return;
    }

    setState(() => _isLoading = true);
    final appointment = await context.read<AppointmentProvider>().bookAppointment(
          fullName: _fullNameController.text,
          phoneNumber: _phoneController.text,
          service: _selectedService!,
          appointmentDate: _selectedDate!,
        );
    if (!mounted) return;
    setState(() => _isLoading = false);

    await showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        icon: const Icon(Icons.check_circle_rounded, size: 54),
        title: Text('booking_confirmed'.tr()),
        content: Text('booking_confirmed_message'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('continue'.tr()),
          ),
        ],
      ),
    );
    if (!mounted) return;
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.appointmentSuccess,
      arguments: appointment,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPage(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
        child: Column(
          children: [
            KebeleHeader(
              title: 'book_appointment'.tr(),
              subtitle: 'book_subtitle'.tr(),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 120),
                  children: [
                    SoftCard(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _fullNameController,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'full_name'.tr(),
                              prefixIcon: const Icon(Icons.person_outline),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().length < 3) {
                                return 'name_validation'.tr();
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'phone_number'.tr(),
                              hintText: 'phone_hint'.tr(),
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
                          DropdownButtonFormField<KebeleService>(
                            value: _selectedService,
                            decoration: InputDecoration(
                              labelText: 'service_selection'.tr(),
                              prefixIcon: const Icon(Icons.grid_view_outlined),
                            ),
                            items: LocalServicesData.services
                                .map(
                                  (service) => DropdownMenuItem(
                                    value: service,
                                    child: Text(service.titleKey.tr()),
                                  ),
                                )
                                .toList(),
                            onChanged: (service) {
                              setState(() => _selectedService = service);
                            },
                            validator: (service) => service == null
                                ? 'service_validation'.tr()
                                : null,
                          ),
                          const SizedBox(height: 16),
                          InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: _pickDate,
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'appointment_date'.tr(),
                                prefixIcon:
                                    const Icon(Icons.calendar_month_outlined),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(24, 8, 24, 20),
        child: PrimaryButton(
          label: 'confirm_booking'.tr(),
          icon: Icons.check_circle_outline_rounded,
          isLoading: _isLoading,
          onPressed: _submit,
        ),
      ),
    );
  }
}
