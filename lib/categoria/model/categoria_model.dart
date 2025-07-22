

class Categoria {
  final int id;
  
  String descricao;

  Categoria({required this.id,required this.descricao});
   factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'],
     
     descricao: json['descricao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      
      'descricao':descricao
    };
  }
}
