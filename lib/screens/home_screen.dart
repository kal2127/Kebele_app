import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app.dart';
import '../data/local_services_data.dart';
import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';
import '../themes/app_theme.dart';
import '../widgets/app_widgets.dart';
import 'services_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _toggleLanguage(BuildContext context) async {
    final provider = context.read<LanguageProvider>();
    final locale = provider.isAmharic ? const Locale('en') : const Locale('am');
    await context.setLocale(locale);
    if (!context.mounted) return;
    await provider.setLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    final services = LocalServicesData.services.take(4).toList();
    final width = MediaQuery.sizeOf(context).width;
    final crossAxisCount = width > 620 ? 4 : 2;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 54, 24, 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.deepGreen, AppTheme.forestGreen],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'welcome'.tr().toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'app_short_name'.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      _HeaderAction(
                        label: context.watch<LanguageProvider>().isAmharic
                            ? 'EN'
                            : 'አማ',
                        onTap: () => _toggleLanguage(context),
                      ),
                      const SizedBox(width: 10),
                      _HeaderAction(
                        icon: context.watch<ThemeProvider>().isDarkMode
                            ? Icons.light_mode_outlined
                            : Icons.dark_mode_outlined,
                        onTap: () => context.read<ThemeProvider>().toggleTheme(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  SoftCard(
                    color: Colors.white.withOpacity(0.16),
                    child: Row(
                      children: [
                        const IconBubble(
                          icon: Icons.location_on_outlined,
                          backgroundColor: AppTheme.gold,
                          foregroundColor: Colors.black87,
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'office_name'.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                              Text(
                                'office_hours'.tr(),
                                style: const TextStyle(color: Colors.white70),
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
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 22, 24, 8),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  SectionHeader(title: 'quick_actions'.tr()),
                  const SizedBox(height: 12),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final cardWidth = (constraints.maxWidth - 16) / 2;
                      return Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          SizedBox(
                            width: cardWidth,
                            child: _QuickActionCard(
                              icon: Icons.edit_calendar_outlined,
                              title: 'book_appointment'.tr(),
                              color: AppTheme.deepGreen,
                              onTap: () => Navigator.pushNamed(
                                context,
                                AppRoutes.bookAppointment,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: cardWidth,
                            child: _QuickActionCard(
                              icon: Icons.edit_note_outlined,
                              title: 'edit_appointment'.tr(),
                              color: AppTheme.deepGreen,
                              onTap: () => Navigator.pushNamed(
                                context,
                                AppRoutes.editAppointment,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: cardWidth,
                            child: _QuickActionCard(
                              icon: Icons.cancel_outlined,
                              title: 'cancel_appointment'.tr(),
                              color: AppTheme.gold,
                              onTap: () => Navigator.pushNamed(
                                context,
                                AppRoutes.cancelAppointment,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 28),
                  SectionHeader(
                    title: 'featured_services'.tr(),
                    actionLabel: 'view_all'.tr(),
                    onAction: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const ServicesScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 110),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.18,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final service = services[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(28),
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoutes.serviceDetails,
                      arguments: service,
                    ),
                    child: SoftCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconBubble(icon: service.icon),
                          const Spacer(),
                          Text(
                            service.titleKey.tr(),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            service.processingTimeKey.tr(),
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: services.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderAction extends StatelessWidget {
  const _HeaderAction({this.icon, this.label, required this.onTap});

  final IconData? icon;
  final String? label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 56,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.16),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.18)),
        ),
        child: Center(
          child: icon == null
              ? Text(
                  label ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                )
              : Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: SoftCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconBubble(
              icon: icon,
              backgroundColor: color,
              foregroundColor: color == AppTheme.gold ? Colors.black87 : Colors.white,
            ),
            const SizedBox(height: 24),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 6),
            Row(
              children: [
                Text(
                  'get_started'.tr(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  Icons.north_east_rounded,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
