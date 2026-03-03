class OrdenTrabajo {
  final int idOrden;
  final String cliente;
  final String direccion;
  final String distrito;
  final String tipoTrabajo;
  final String fecha;
  final String telefono;
  final String prioridad;
<<<<<<< HEAD
  final String? coordenadas;
  final String estado;
  final String plan;
  final String motivoAveria;
=======
  final String? coordenadas; // Puede venir null desde BD
  final String estado;

>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
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
<<<<<<< HEAD
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
=======
  });

  factory OrdenTrabajo.fromJson(Map<String, dynamic> json) {
    return OrdenTrabajo(
      idOrden: json['id_orden'],
      cliente: json['nombre_cliente'] ?? 'Cliente',
      direccion: json['direccion'] ?? 'Sin dirección',
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
      distrito: json['distrito'] ?? '-',
      tipoTrabajo: json['tipo_trabajo'] ?? 'Servicio',
      fecha: json['fecha_programada'] ?? '',
      telefono: json['telefono'] ?? '',
      prioridad: json['prioridad'] ?? 'Media',
<<<<<<< HEAD
      coordenadas: json['coordenadas_gps'] ?? json['location_link'],
      estado: json['estado_orden'] ?? 'Pendiente',
      plan: json['nombre_plan'] ?? json['plan'] ?? 'Plan Básico',
      motivoAveria:
          json['observaciones_despacho'] ?? 'Sin detalles del problema',
=======
      coordenadas:
          json['coordenadas_gps'], // Debe coincidir con el alias en PHP
      estado: json['estado_orden'] ?? 'Pendiente',
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
    );
  }
}
