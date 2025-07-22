import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sales_car/api_service.dart';
import 'package:sales_car/cliente/model/cliente_model.dart';


class ClienteService {


  Future<bool> cadastrar(Cliente cliente) async {
    final res = await http.post(
      Uri.parse('$baseUrl/clientes/cadastrar'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(cliente.toJson()),
    );
    return res.statusCode == 200 || res.statusCode == 201;
  }
   Future<List<Cliente>> listarClientes() async {
    final response = await http.get(Uri.parse('$baseUrl/clientes/list_client'));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Cliente.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao listar clientes');
    }
  }
   Future<void> deletarCliente(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/clientes/deletar/$id'));
    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar cliente');
    }
  }
}

