abstract class PessoaFisica {
  String nome;
  String cpf;
  String? rg;
  String? endereco;
  String telefone;
  String? email;

  PessoaFisica({
    required this.nome,
    required this.cpf,
    required this.rg,
    required this.endereco,
    required this.telefone,
    required this.email,
  });
   Map<String, dynamic> toJson();
}

