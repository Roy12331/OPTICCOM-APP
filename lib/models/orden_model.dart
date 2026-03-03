class OrdenTrabajo {
  final int idOrden;
  final String cliente;
  final String direccion;
  final String distrito;
  final String tipoTrabajo;
  final String fecha;
  final String telefono;
  final String prioridad;
  final String? coordenadas;
  final String estado;
  final String plan;
  final String motivoAveria;
  OrdenTrabajo({
    required this.idOrden,
    required this.cliente,
    required this.direccion,
    required this.distrito,
    required this.tipoTrabajo,
    required this.fecha,
    required this.telefono,
    required this.prioridad,
    this.coordenadas,
    required this.estado,
    required this.plan,
    required this.motivoAveria,
  });
  factory OrdenTrabajo.fromJson(Map<String, dynamic> json) {
    return OrdenTrabajo(
      idOrden: json['id_orden'] ?? 0,
      cliente:
          json['cliente_completo'] ??
          json['nombre_cliente'] ??
          'Cliente Desconocido',
      direccion:
          json['direccion_calle'] ?? json['direccion'] ?? 'Sin dirección',
      distrito: json['distrito'] ?? '-',
      tipoTrabajo: json['tipo_trabajo'] ?? 'Servicio',
      fecha: json['fecha_programada'] ?? '',
      telefono: json['telefono'] ?? '',
      prioridad: json['prioridad'] ?? 'Media',
      coordenadas: json['coordenadas_gps'] ?? json['location_link'],
      estado: json['estado_orden'] ?? 'Pendiente',
      plan: json['nombre_plan'] ?? json['plan'] ?? 'Plan Básico',
      motivoAveria:
          json['observaciones_despacho'] ?? 'Sin detalles del problema',
    );
  }
}
