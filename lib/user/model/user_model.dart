class User {
  String nome;
  String email;
  String senha;
  String tipo;

  User({
    this.nome = '',
    required this.email,
    required this.senha,
    this.tipo = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nome: json['nome'] ?? '',
      email: json['email'] ?? '',
      senha: json['senha'] ?? '',
      tipo: json['tipo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'email': email,
      'senha': senha,
      'tipo': tipo,
    };
  }
}

