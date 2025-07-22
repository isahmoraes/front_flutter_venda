import 'package:flutter/material.dart';
import 'package:sales_car/cliente/model/cliente_model.dart';
import 'package:sales_car/cliente/service/cliente_service.dart';



class CadastroClientePage extends StatefulWidget {
  const CadastroClientePage({super.key});

  @override
  State<CadastroClientePage> createState() => _CadastroClientePageState();
}

class _CadastroClientePageState extends State<CadastroClientePage> {
  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final cpfController = TextEditingController();
  final rgController = TextEditingController();
  final enderecoController = TextEditingController();
  final telefoneController = TextEditingController();
  final emailController = TextEditingController();
  final referenciaController = TextEditingController();
  final dataNascimentoController = TextEditingController();

  bool isSaving = false;

  Future<void> salvarCliente() async {
  final dataTexto = dataNascimentoController.text.trim();

  DateTime? dataNascimento;
  try {
    dataNascimento = DateTime.parse(dataTexto);
  } catch (e) {
    // Exibir erro para usuário
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Formato de data inválido')),
    );
    return;
  }

  final novoCliente = Cliente(
   
    referenciaComercial: referenciaController.text.trim(),
    dataNascimento: dataNascimento,  // agora é DateTime
    nome: nomeController.text.trim(),
    cpf: cpfController.text.trim(),
    rg: rgController.text.trim(),
    endereco: enderecoController.text.trim(),
    telefone: telefoneController.text.trim(),
    email: emailController.text.trim(),
  );

  try {
    final clienteCadastrado = await ClienteService().cadastrar(novoCliente);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cliente cadastrado com sucesso!')),
    );

    Navigator.pop(context, clienteCadastrado);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro ao cadastrar cliente: $e')),
    );
  } finally {
    setState(() {
      isSaving = false;
    });
  }
}


  @override
  void dispose() {
    nomeController.dispose();
    cpfController.dispose();
    rgController.dispose();
    enderecoController.dispose();
    telefoneController.dispose();
    emailController.dispose();
    referenciaController.dispose();
    dataNascimentoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Cliente')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) => value == null || value.isEmpty ? 'Informe o nome' : null,
              ),
              TextFormField(
                controller: cpfController,
                decoration: const InputDecoration(labelText: 'CPF'),
                validator: (value) => value == null || value.isEmpty ? 'Informe o CPF' : null,
              ),
              TextFormField(
                controller: rgController,
                decoration: const InputDecoration(labelText: 'RG'),
                validator: (value) => value == null || value.isEmpty ? 'Informe o RG' : null,
              ),
              TextFormField(
                controller: enderecoController,
                decoration: const InputDecoration(labelText: 'Endereço'),
                validator: (value) => value == null || value.isEmpty ? 'Informe o endereço' : null,
              ),
              TextFormField(
                controller: telefoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
                validator: (value) => value == null || value.isEmpty ? 'Informe o telefone' : null,
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Informe o email';
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) return 'Email inválido';
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: referenciaController,
                decoration: const InputDecoration(labelText: 'Referência Comercial'),
                validator: (value) => value == null || value.isEmpty ? 'Informe a referência comercial' : null,
              ),
              TextFormField(
                controller: dataNascimentoController,
                decoration: const InputDecoration(labelText: 'Data de Nascimento (dd/mm/yyyy)'),
                validator: (value) => value == null || value.isEmpty ? 'Informe a data de nascimento' : null,
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 20),
              isSaving
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: salvarCliente,
                      child: const Text('Cadastrar'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
