import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app.dart';
import '../providers/language_provider.dart';
import '../themes/app_theme.dart';
import '../widgets/app_widgets.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  Locale _selectedLocale = const Locale('en');

  Future<void> _continue() async {
    await context.setLocale(_selectedLocale);
    if (!mounted) return;
    await context.read<LanguageProvider>().setLocale(_selectedLocale);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.main);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Container(
              width: 82,
              height: 82,
              decoration: const BoxDecoration(
                color: AppTheme.deepGreen,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.language_rounded,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'choose_language'.tr(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'choose_language_subtitle'.tr(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 28),
            _LanguageCard(
              title: 'English',
              subtitle: 'Continue in English',
              isSelected: _selectedLocale.languageCode == 'en',
              onTap: () => setState(() => _selectedLocale = const Locale('en')),
            ),
            const SizedBox(height: 14),
            _LanguageCard(
              title: 'አማርኛ',
              subtitle: 'በአማርኛ ይቀጥሉ',
              isSelected: _selectedLocale.languageCode == 'am',
              onTap: () => setState(() => _selectedLocale = const Locale('am')),
            ),
            const Spacer(),
            PrimaryButton(
              label: 'continue'.tr(),
              onPressed: _continue,
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  const _LanguageCard({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: SoftCard(
        color: isSelected
            ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
            : null,
        child: Row(
          children: [
            IconBubble(
              icon: Icons.translate_rounded,
              backgroundColor: isSelected
                  ? AppTheme.deepGreen
                  : Theme.of(context).colorScheme.primary.withOpacity(0.08),
              foregroundColor:
                  isSelected ? Colors.white : Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle_rounded, color: AppTheme.deepGreen),
          ],
        ),
      ),
    );
  }
}
