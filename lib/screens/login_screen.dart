import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
<<<<<<< HEAD
import '../services/login_service.dart'; // 🔹 Importación corregida
=======
import '../services/api_service.dart';
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false;

  void _login() async {
    if (_emailCtrl.text.isEmpty || _passCtrl.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Complete los campos")));
      return;
    }
<<<<<<< HEAD
    setState(() => _loading = true);

    final resp = await LoginService.login(
=======

    setState(() => _loading = true);

    final resp = await ApiService.login(
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
      _emailCtrl.text.trim(),
      _passCtrl.text.trim(),
    );

    if (mounted) {
      setState(() => _loading = false);
      if (resp['success'] == true) {
<<<<<<< HEAD
        final usuario = resp['usuario'];

        final int idUser = int.tryParse(usuario['id_usuario'].toString()) ?? 0;
        final String nombreUser = usuario['nombre'] ?? 'Técnico';

        context.go('/home', extra: {'id': idUser, 'nombre': nombreUser});
=======
        // Obtenemos ID y Nombre del usuario
        final usuario = resp['usuario'];
        final int idUser =
            usuario['id_usuario']; // Asegúrate que tu PHP devuelve int

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Bienvenido ${usuario['nombre']}")),
        );
        context.go('/home', extra: idUser);
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(resp['mensaje']), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF9800),
<<<<<<< HEAD
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Iniciar Sesión",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 40),

              const Text(
                "Correo Corporativo",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              _inputBox(_emailCtrl, "tecnico@opticcom.com", false),

              const SizedBox(height: 20),

              const Text(
                "Contraseña",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              _inputBox(_passCtrl, "******", true),

              const SizedBox(height: 40),

              _loading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    )
                  : SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "INGRESAR",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

              const Spacer(),
              const Center(
                child: Column(
                  children: [
                    Icon(Icons.cable, size: 40, color: Colors.black26),
                    Text(
                      "OPTICCOM",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black26,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      "S.A.C",
                      style: TextStyle(fontSize: 12, color: Colors.black26),
                    ),
                  ],
                ),
              ),
            ],
          ),
=======
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.router, size: 80, color: Colors.white),
            const Text(
              "OPTICCOM",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Correo Técnico",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passCtrl,
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Contraseña",
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),
            _loading
                ? const CircularProgressIndicator(color: Colors.white)
                : SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        "INGRESAR",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
          ],
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
        ),
      ),
    );
  }
<<<<<<< HEAD

  Widget _inputBox(TextEditingController ctrl, String hint, bool isPass) {
    return TextField(
      controller: ctrl,
      obscureText: isPass,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54),
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
      ),
    );
  }
=======
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
}
