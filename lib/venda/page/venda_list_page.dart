// lib/pages/vendedor/vendas_list_page.dart

import 'package:flutter/material.dart';
import 'package:sales_car/venda/model/venda_model.dart';
import 'package:sales_car/venda/service/venda_service.dart';

class VendasListPage extends StatefulWidget {
  const VendasListPage({super.key});

  @override
  State<VendasListPage> createState() => _VendasListPageState();
}

class _VendasListPageState extends State<VendasListPage> {
  late Future<List<Venda>> vendasFuture;

  @override
  void initState() {
    super.initState();
    vendasFuture = VendaService().listar(); // Chama o método para listar as vendas
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Vendas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/nova-venda');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Nova Venda', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Venda>>(
                future: vendasFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Nenhuma venda registrada.'));
                  } else {
                    final vendas = snapshot.data!;
                    return ListView.builder(
                      itemCount: vendas.length,
                      itemBuilder: (context, index) {
                        final venda = vendas[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              '${venda.veiculo.modelo} - ${venda.cliente.nome}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Data: ${venda.data.toString().split(' ')[0]}\n'
                              'Desconto: R\$ ${venda.valorDesconto.toStringAsFixed(2)}',
                            ),
                            trailing: Text(
                              'R\$ ${venda.valorTotal.toStringAsFixed(2)}',
                              style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}