import 'package:flutter/material.dart';
import '../models/orden_model.dart';
<<<<<<< HEAD
import '../services/historial_service.dart'; // 🔹 Importación del nuevo servicio separado
=======
import '../services/api_service.dart';
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50

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
<<<<<<< HEAD
    // 🔹 Llamada al nuevo servicio exclusivo para historial
    _futureOrdenes = HistorialService.getHistorial(widget.idTecnico);
=======
    // NOTA: Idealmente crearías un endpoint 'get_historial.php' que traiga WHERE estado = 'Finalizado'
    // Aquí reutilizamos el endpoint actual. Si tu endpoint actual solo trae pendientes,
    // necesitarás modificar el PHP para aceptar un parámetro ?estado=todos o similar.
    _futureOrdenes = ApiService.getOrdenes(widget.idTecnico);
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      backgroundColor: Colors.white, // 🔹 Fondo blanco estilo Figma
      appBar: AppBar(
        title: const Text(
          "Historial de Trabajos",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
=======
      appBar: AppBar(title: const Text("Historial de Trabajos")),
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
      body: FutureBuilder<List<OrdenTrabajo>>(
        future: _futureOrdenes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
<<<<<<< HEAD
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // 🔹 Pantalla vacía mejorada
=======
          } else if (!snapshot.hasData) {
            return const Center(child: Text("Sin datos"));
          }

          // Filtramos localmente los Finalizados (si tu API los trajera todos)
          // Si tu API actual solo trae 'Pendientes', esta lista estará vacía hasta que edites el PHP.
          // Para prueba visual, mostremos todos pero con un icono de "Check".
          final ordenes = snapshot.data!;

          if (ordenes.isEmpty) {
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history_toggle_off, size: 60, color: Colors.grey),
                  SizedBox(height: 10),
<<<<<<< HEAD
                  Text(
                    "No hay trabajos finalizados recientes",
                    style: TextStyle(color: Colors.grey),
                  ),
=======
                  Text("No hay trabajos finalizados recientes"),
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
                ],
              ),
            );
          }

<<<<<<< HEAD
          final ordenes = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: ordenes.length,
            itemBuilder: (context, index) {
              final orden = ordenes[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
=======
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
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
                  leading: const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(Icons.check, color: Colors.white),
                  ),
                  title: Text(
                    orden.tipoTrabajo,
<<<<<<< HEAD
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      "Cliente: ${orden.cliente}\nFinalizado el: ${orden.fecha}",
                      style: TextStyle(color: Colors.grey[600], height: 1.4),
                    ),
=======
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "${orden.cliente}\nFinalizado el: ${orden.fecha}",
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
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
