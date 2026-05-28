import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../app.dart';
import '../data/local_services_data.dart';
import '../widgets/app_widgets.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key, this.showBackButton = true});

  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    final services = LocalServicesData.services;

    return Scaffold(
      body: AppPage(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KebeleHeader(
              title: 'services_title'.tr(),
              subtitle: 'services_subtitle'.tr(),
              showBack: showBackButton,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 110),
                itemCount: services.length,
                separatorBuilder: (_, __) => const SizedBox(height: 18),
                itemBuilder: (context, index) {
                  final service = services[index];
                  return ServiceCard(
                    service: service,
                    showDocuments: true,
                    showBookButton: true,
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoutes.serviceDetails,
                      arguments: service,
                    ),
                    onBook: () => Navigator.pushNamed(
                      context,
                      AppRoutes.bookAppointment,
                      arguments: service,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
