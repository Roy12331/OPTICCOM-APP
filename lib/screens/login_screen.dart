import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/login_service.dart'; // 🔹 Importación corregida

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
    setState(() => _loading = true);

    final resp = await LoginService.login(
      _emailCtrl.text.trim(),
      _passCtrl.text.trim(),
    );

    if (mounted) {
      setState(() => _loading = false);
      if (resp['success'] == true) {
        final usuario = resp['usuario'];

        final int idUser = int.tryParse(usuario['id_usuario'].toString()) ?? 0;
        final String nombreUser = usuario['nombre'] ?? 'Técnico';

        context.go('/home', extra: {'id': idUser, 'nombre': nombreUser});
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
        ),
      ),
    );
  }

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
}
