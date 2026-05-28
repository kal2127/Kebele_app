import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../themes/app_theme.dart';
import '../widgets/app_widgets.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _feedbackController = TextEditingController();
  int _rating = 5;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    await showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        icon: const Icon(Icons.check_circle_rounded, size: 52),
        title: Text('feedback_sent'.tr()),
        content: Text('feedback_thanks'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('done'.tr()),
          ),
        ],
      ),
    );
    if (!mounted) return;
    _feedbackController.clear();
    setState(() => _rating = 5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPage(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
        child: Column(
          children: [
            KebeleHeader(
              title: 'send_feedback'.tr(),
              subtitle: 'feedback_subtitle'.tr(),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 110),
                children: [
                  SoftCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'rate_experience'.tr(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            final star = index + 1;
                            return IconButton(
                              onPressed: () => setState(() => _rating = star),
                              iconSize: 38,
                              icon: Icon(
                                star <= _rating
                                    ? Icons.star_rounded
                                    : Icons.star_border_rounded,
                                color: AppTheme.gold,
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 18),
                        TextField(
                          controller: _feedbackController,
                          maxLines: 6,
                          decoration: InputDecoration(
                            labelText: 'feedback_message'.tr(),
                            alignLabelWithHint: true,
                          ),
                        ),
                        const SizedBox(height: 20),
                        PrimaryButton(
                          label: 'submit_feedback'.tr(),
                          icon: Icons.send_outlined,
                          onPressed: _submit,
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
