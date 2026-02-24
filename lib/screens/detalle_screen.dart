import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart'; // Asegúrate de haber ejecutado: flutter pub add url_launcher
import '../models/orden_model.dart';

class DetalleScreen extends StatelessWidget {
  final OrdenTrabajo orden;
  const DetalleScreen({super.key, required this.orden});

  // FUNCIÓN PARA ABRIR GPS
  Future<void> _abrirMapa(BuildContext context) async {
    // Validamos que haya coordenadas
    if (orden.coordenadas == null || orden.coordenadas!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Este cliente no tiene coordenadas GPS registadas"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Creamos la URL universal de Google Maps (funciona en Android y iOS)
    // Formato esperado de coordenadas: "-12.06513,-75.20486" (Lat,Long sin espacios)
    final googleMapsUrl = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=${orden.coordenadas}",
    );

    try {
      // Intentamos abrir la aplicación externa (Maps/Waze)
      if (await canLaunchUrl(googleMapsUrl)) {
        await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
      } else {
        throw 'No se pudo abrir el mapa';
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error al abrir mapa: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del Trabajo"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // 1. BANNER DEL MAPA (Simulado visualmente)
          Container(
            height: 180,
            width: double.infinity,
            color: Colors.grey[200],
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on, size: 50, color: Colors.red),
                    const SizedBox(height: 10),
                    Text(
                      orden.coordenadas ?? "Sin GPS",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
                // Botón flotante encima del mapa
                Positioned(
                  bottom: 20,
                  child: ElevatedButton.icon(
                    onPressed: () => _abrirMapa(context),
                    icon: const Icon(Icons.navigation, color: Colors.white),
                    label: const Text(
                      "IR CON GPS",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. INFORMACIÓN DEL CLIENTE
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Información del Cliente",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),

                  _filaDato(Icons.person, "Cliente", orden.cliente),
                  _filaDato(
                    Icons.phone,
                    "Teléfono",
                    orden.telefono.isNotEmpty
                        ? orden.telefono
                        : "No registrado",
                  ),
                  _filaDato(Icons.map, "Distrito", orden.distrito),
                  _filaDato(Icons.home, "Dirección", orden.direccion),
                  _filaDato(
                    Icons.calendar_today,
                    "Fecha Programada",
                    orden.fecha,
                  ),

                  const Divider(height: 40),

                  // 3. BOTÓN DE ACCIÓN (INICIAR)
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navegamos al formulario pasando la orden
                        context.push('/formulario', extra: orden);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                          0xFFFF9800,
                        ), // Naranja Opticcom
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 4,
                      ),
                      child: const Text(
                        "INICIAR INSTALACIÓN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para las filas de datos
  Widget _filaDato(IconData icon, String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFFFF9800), size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  valor,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
