import 'package:flutter/material.dart';
import 'package:sales_car/categoria/model/categoria_model.dart';
import 'package:sales_car/cliente/model/cliente_model.dart';
import 'package:sales_car/cliente/service/cliente_service.dart';
import 'package:sales_car/veiculo/model/veiculo_model.dart';
import 'package:sales_car/veiculo/service/veiculo_service.dart';
import 'package:sales_car/venda/model/venda_model.dart';
import 'package:sales_car/vendedor/model/vendedor_model.dart';
import 'package:sales_car/vendedor/service/vendedor_service.dart';

class VendaCadastroPage extends StatefulWidget {
  const VendaCadastroPage({super.key});

  @override
  State<VendaCadastroPage> createState() => _VendaCadastroPageState();
}

class _VendaCadastroPageState extends State<VendaCadastroPage> {
  List<Vendedor> vendedores = [];
  List<Cliente> clientes = [];
  List<Veiculo> veiculos = [];

  Vendedor? vendedorSelecionado;
  Cliente? clienteSelecionado;
  Veiculo? veiculoSelecionado;

  double desconto = 0.0;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    try {
      final fetchedVendedores = await VendedorService().fetchVendedores();
      final fetchedClientes = await ClienteService().listarClientes();
      final fetchedVeiculos = await VeiculoService().listar();

      setState(() {
        vendedores = fetchedVendedores;
        clientes = fetchedClientes;
        veiculos = fetchedVeiculos;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  void salvarVenda() {
    if (clienteSelecionado == null ||
        veiculoSelecionado == null ||
        vendedorSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Por favor, selecione cliente, veículo e vendedor')),
      );
      return;
    }

    final valorFinal = veiculoSelecionado!.valor - desconto;

    final novaVenda = Venda(
      id: DateTime.now().millisecondsSinceEpoch,
      data: DateTime.now(),
      valorDesconto: desconto,
      valorTotal: valorFinal,
      cliente: clienteSelecionado!,
      veiculo: veiculoSelecionado!,
      vendedor: vendedorSelecionado!,
    );

    print(
        'Venda criada: Cliente ${novaVenda.cliente.nome}, Veículo ${novaVenda.veiculo.modelo}, Vendedor ${novaVenda.vendedor.nome}');

    Navigator.pop(context, novaVenda);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return Scaffold(
        body: Center(child: Text('Erro: $error')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Venda')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<Cliente>(
              value: clienteSelecionado,
              hint: const Text('Selecione o Cliente'),
              onChanged: (value) => setState(() => clienteSelecionado = value),
              items: clientes.map((cliente) {
                return DropdownMenuItem(
                  value: cliente,
                  child: Text(cliente.nome),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<Veiculo>(
              value: veiculoSelecionado,
              hint: const Text('Selecione o Veículo'),
              onChanged: (value) => setState(() => veiculoSelecionado = value),
              items: veiculos.map((veiculo) {
                return DropdownMenuItem(
                  value: veiculo,
                  child: Text('${veiculo.modelo} - R\$ ${veiculo.valor.toStringAsFixed(2)}'),



                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<Vendedor>(
              value: vendedorSelecionado,
              hint: const Text('Selecione o Vendedor'),
              onChanged: (value) => setState(() => vendedorSelecionado = value),
              items: vendedores.map((vendedor) {
                return DropdownMenuItem(
                  value: vendedor,
                  child: Text(vendedor.nome),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration:
                  const InputDecoration(labelText: 'Desconto (R\$)'),
              keyboardType: TextInputType.number,
              onChanged: (val) {
                setState(() {
                  desconto = double.tryParse(val) ?? 0.0;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: salvarVenda,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text('Salvar Venda',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
