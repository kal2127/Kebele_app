enum AppointmentStatus { active, cancelled }

class Appointment {
  const Appointment({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.serviceId,
    required this.serviceTitleKey,
    required this.appointmentDate,
    required this.createdAt,
    this.status = AppointmentStatus.active,
  });

  final String id;
  final String fullName;
  final String phoneNumber;
  final String serviceId;
  final String serviceTitleKey;
  final DateTime appointmentDate;
  final DateTime createdAt;
  final AppointmentStatus status;

  Appointment copyWith({
    String? phoneNumber,
    DateTime? appointmentDate,
    AppointmentStatus? status,
  }) {
    return Appointment(
      id: id,
      fullName: fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      serviceId: serviceId,
      serviceTitleKey: serviceTitleKey,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      createdAt: createdAt,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'serviceId': serviceId,
      'serviceTitleKey': serviceTitleKey,
      'appointmentDate': appointmentDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'status': status.name,
    };
  }

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      serviceId: json['serviceId'] as String,
      serviceTitleKey: json['serviceTitleKey'] as String,
      appointmentDate: DateTime.parse(json['appointmentDate'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: (json['status'] as String?) == AppointmentStatus.cancelled.name
          ? AppointmentStatus.cancelled
          : AppointmentStatus.active,
    );
  }
}
