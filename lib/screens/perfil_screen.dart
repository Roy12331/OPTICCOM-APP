import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
<<<<<<< HEAD

class PerfilScreen extends StatelessWidget {
  final Map<String, dynamic> userData;
  const PerfilScreen({super.key, required this.userData});
=======
// Aquí podrías llamar a una API para obtener datos frescos del técnico si quisieras
// Por ahora usaremos datos estáticos o pasados, simulando un perfil real.

class PerfilScreen extends StatelessWidget {
  final int idTecnico;
  const PerfilScreen({super.key, required this.idTecnico});
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Mi perfil",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
=======
      appBar: AppBar(
        title: const Text("Mi Perfil"),
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
<<<<<<< HEAD
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[300],
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData['nombre'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "ID: #${userData['id']} - Técnico",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),

            const Text(
              "Estadísticas",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Trabajos completados",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total", style: TextStyle(fontSize: 16)),
                  Text(
                    "25",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "Historial de trabajo",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            _itemHistorial("Orden #1", "Completado el 2026-02-15"),
            _itemHistorial("Orden #2", "Completado el 2026-02-13"),
            _itemHistorial("Orden #56", "Completado el 2026-02-10"),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => context.go('/'),
                child: const Text(
                  "Salir",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
=======
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
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
          ],
        ),
      ),
    );
  }

<<<<<<< HEAD
  Widget _itemHistorial(String titulo, String fecha) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.check_circle, color: Colors.green),
      title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(fecha),
=======
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
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
    );
  }
}
