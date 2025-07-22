class VendedorLogin {
  String email;
  String senha;

  VendedorLogin({
    required this.email,
    required this.senha,
  });

  factory VendedorLogin.fromJson(Map<String, dynamic> json) {
    return VendedorLogin(
      email: json['email'],
      senha: json['senha'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'senha': senha,
    };
  }
}
