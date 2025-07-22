import 'package:flutter/material.dart';
import 'package:sales_car/cliente/model/cliente_model.dart';
import 'package:sales_car/cliente/service/cliente_service.dart';

class ClientesPage extends StatefulWidget {
  const ClientesPage({Key? key}) : super(key: key);

  @override
  State<ClientesPage> createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  final ClienteService clienteService = ClienteService();
  late Future<List<Cliente>> futureClientes;

  @override
  void initState() {
    super.initState();
    futureClientes = clienteService.listarClientes();
  }

  void _deletarCliente(int id) async {
    try {
      await clienteService.deletarCliente(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cliente deletado com sucesso')),
      );
      setState(() {
        futureClientes = clienteService.listarClientes();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao deletar cliente: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Clientes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cadastro-cliente').then((value) {
                    // Atualiza a lista quando voltar da tela de cadastro
                    setState(() {
                      futureClientes = clienteService.listarClientes();
                    });
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Novo Cliente',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Cliente>>(
              future: futureClientes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nenhum cliente cadastrado'));
                }

                final clientes = snapshot.data!;
                return ListView.builder(
                  itemCount: clientes.length,
                  itemBuilder: (context, index) {
                    final cliente = clientes[index];
                    return ListTile(
                      title: Text(cliente.nome),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email: ${cliente.email}'),
                          Text('Telefone: ${cliente.telefone ?? 'Não informado'}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deletarCliente(cliente.id!),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
