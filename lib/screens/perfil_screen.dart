import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// Aquí podrías llamar a una API para obtener datos frescos del técnico si quisieras
// Por ahora usaremos datos estáticos o pasados, simulando un perfil real.

class PerfilScreen extends StatelessWidget {
  final int idTecnico;
  const PerfilScreen({super.key, required this.idTecnico});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Perfil"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            // Avatar Grande
            const CircleAvatar(
              radius: 60,
              backgroundColor: Color(0xFFFF9800),
              child: Icon(Icons.person, size: 70, color: Colors.white),
            ),
            const SizedBox(height: 20),

            // Nombre del Técnico (Simulado, idealmente vendría de una API o SharedPreferences)
            const Text(
              "Técnico Opticcom",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "ID: #$idTecnico",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 40),

            // Opciones de Menú
            _opcionPerfil(Icons.settings, "Configuración", () {}),
            _opcionPerfil(Icons.help, "Ayuda y Soporte", () {}),

            const Divider(height: 40),

            // Botón Cerrar Sesión
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Aquí podrías borrar tokens o datos locales
                    context.go('/'); // Volver al Login
                  },
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text(
                    "CERRAR SESIÓN",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Versión 5.0.1", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _opcionPerfil(IconData icon, String titulo, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.black54),
      ),
      title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}
