import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sales_car/venda/service/venda_service.dart';
import 'package:sales_car/vendedor/model/vendedor_model.dart';
import 'package:sales_car/vendedor/service/vendedor_service.dart';

class VendedorListPage extends StatefulWidget {
  const VendedorListPage({Key? key}) : super(key: key);

  @override
  State<VendedorListPage> createState() => _VendedorListPageState();
}

class _VendedorListPageState extends State<VendedorListPage> {
  List<Vendedor> vendedores = [];
  bool isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchVendedores();
  }

  Future<void> fetchVendedores() async {
    try {
    final lista = await VendedorService().fetchVendedores();
    setState(() {
      vendedores = lista;
      isLoading = false;
    });
  } catch (e) {
    setState(() {
      error = e.toString();
      isLoading = false;
    });
  }
}

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Lista de Vendedores'),
    ),
    body: Column(
      children: [
        // Botão alinhado à direita
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/cadastro-vendedor')
                      .then((_) {
                        // Atualiza a lista quando voltar da tela de cadastro
                        fetchVendedores();
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
                    'Novo Vendedor',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Lista expandida para ocupar o espaço restante
        Expanded(
          child: RefreshIndicator(
            onRefresh: fetchVendedores,
            child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : error != null
                ? Center(child: Text(error!))
                : ListView.builder(
                    itemCount: vendedores.length,
                    itemBuilder: (context, index) {
                      final vendedor = vendedores[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    child: Text(vendedor.nome[0].toUpperCase()),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          vendedor.nome,
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                        Text(vendedor.email?? 'Nao informado'),
                                        Text('Telefone: ${vendedor.telefone ?? 'Não informado'}'),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () async {
                                      final confirm = await showDialog<bool>(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: const Text('Confirmar exclusão'),
                                          content: const Text('Deseja excluir este vendedor?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(context, false),
                                              child: const Text('Cancelar'),
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.pop(context, true),
                                              child: const Text('Excluir'),
                                            ),
                                          ],
                                        ),
                                      );

                                      if (confirm == true) {
                                        await VendedorService().excluirVendedor(vendedor.id!);
                                        fetchVendedores();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Vendedor excluído com sucesso')),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    ),
  );
}
}