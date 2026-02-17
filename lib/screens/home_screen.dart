import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/orden_model.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  final int idTecnico;
  const HomeScreen({super.key, required this.idTecnico});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<OrdenTrabajo>> _futureOrdenes;

  @override
  void initState() {
    super.initState();
    _recargar();
  }

  void _recargar() {
    setState(() {
      _futureOrdenes = ApiService.getOrdenes(widget.idTecnico);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Trabajos"),
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: _recargar, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: FutureBuilder<List<OrdenTrabajo>>(
        future: _futureOrdenes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No tienes órdenes asignadas"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final orden = snapshot.data![index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: orden.prioridad == 'Alta'
                        ? Colors.red
                        : Colors.orange,
                    child: Icon(
                      orden.tipoTrabajo == 'Instalacion'
                          ? Icons.fiber_manual_record
                          : Icons.build,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    orden.tipoTrabajo,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(orden.cliente),
                      Text(
                        "📍 ${orden.distrito} - ${orden.direccion}",
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        "📅 ${orden.fecha}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => context.push('/detalle', extra: orden),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
