import 'package:flutter/material.dart';

class KebeleService {
  const KebeleService({
    required this.id,
    required this.icon,
    required this.titleKey,
    required this.shortDescriptionKey,
    required this.fullDescriptionKey,
    required this.documentKeys,
    required this.processingTimeKey,
    required this.instructionKeys,
  });

  final String id;
  final IconData icon;
  final String titleKey;
  final String shortDescriptionKey;
  final String fullDescriptionKey;
  final List<String> documentKeys;
  final String processingTimeKey;
  final List<String> instructionKeys;
}
