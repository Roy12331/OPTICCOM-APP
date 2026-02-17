class OrdenTrabajo {
  final int idOrden;
  final String cliente;
  final String direccion;
  final String distrito;
  final String tipoTrabajo;
  final String fecha;
  final String telefono;
  final String prioridad;
  final String? coordenadas; // Puede venir null desde BD
  final String estado;

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
  });

  factory OrdenTrabajo.fromJson(Map<String, dynamic> json) {
    return OrdenTrabajo(
      idOrden: json['id_orden'],
      cliente: json['nombre_cliente'] ?? 'Cliente',
      direccion: json['direccion'] ?? 'Sin dirección',
      distrito: json['distrito'] ?? '-',
      tipoTrabajo: json['tipo_trabajo'] ?? 'Servicio',
      fecha: json['fecha_programada'] ?? '',
      telefono: json['telefono'] ?? '',
      prioridad: json['prioridad'] ?? 'Media',
      coordenadas:
          json['coordenadas_gps'], // Debe coincidir con el alias en PHP
      estado: json['estado_orden'] ?? 'Pendiente',
    );
  }
}
