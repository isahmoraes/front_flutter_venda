import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sales_car/api_service.dart';
import 'package:sales_car/vendedor/model/vendedor_login_model.dart';
import 'package:sales_car/vendedor/model/vendedor_model.dart';


class VendedorService {
  Future<bool> login(VendedorLogin vendedorLogin) async {
    final res = await http.post(
      Uri.parse('$baseUrl/vendedores/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(vendedorLogin.toJson()),
    );
    return res.statusCode == 200;
  }

  Future<bool> cadastrar(Vendedor vendedor) async {
    final res = await http.post(
      Uri.parse('$baseUrl/vendedores/cadastrar'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(vendedor.toJson()),
    );
    return res.statusCode == 200 || res.statusCode == 201;
  }

Future<List<Vendedor>> fetchVendedores() async {
  final response = await http.get(Uri.parse('$baseUrl/vendedores/listar'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = jsonDecode(response.body);
    return jsonData.map((json) => Vendedor.fromJson(json)).toList();
  } else {
    throw Exception('Falha ao carregar vendedores');
  }
}

Future<bool> excluirVendedor(int id) async {
    final res = await http.delete(
      Uri.parse('$baseUrl/vendedores/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    return res.statusCode == 200 || res.statusCode == 204;
  }


}
