import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sales_car/user/model/user_model.dart';
import 'package:sales_car/user/service/user_service.dart';
import 'package:sales_car/vendedor/model/vendedor_login_model.dart';
import 'package:sales_car/vendedor/model/vendedor_model.dart';
import 'package:sales_car/vendedor/service/vendedor_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final AuthService authService = AuthService();

  String? errorMessage;

  Future<void> login() async {
    String email = emailController.text.trim();
    String senha = senhaController.text.trim();

    setState(() => errorMessage = null);

    User? loggedUser = await authService.login(email, senha);

    if (loggedUser != null) {
      switch (loggedUser.tipo.toLowerCase()) {
        case 'vendedor':
          Navigator.pushReplacementNamed(context, '/vendedor');
          break;
        case 'admin':
          Navigator.pushReplacementNamed(context, '/admin');
          break;
        case 'cliente':
          Navigator.pushReplacementNamed(context, '/cliente');
          break;
        default:
          setState(() {
            errorMessage = 'Tipo de usuário inválido ou não autorizado.';
          });
          return;
      }
    } else {
      setState(() {
        errorMessage = 'Email ou senha inválidos';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Compre Mais',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          const SizedBox(height: 32),
          Container(
            width: 400,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                'Login',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: senhaController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha'),
              ),
              if (errorMessage != null) ...[
                const SizedBox(height: 8),
                Text(errorMessage!, style: const TextStyle(color: Colors.red)),
              ],
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: login,
                child: const Text('Entrar'),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
