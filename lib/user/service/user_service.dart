import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sales_car/api_service.dart';
import 'package:sales_car/user/model/user_model.dart';


class AuthService {
  
 Future<User?> login(String email, String senha) async {
    final url = Uri.parse('$baseUrl/users/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'senha': senha,
       
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      return null;
    }
  }

  Future<bool> cadastrarAdmin(User user) async {
    final url = Uri.parse('$baseUrl/users/cadastrar');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()),
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }
  Future<bool> cadastrarUsuario(User user) async {
  final url = Uri.parse('$baseUrl/users/cadastrar'); // rota genérica

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(user.toJson()),
  );

  return response.statusCode == 200 || response.statusCode == 201;
}


}
