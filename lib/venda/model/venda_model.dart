
import 'package:sales_car/cliente/model/cliente_model.dart';
import 'package:sales_car/veiculo/model/veiculo_model.dart';
import 'package:sales_car/vendedor/model/vendedor_model.dart';

class Venda {
   int? id;
  final DateTime data;
  final double valorDesconto;
  final double valorTotal;
  final Cliente cliente;
  final Veiculo veiculo;
  final Vendedor vendedor;

  Venda({
     this.id,
    required this.data,
    required this.valorDesconto,
    required this.valorTotal,
    required this.cliente,
    required this.veiculo,
    required this.vendedor,
  });

 factory Venda.fromJson(Map<String, dynamic> json) {
    return Venda(
      id: json['id'],
      data: DateTime.parse(json['data']),
      valorDesconto: (json['valorDesconto'] as num).toDouble(),
      valorTotal: (json['valorTotal'] as num).toDouble(),
      cliente: Cliente.fromJson(json['cliente']),
      veiculo: Veiculo.fromJson(json['veiculo']),
      vendedor: Vendedor.fromJson(json['vendedor']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'data': data.toIso8601String(),
      'valorDesconto': valorDesconto,
      'valorTotal': valorTotal,
      'cliente': cliente.toJson(),
      'veiculo': veiculo.toJson(),
      'vendedor': vendedor.toJson(),
    };
  }
}