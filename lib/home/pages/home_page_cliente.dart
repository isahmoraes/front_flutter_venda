import 'package:flutter/material.dart';
import 'package:sales_car/venda/model/venda_model.dart';


class ClienteHomePage extends StatelessWidget {
  final String nomeCliente;
  final List<Venda> vendas;

  const ClienteHomePage({
    Key? key,
    required this.nomeCliente,
    required this.vendas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: Text('Área do Cliente'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bem-vindo, $nomeCliente!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: vendas.isEmpty
                  ? Center(
                      child: Text(
                        'Você ainda não realizou nenhuma compra.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: vendas.length,
                      itemBuilder: (context, index) {
                        final venda = vendas[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            title: Text(
                              '${venda.veiculo.modelo} - ${venda.veiculo.categoria}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text(
                              'Vendedor: ${venda.vendedor.nome}\nValor: R\$ ${venda.veiculo.valor.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/veiculos');
                  },
                  child: const Text('Ver Veículos Disponíveis'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/financiamento');
                  },
                  child: const Text('Simular Financiamento'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
