import 'package:flutter/material.dart';
import 'package:sales_car/user/model/user_model.dart';
import 'package:sales_car/user/service/user_service.dart';


class CadastroUsuarioPage extends StatefulWidget {
  const CadastroUsuarioPage({super.key});

  @override
  State<CadastroUsuarioPage> createState() => _CadastroUsuarioPageState();
}

class _CadastroUsuarioPageState extends State<CadastroUsuarioPage> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final tipoUsuario = ValueNotifier<String>('cliente');
  final AuthService authService = AuthService();

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    tipoUsuario.dispose();
    super.dispose();
  }

  Future<void> cadastrarUsuario() async {
    String email = emailController.text.trim();
    String senha = senhaController.text.trim();
    String tipo = tipoUsuario.value;

    if (email.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos')),
      );
      return;
    }

    User user = User(nome: '', email: email, senha: senha, tipo: tipo);

    bool sucesso = await authService.cadastrarUsuario(user);

    if (sucesso) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário cadastrado com sucesso!')),
      );
      emailController.clear();
      senhaController.clear();
      tipoUsuario.value = 'cliente';
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falha ao cadastrar usuário')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Usuário')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: senhaController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            ValueListenableBuilder<String>(
              valueListenable: tipoUsuario,
              builder: (_, value, __) {
                return DropdownButton<String>(
                  value: value,
                  onChanged: (v) {
                    if (v != null) tipoUsuario.value = v;
                  },
                  items: const [
                    DropdownMenuItem(value: 'cliente', child: Text('Cliente')),
                    DropdownMenuItem(value: 'vendedor', child: Text('Vendedor')),
                    DropdownMenuItem(value: 'vendedor', child: Text('Admin')),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: cadastrarUsuario,
              child: const Text('Cadastrar Usuário'),
            )
          ],
        ),
      ),
    );
  }
}