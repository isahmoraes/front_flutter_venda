
import 'package:sales_car/abstract/model/pessoa_fisica_model.dart';

class Vendedor extends PessoaFisica {
  double salario;
  double comissao;
  String? senha;
  int? id;
  Vendedor({
  this.id,
    required this.salario,
    required this.comissao,
     this.senha,
    required super.nome,
    required super.cpf,
     super.rg,
    super.endereco,
    required super.telefone,
   super.email,
  });

  factory Vendedor.fromJson(Map<String, dynamic> json) {
    return Vendedor(
      id: json['id'],
      salario: (json['salario'] ?? 0).toDouble(),
      comissao: (json['comissao'] ?? 0).toDouble(),
      senha: json['senha'] ?? '',
      nome: json['nome'],
      cpf: json['cpf'],
      rg: json['rg'],
      endereco: json['endereco'],
      telefone: json['telefone'],
      email: json['email'],
    );
  }

@override
Map<String, dynamic> toJson() {
  return {
    'id':id,
    'nome': nome,
    'cpf': cpf,
    'rg': rg,
    'endereco': endereco,
    'telefone': telefone,
    'email': email,
    'salario': salario,
    'comissao': comissao,
    'senha': senha,
  };
}
}