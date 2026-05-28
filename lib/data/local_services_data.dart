import 'package:flutter/material.dart';

import '../models/kebele_service.dart';

class LocalServicesData {
  static const List<KebeleService> services = [
    KebeleService(
      id: 'new_id',
      icon: Icons.badge_outlined,
      titleKey: 'services.new_id.title',
      shortDescriptionKey: 'services.new_id.short',
      fullDescriptionKey: 'services.new_id.full',
      documentKeys: [
        'documents.birth_certificate',
        'documents.residence_letter',
        'documents.photos',
      ],
      processingTimeKey: 'processing.new_id',
      instructionKeys: [
        'instructions.bring_originals',
        'instructions.arrive_early',
        'instructions.use_correct_phone',
      ],
    ),
    KebeleService(
      id: 'id_renewal',
      icon: Icons.sync_outlined,
      titleKey: 'services.id_renewal.title',
      shortDescriptionKey: 'services.id_renewal.short',
      fullDescriptionKey: 'services.id_renewal.full',
      documentKeys: [
        'documents.old_id',
        'documents.residence_letter',
        'documents.photos',
      ],
      processingTimeKey: 'processing.id_renewal',
      instructionKeys: [
        'instructions.bring_originals',
        'instructions.old_id_required',
        'instructions.use_correct_phone',
      ],
    ),
    KebeleService(
      id: 'lost_id',
      icon: Icons.shield_outlined,
      titleKey: 'services.lost_id.title',
      shortDescriptionKey: 'services.lost_id.short',
      fullDescriptionKey: 'services.lost_id.full',
      documentKeys: [
        'documents.police_report',
        'documents.residence_letter',
        'documents.photos',
      ],
      processingTimeKey: 'processing.lost_id',
      instructionKeys: [
        'instructions.bring_originals',
        'instructions.police_report_required',
        'instructions.arrive_early',
      ],
    ),
    KebeleService(
      id: 'birth_certificate',
      icon: Icons.child_care_outlined,
      titleKey: 'services.birth_certificate.title',
      shortDescriptionKey: 'services.birth_certificate.short',
      fullDescriptionKey: 'services.birth_certificate.full',
      documentKeys: [
        'documents.parent_id',
        'documents.birth_notice',
        'documents.marriage_certificate',
      ],
      processingTimeKey: 'processing.birth_certificate',
      instructionKeys: [
        'instructions.parent_presence',
        'instructions.bring_originals',
        'instructions.use_correct_phone',
      ],
    ),
    KebeleService(
      id: 'marriage_certificate',
      icon: Icons.favorite_border,
      titleKey: 'services.marriage_certificate.title',
      shortDescriptionKey: 'services.marriage_certificate.short',
      fullDescriptionKey: 'services.marriage_certificate.full',
      documentKeys: [
        'documents.couple_ids',
        'documents.witness_ids',
        'documents.photos',
      ],
      processingTimeKey: 'processing.marriage_certificate',
      instructionKeys: [
        'instructions.couple_presence',
        'instructions.witness_presence',
        'instructions.bring_originals',
      ],
    ),
    KebeleService(
      id: 'death_certificate',
      icon: Icons.description_outlined,
      titleKey: 'services.death_certificate.title',
      shortDescriptionKey: 'services.death_certificate.short',
      fullDescriptionKey: 'services.death_certificate.full',
      documentKeys: [
        'documents.medical_notice',
        'documents.family_id',
        'documents.residence_letter',
      ],
      processingTimeKey: 'processing.death_certificate',
      instructionKeys: [
        'instructions.family_presence',
        'instructions.bring_originals',
        'instructions.use_correct_phone',
      ],
    ),
  ];

  static KebeleService byId(String id) {
    return services.firstWhere((service) => service.id == id);
  }
}
