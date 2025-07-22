

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sales_car/api_service.dart';
import 'package:sales_car/venda/model/venda_model.dart';


class VendaService {
  Future<List<Venda>> listar() async {
    final res = await http.get(Uri.parse('$baseUrl/vendas/list'));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return List<Venda>.from(data.map((v) => Venda.fromJson(v)));
    } else {
      throw Exception('Erro ao listar vendas');
    }
  }

  Future<bool> cadastrar(Venda venda) async {
    final res = await http.post(
      Uri.parse('$baseUrl/vendas/cadastrar'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(venda.toJson()),
    );
    return res.statusCode == 200 || res.statusCode == 201;
  }

  
  Future<bool> excluirVenda(int id) async {
    final res = await http.delete(
      Uri.parse('$baseUrl/vendas/deletar/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    return res.statusCode == 200 || res.statusCode == 204;
  }
}
