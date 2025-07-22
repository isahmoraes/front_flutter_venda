import 'package:flutter/material.dart';
import 'package:sales_car/veiculo/model/veiculo_model.dart';
import 'package:sales_car/veiculo/service/veiculo_service.dart';

class ListagemCarrosPage extends StatefulWidget {
  const ListagemCarrosPage({super.key});

  @override
  State<ListagemCarrosPage> createState() => _ListagemCarrosPageState();
}

class _ListagemCarrosPageState extends State<ListagemCarrosPage> {
  List<Veiculo> listaCarros = [];
  bool isLoading = true;
  String? erro;

  @override
  void initState() {
    super.initState();
    carregarVeiculos();
  }

  Future<void> carregarVeiculos() async {
    try {
      final veiculos = await VeiculoService().listar();
      setState(() {
        listaCarros = veiculos;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        erro = 'Erro ao carregar veículos';
        isLoading = false;
      });
    }
  }

 Future<void> excluirVeiculo(int id) async {
  try {
    await VeiculoService().deletarVeiculo(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Veículo excluído com sucesso')),
    );
    await carregarVeiculos(); // Atualiza a lista após exclusão
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Erro ao excluir veículo')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Veículos Disponíveis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/cadastro-veiculo');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    'Novo Veículo',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/categorias');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    'Categorias',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: erro != null
                  ? Center(child: Text(erro!))
                  : listaCarros.isEmpty
                      ? const Center(
                          child: Text(
                            'Nenhum veículo cadastrado.',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: listaCarros.length,
                          itemBuilder: (context, index) {
                            final veiculo = listaCarros[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                title: Text('${veiculo.nome} ${veiculo.modelo}'),
                                subtitle: Text(
                                    'Ano: ${veiculo.ano} | Cor: ${veiculo.cor}\nValor: R\$ ${veiculo.valor.toStringAsFixed(2)}'),
                                trailing: IconButton(
                                  icon:
                                      const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => excluirVeiculo(veiculo.id!),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
