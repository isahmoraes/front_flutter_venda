
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sales_car/api_service.dart';
import 'package:sales_car/veiculo/model/veiculo_model.dart';


class VeiculoService {
  Future<List<Veiculo>> listar() async {
    final res = await http.get(Uri.parse('$baseUrl/veiculos/listarTodos'));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return List<Veiculo>.from(data.map((v) => Veiculo.fromJson(v)));
    } else {
      throw Exception('Erro ao listar veículos');
    }
  }

  Future<bool> cadastrar(Veiculo veiculo) async {
    final res = await http.post(
      Uri.parse('$baseUrl/veiculos/salvar'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(veiculo.toJson()),
    );
    return res.statusCode == 200 || res.statusCode == 201;
  }
    Future<void> deletarVeiculo(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/veiculos/deletar/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 204) {
      throw Exception('Falha ao deletar veículo');
    }
  }

}
