import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sales_car/api_service.dart';
import 'package:sales_car/categoria/model/categoria_model.dart';


class CategoriaService {
  Future<List<Categoria>> listar() async {
    final res = await http.get(Uri.parse('$baseUrl/categorias/listar'));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return List<Categoria>.from(data.map((c) => Categoria.fromJson(c)));
    } else {
      throw Exception('Erro ao buscar categorias');
    }
  }

  Future<bool> cadastrar(Categoria categoria) async {
    final res = await http.post(
      Uri.parse('$baseUrl/categorias/cadastrar'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(categoria.toJson()),
    );
    return res.statusCode == 200 || res.statusCode == 201;
  }
}
