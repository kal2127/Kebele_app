import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/appointment.dart';
import 'models/kebele_service.dart';
import 'providers/theme_provider.dart';
import 'screens/appointment_success_screen.dart';
import 'screens/book_appointment_screen.dart';
import 'screens/cancel_appointment_screen.dart';
import 'screens/edit_appointment_screen.dart';
import 'screens/feedback_screen.dart';
import 'screens/language_selection_screen.dart';
import 'screens/main_shell.dart';
import 'screens/service_details_screen.dart';
import 'screens/splash_screen.dart';
import 'themes/app_theme.dart';

class AppRoutes {
  static const splash = '/';
  static const language = '/language';
  static const main = '/main';
  static const serviceDetails = '/service-details';
  static const bookAppointment = '/book-appointment';
  static const appointmentSuccess = '/appointment-success';
  static const editAppointment = '/edit-appointment';
  static const cancelAppointment = '/cancel-appointment';
  static const feedback = '/feedback';
}

class KebeleApp extends StatelessWidget {
  const KebeleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'app_name'.tr(),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeProvider.themeMode,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: (settings) {
        Widget page;

        switch (settings.name) {
          case AppRoutes.language:
            page = const LanguageSelectionScreen();
          case AppRoutes.main:
            page = const MainShell();
          case AppRoutes.serviceDetails:
            page = ServiceDetailsScreen(
              service: settings.arguments! as KebeleService,
            );
          case AppRoutes.bookAppointment:
            page = BookAppointmentScreen(
              initialService: settings.arguments as KebeleService?,
            );
          case AppRoutes.appointmentSuccess:
            page = AppointmentSuccessScreen(
              appointment: settings.arguments! as Appointment,
            );
          case AppRoutes.editAppointment:
            page = const EditAppointmentScreen();
          case AppRoutes.cancelAppointment:
            page = const CancelAppointmentScreen();
          case AppRoutes.feedback:
            page = const FeedbackScreen();
          case AppRoutes.splash:
          default:
            page = const SplashScreen();
        }

        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, animation, __) => page,
          transitionsBuilder: (_, animation, __, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            );
            return FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.03, 0.02),
                  end: Offset.zero,
                ).animate(curved),
                child: child,
              ),
            );
          },
        );
      },
    );
  }
}
