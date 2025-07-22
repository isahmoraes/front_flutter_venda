import 'package:flutter/material.dart';
import 'package:sales_car/categoria/model/categoria_model.dart';
import 'package:sales_car/categoria/service/categoria_service.dart';

class CategoriaCadastroPage extends StatefulWidget {
  const CategoriaCadastroPage({super.key});

  @override
  State<CategoriaCadastroPage> createState() => _CategoriaCadastroPageState();
}

class _CategoriaCadastroPageState extends State<CategoriaCadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  bool isSaving = false;

  Future<void> salvarCategoria() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isSaving = true);

    final nome = nomeController.text.trim();
    final descricao = descricaoController.text.trim();

    try {
      final novaCategoria = await CategoriaService().cadastrar(
        Categoria(id: 0,  descricao: descricao),
      );

      Navigator.pop(context, novaCategoria); // ✅ retorna a nova categoria
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar categoria: $e')),
      );
    } finally {
      setState(() => isSaving = false);
    }
  }

  @override
  void dispose() {
    nomeController.dispose();
    descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Categoria')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome da Categoria'),
                validator: (value) => value == null || value.isEmpty ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                validator: (value) => value == null || value.isEmpty ? 'Informe a descrição' : null,
              ),
              const SizedBox(height: 20),
              isSaving
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: salvarCategoria,
                      child: const Text('Salvar'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
