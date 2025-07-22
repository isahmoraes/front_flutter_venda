
import 'package:flutter/material.dart';
import 'package:sales_car/categoria/model/categoria_model.dart';
import 'package:sales_car/categoria/page/categoria_page.dart';
import 'package:sales_car/categoria/service/categoria_service.dart';

class CategoriaListPage extends StatefulWidget {
  const CategoriaListPage({super.key});

  @override
  State<CategoriaListPage> createState() => _CategoriaListPageState();
}

class _CategoriaListPageState extends State<CategoriaListPage> {
  List<Categoria> categorias = [];
  bool isLoading = true;
  String? erro;

  @override
  void initState() {
    super.initState();
    carregarCategorias();
  }

  Future<void> carregarCategorias() async {
    setState(() {
      isLoading = true;
      erro = null;
    });

    try {
      final lista = await CategoriaService().listar();
      setState(() {
        categorias = lista;
      });
    } catch (e) {
      setState(() {
        erro = 'Erro ao carregar categorias.';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> abrirCadastro() async {
    final novaCategoria = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CategoriaCadastroPage()),
    );

    if (novaCategoria != null) {
      await carregarCategorias(); // recarrega após o retorno
    }
  }

  void abrirVeiculos() {
    Navigator.pushNamed(context, '/veiculos');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categorias')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: abrirCadastro,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Nova Categoria', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: abrirVeiculos,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Veículos', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : erro != null
                      ? Center(child: Text(erro!))
                      : categorias.isEmpty
                          ? const Center(child: Text('Nenhuma categoria cadastrada.'))
                          : ListView.builder(
                              itemCount: categorias.length,
                              itemBuilder: (context, index) {
                                final cat = categorias[index];
                                return ListTile(
                                  leading: const Icon(Icons.category),
                                  title: Text(cat.descricao),
                                  subtitle: Text('ID: ${cat.id}\n${cat.descricao}'),
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
