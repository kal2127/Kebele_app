import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../app.dart';
import '../models/kebele_service.dart';
import '../widgets/app_widgets.dart';

class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({super.key, required this.service});

  final KebeleService service;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPage(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
        child: Column(
          children: [
            KebeleHeader(title: service.titleKey.tr()),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 118),
                children: [
                  SoftCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconBubble(icon: service.icon, size: 72),
                        const SizedBox(height: 20),
                        Text(
                          service.fullDescriptionKey.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 18),
                        _DetailTile(
                          icon: Icons.schedule_outlined,
                          title: 'processing_time'.tr(),
                          child: Text(service.processingTimeKey.tr()),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  _DetailSection(
                    title: 'required_documents'.tr(),
                    icon: Icons.folder_copy_outlined,
                    children: service.documentKeys
                        .map((key) => _BulletText(text: key.tr()))
                        .toList(),
                  ),
                  const SizedBox(height: 18),
                  _DetailSection(
                    title: 'instructions'.tr(),
                    icon: Icons.info_outline_rounded,
                    children: service.instructionKeys
                        .map((key) => _BulletText(text: key.tr()))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(24, 8, 24, 20),
        child: PrimaryButton(
          label: 'book_appointment'.tr(),
          icon: Icons.calendar_month_outlined,
          onPressed: () => Navigator.pushNamed(
            context,
            AppRoutes.bookAppointment,
            arguments: service,
          ),
        ),
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      child: _DetailTile(
        icon: icon,
        title: title,
        child: Column(children: children),
      ),
    );
  }
}

class _DetailTile extends StatelessWidget {
  const _DetailTile({
    required this.icon,
    required this.title,
    required this.child,
  });

  final IconData icon;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconBubble(icon: icon, size: 48),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              child,
            ],
          ),
        ),
      ],
    );
  }
}

class _BulletText extends StatelessWidget {
  const _BulletText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
