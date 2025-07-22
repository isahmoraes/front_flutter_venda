import 'package:flutter/material.dart';
import 'package:sales_car/vendedor/model/vendedor_model.dart';
import 'package:sales_car/vendedor/service/vendedor_service.dart';

class CadastroVendedorPage extends StatefulWidget {
  const CadastroVendedorPage({super.key});

  @override
  State<CadastroVendedorPage> createState() => _CadastroVendedorPageState();
}

class _CadastroVendedorPageState extends State<CadastroVendedorPage> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final salarioController = TextEditingController();
  final comissaoController = TextEditingController();
  final senhaController = TextEditingController();
  final cpfController = TextEditingController();
  final rgController = TextEditingController();
  final telefoneController = TextEditingController();
  final enderecoController = TextEditingController();
  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    salarioController.dispose();
    comissaoController.dispose();
    senhaController.dispose();
    cpfController.dispose();
    rgController.dispose();
    telefoneController.dispose();
    enderecoController.dispose();
    super.dispose();
  }

  Future<void> salvarVendedor() async {
    final nome = nomeController.text.trim();
    final email = emailController.text.trim();
    final salario = double.tryParse(salarioController.text.trim()) ?? 0;
    final comissao = double.tryParse(comissaoController.text.trim()) ?? 0;
    final senha = senhaController.text.trim();
     final cpf = cpfController.text.trim();
    final rg = rgController.text.trim();
    final telefone = telefoneController.text.trim();
    final endereco = enderecoController.text.trim();

    if (nome.isEmpty || email.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha nome, email e senha')),
      );
      return;
    }

    print('Vendedor cadastrado:');
    print('Nome: $nome');
    print('Email: $email');
    print('Salário: $salario');
    print('Comissão: $comissao');
    print('Senha: $senha');
    final vendedor = Vendedor(
      nome: nome,
      email: email,
      salario: salario,
      comissao: comissao,
      senha: senha, 
     cpf: cpf,
      rg: rg,
      telefone: telefone,
      endereco: endereco,
      
      // preencha os demais campos se houver
    );
  bool sucesso = await VendedorService().cadastrar(vendedor);

   if (sucesso) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Vendedor cadastrado com sucesso!')),
  );

  // Volta para a tela de listagem
  Navigator.pushReplacementNamed(context, '/list-vendedor');

} else {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Erro ao cadastrar vendedor')),
  );

    // Opcional: limpar os campos após salvar
     nomeController.clear();
      emailController.clear();
      salarioController.clear();
      comissaoController.clear();
      senhaController.clear();
      cpfController.clear();
      rgController.clear();
      telefoneController.clear();
      enderecoController.clear();
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Vendedor')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(controller: nomeController, decoration: const InputDecoration(labelText: 'Nome')),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: cpfController, decoration: const InputDecoration(labelText: 'CPF')),
            TextField(controller: rgController, decoration: const InputDecoration(labelText: 'RG')),
            TextField(controller: telefoneController, decoration: const InputDecoration(labelText: 'Telefone')),
            TextField(controller: enderecoController, decoration: const InputDecoration(labelText: 'Endereço')),
            TextField(controller: senhaController, decoration: const InputDecoration(labelText: 'Senha'), obscureText: true),
            TextField(controller: salarioController, decoration: const InputDecoration(labelText: 'Salário'), keyboardType: TextInputType.number),
            TextField(controller: comissaoController, decoration: const InputDecoration(labelText: 'Comissão'), keyboardType: TextInputType.number),
           
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: salvarVendedor,
              child: const Text('Cadastrar'),
            )
          ],
        ),
      ),
    );
  }
}
