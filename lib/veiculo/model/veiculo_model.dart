
import 'package:sales_car/categoria/model/categoria_model.dart';

class Veiculo {
 final int? id ;
  final String nome;
  final String modelo;
  final String cor;
  final String ano;

  final String placa;
  final bool unicoDono;
  final double valor;
  final  Categoria categoria;
  int? categoriaId;
  Veiculo({
     this.id,
    required this.nome,
    required this.modelo,
    required this.cor,
    required this.ano,
    required this.placa,
    required this.unicoDono,
    required this.valor,
    required this.categoria,
    this.categoriaId
  });
  factory Veiculo.fromJson(Map<String, dynamic> json) {
    final categoriaJson = json['categoria'];
  return Veiculo(
    id: json['id'],
    nome: json['nome'],
    modelo: json['modelo'],
    cor: json['cor'],
    ano: json['ano'],
    placa: json['placa'],
    unicoDono: json['unicoDono'],
    valor: json['valor'],
    categoriaId: categoriaJson?['id'],
    categoria: categoriaJson != null
        ? Categoria.fromJson(categoriaJson)
        : Categoria(id: 0, descricao: ''), 
  
  );
}

 Map<String, dynamic> toJson() {
  return {
   
    'nome': nome,
    'modelo': modelo,
    'cor': cor,
    'ano': ano,
    'placa': placa,
    'unicoDono': unicoDono,
    'valor': valor,
    'categoriaId':categoriaId, 
  };
}

}

