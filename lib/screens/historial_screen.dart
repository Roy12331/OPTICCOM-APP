import 'package:flutter/material.dart';
import '../models/orden_model.dart';
import '../services/api_service.dart';

class HistorialScreen extends StatefulWidget {
  final int idTecnico;
  const HistorialScreen({super.key, required this.idTecnico});

  @override
  State<HistorialScreen> createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {
  late Future<List<OrdenTrabajo>> _futureOrdenes;

  @override
  void initState() {
    super.initState();
    // NOTA: Idealmente crearías un endpoint 'get_historial.php' que traiga WHERE estado = 'Finalizado'
    // Aquí reutilizamos el endpoint actual. Si tu endpoint actual solo trae pendientes,
    // necesitarás modificar el PHP para aceptar un parámetro ?estado=todos o similar.
    _futureOrdenes = ApiService.getOrdenes(widget.idTecnico);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Historial de Trabajos")),
      body: FutureBuilder<List<OrdenTrabajo>>(
        future: _futureOrdenes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData) {
            return const Center(child: Text("Sin datos"));
          }

          // Filtramos localmente los Finalizados (si tu API los trajera todos)
          // Si tu API actual solo trae 'Pendientes', esta lista estará vacía hasta que edites el PHP.
          // Para prueba visual, mostremos todos pero con un icono de "Check".
          final ordenes = snapshot.data!;

          if (ordenes.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history_toggle_off, size: 60, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("No hay trabajos finalizados recientes"),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: ordenes.length,
            itemBuilder: (context, index) {
              final orden = ordenes[index];
              return Card(
                elevation: 0,
                color: Colors.grey[100], // Color más apagado para historial
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(Icons.check, color: Colors.white),
                  ),
                  title: Text(
                    orden.tipoTrabajo,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "${orden.cliente}\nFinalizado el: ${orden.fecha}",
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
