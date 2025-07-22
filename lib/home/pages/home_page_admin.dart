import 'package:flutter/material.dart';
import 'package:sales_car/cliente/model/cliente_model.dart';
import 'package:sales_car/cliente/service/cliente_service.dart';
import 'package:sales_car/vendedor/model/vendedor_model.dart';
import 'package:sales_car/vendedor/service/vendedor_service.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({super.key});

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  final ClienteService clienteService = ClienteService();
  final VendedorService vendedorService = VendedorService();

  late Future<List<Cliente>> futureClientes;
  late Future<List<Vendedor>> futureVendedores;

  @override
  void initState() {
    super.initState();
    carregarListas();
  }

  void carregarListas() {
    setState(() {
      futureClientes = clienteService.listarClientes();
      futureVendedores = vendedorService.fetchVendedores();
    });
  }

  Future<void> _deletarCliente(int id) async {
    try {
      await clienteService.deletarCliente(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cliente deletado com sucesso')),
      );
      carregarListas();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao deletar cliente: $e')),
      );
    }
  }

  Future<void> _deletarVendedor(int id) async {
    try {
      await vendedorService.excluirVendedor(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vendedor deletado com sucesso')),
      );
      carregarListas();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao deletar vendedor: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CLIENTES
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Clientes', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cadastro-cliente')
                          .then((_) => carregarListas());
                    },
                    child: const Text('Novo Cliente'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              FutureBuilder<List<Cliente>>(
                future: futureClientes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Erro ao carregar clientes: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('Nenhum cliente cadastrado');
                  }

                  final clientes = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: clientes.length,
                    itemBuilder: (context, index) {
                      final cliente = clientes[index];
                      return ListTile(
                        title: Text(cliente.nome),
                        subtitle: Text('Email: ${cliente.email}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deletarCliente(cliente.id!),
                        ),
                      );
                    },
                  );
                },
              ),
              const Divider(height: 40),

              // VENDEDORES
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Vendedores', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cadastro-vendedor')
                          .then((_) => carregarListas());
                    },
                    child: const Text('Novo Vendedor'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              FutureBuilder<List<Vendedor>>(
                future: futureVendedores,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Erro ao carregar vendedores: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('Nenhum vendedor cadastrado');
                  }

                  final vendedores = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: vendedores.length,
                    itemBuilder: (context, index) {
                      final vendedor = vendedores[index];
                      return ListTile(
                        title: Text(vendedor.nome),
                        subtitle: Text('Email: ${vendedor.email}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deletarVendedor(vendedor.id!),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
