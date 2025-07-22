import 'package:flutter/material.dart';

class VendedorHomePage extends StatefulWidget {
  const VendedorHomePage({super.key});

  @override
  State<VendedorHomePage> createState() => _VendedorHomePageState();
}

class _VendedorHomePageState extends State<VendedorHomePage> {
  List<Map<String, dynamic>> vendas = [
    {
      'cliente': 'João da Silva',
      'veiculo': 'Onix 2022',
      'categoria': 'Sedan',
      'valor': 70000.0,
    },
    {
      'cliente': 'Maria Oliveira',
      'veiculo': 'HB20 2021',
      'categoria': 'Hatch',
      'valor': 62000.0,
    },
    {
      'cliente': 'Carlos Pereira',
      'veiculo': 'Toro 2020',
      'categoria': 'Pickup',
      'valor': 98000.0,
    },
  ];

  void removerVenda(int index) {
    setState(() {
      vendas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Área do Vendedor'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Bem-vindo, Vendedor!',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child: Wrap(
                spacing: 12,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/vendas');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      'Gerenciar Vendas',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cliente');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      'Visualizar Clientes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/veiculos');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      'Visualizar Veículos',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Suas Vendas Recentes:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: vendas.length,
              itemBuilder: (context, index) {
                final venda = vendas[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    title: Text("Cliente: ${venda['cliente']}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Veículo: ${venda['veiculo']}"),
                        Text("Categoria: ${venda['categoria']}"),
                        Text(
                            "Valor: R\$ ${venda['valor'].toStringAsFixed(2)}"),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => removerVenda(index),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
