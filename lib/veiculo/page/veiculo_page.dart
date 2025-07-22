

 import 'package:flutter/material.dart';
import 'package:sales_car/categoria/model/categoria_model.dart';
import 'package:sales_car/categoria/service/categoria_service.dart';
import 'package:sales_car/veiculo/model/veiculo_model.dart';
import 'package:sales_car/veiculo/service/veiculo_service.dart';


class CadastroVeiculoPage extends StatefulWidget {
  const CadastroVeiculoPage({super.key});

  @override
  State<CadastroVeiculoPage> createState() => _CadastroVeiculoPageState();
}

class _CadastroVeiculoPageState extends State<CadastroVeiculoPage> {
  final _formKey = GlobalKey<FormState>();

  String nome = '';
  String modelo = '';
  String cor = '';
  String ano = '2022';
  String placa = '';
  double valor = 0.0;
  bool unicoDono = false;

  List<Categoria> categorias = [];
  Categoria? categoriaSelecionada;

  bool isLoadingCategorias = true;
  String? erroCategorias;

  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    carregarCategorias();
  }

  Future<void> carregarCategorias() async {
    try {
      final lista = await CategoriaService().listar();
      setState(() {
        categorias = lista;
        isLoadingCategorias = false;
      });
    } catch (e) {
      setState(() {
        erroCategorias = 'Erro ao carregar categorias';
        isLoadingCategorias = false;
      });
    }
  }

 Future<void> salvarVeiculo() async {
  if (!_formKey.currentState!.validate()) return;

  if (categoriaSelecionada == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Selecione uma categoria')),
    );
    return;
  }

  setState(() => isSaving = true);

  try {
    final novoVeiculo = Veiculo(
    
      nome: nome,
      modelo: modelo,
      cor: cor,
      ano: ano,
      placa: placa,
      unicoDono: unicoDono,
      valor: valor,
      categoria: categoriaSelecionada!,
    );

    final veiculoCadastrado = await VeiculoService().cadastrar(novoVeiculo);

    setState(() => isSaving = false);

    Navigator.pop(context, veiculoCadastrado);
  } catch (e) {
    setState(() => isSaving = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro ao salvar veículo: $e')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Veículo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoadingCategorias
            ? const Center(child: CircularProgressIndicator())
            : erroCategorias != null
                ? Center(child: Text(erroCategorias!))
                : Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Marca'),
                          onChanged: (value) => nome = value,
                          validator: (value) =>
                              value!.isEmpty ? 'Informe a marca' : null,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Modelo'),
                          onChanged: (value) => modelo = value,
                          validator: (value) =>
                              value!.isEmpty ? 'Informe o modelo' : null,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Cor'),
                          onChanged: (value) => cor = value,
                        ),
                                    TextFormField(
                decoration: const InputDecoration(labelText: 'Ano'),
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() => ano = value),
              ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Placa'),
                          onChanged: (value) => placa = value,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Valor (R\$)'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) => valor = double.tryParse(value) ?? 0.0,
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<Categoria>(
                          decoration: const InputDecoration(labelText: 'Categoria'),
                          value: categoriaSelecionada,
                          items: categorias.map((cat) {
                            return DropdownMenuItem<Categoria>(
                              value: cat,
                              child: Text(cat.descricao),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() => categoriaSelecionada = value);
                          },
                          validator: (value) =>
                              value == null ? 'Selecione uma categoria' : null,
                        ),
                        const SizedBox(height: 12),
                        SwitchListTile(
                          title: const Text('Único dono'),
                          value: unicoDono,
                          onChanged: (value) => setState(() => unicoDono = value),
                        ),
                        const SizedBox(height: 20),
                        isSaving
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                onPressed: salvarVeiculo,
                                child: const Text('Salvar'),
                              ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
