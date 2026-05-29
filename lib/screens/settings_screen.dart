import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app.dart';
import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';
import '../themes/app_theme.dart';
import '../widgets/app_widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, this.showBackButton = true});

  final bool showBackButton;

  Future<void> _setLanguage(BuildContext context, String languageCode) async {
    final locale = Locale(languageCode);
    await context.setLocale(locale);
    if (!context.mounted) return;
    await context.read<LanguageProvider>().setLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final languageProvider = context.watch<LanguageProvider>();

    return Scaffold(
      body: AppPage(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KebeleHeader(
              title: 'settings'.tr(),
              showBack: showBackButton,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 110),
                children: [
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppTheme.deepGreen, AppTheme.forestGreen],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'app_short_name'.tr().toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'tagline'.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Version 1.0.0',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SoftCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        _SettingsTile(
                          icon: Icons.dark_mode_outlined,
                          title: 'dark_mode'.tr(),
                          trailing: Switch(
                            value: themeProvider.isDarkMode,
                            onChanged: themeProvider.setDarkMode,
                          ),
                        ),
                        const Divider(height: 1),
                        _SettingsTile(
                          icon: Icons.language_outlined,
                          title: 'language'.tr(),
                          trailing: SegmentedButton<String>(
                            segments: const [
                              ButtonSegment(value: 'en', label: Text('EN')),
                              ButtonSegment(value: 'am', label: Text('አማ')),
                            ],
                            selected: {languageProvider.locale.languageCode},
                            onSelectionChanged: (selected) {
                              _setLanguage(context, selected.first);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SoftCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        _SettingsTile(
                          icon: Icons.feedback_outlined,
                          title: 'send_feedback'.tr(),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.feedback,
                          ),
                        ),
                        const Divider(height: 1),
                        _SettingsTile(
                          icon: Icons.info_outline_rounded,
                          title: 'about_app'.tr(),
                          subtitle: 'about_app_message'.tr(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      leading: IconBubble(icon: icon, size: 54),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: subtitle == null ? null : Text(subtitle!),
      trailing: trailing,
    );
  }
}
