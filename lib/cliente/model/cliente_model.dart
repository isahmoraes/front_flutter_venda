import 'package:sales_car/abstract/model/pessoa_fisica_model.dart';

class Cliente extends PessoaFisica {
  final int? id;  // novo campo id
  String? referenciaComercial;
  DateTime dataNascimento;

  Cliente({
    this.id,  
    this.referenciaComercial,
    required this.dataNascimento,
    required super.nome,
    required super.cpf,
    required super.rg,
    required super.endereco,
    required super.telefone,
    required super.email,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'],  // pegando id do json
      referenciaComercial: json['referenciaComercial'] ?? '',
      dataNascimento: DateTime.parse(json['dataNascimento']),
      nome: json['nome'],
      cpf: json['cpf'],
      rg: json['rg'],
      endereco: json['endereco'],
      telefone: json['telefone'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,  // enviando id no json
      'referenciaComercial': referenciaComercial,
      'dataNascimento': dataNascimento.toIso8601String(),
      'nome': nome,
      'cpf': cpf,
      'rg': rg,
      'endereco': endereco,
      'telefone': telefone,
      'email': email,
    };
  }
}