import 'package:flutter/material.dart';
import 'package:sales_car/categoria/page/categoria_list_page.dart';
import 'package:sales_car/cliente/page/cliente_page.dart';
import 'package:sales_car/cliente/page/list_client.dart';
import 'package:sales_car/home/home_page.dart';
import 'package:sales_car/home/pages/home_page_admin.dart';
import 'package:sales_car/home/pages/home_page_cliente.dart';
import 'package:sales_car/home/pages/home_page_vendedor.dart';
import 'package:sales_car/login/page/login_page.dart';
import 'package:sales_car/user/page/user_page.dart';
import 'package:sales_car/veiculo/model/veiculo_model.dart';
import 'package:sales_car/veiculo/page/veiculo_list_page.dart';
import 'package:sales_car/veiculo/page/veiculo_page.dart';
import 'package:sales_car/venda/model/venda_model.dart';
import 'package:sales_car/venda/page/venda_list_page.dart';
import 'package:sales_car/venda/page/venda_page.dart';
import 'package:sales_car/vendedor/page/lista_vendedor_page.dart';
import 'package:sales_car/vendedor/page/vendedor_page.dart';

void main() {
  var onSave;
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
     
      '/home': (context) => const HomePage(),
       '/login': (context) => const LoginPage(),
       '/veiculos': (context) => const ListagemCarrosPage(), 
       '/cadastro-cliente': (context) => const CadastroClientePage(),
      '/cadastro-vendedor': (context) => const CadastroVendedorPage(),
      '/cadastro-usuario': (context) => const CadastroUsuarioPage(),
      '/cadastro-veiculo': (context)=> const CadastroVeiculoPage(),
       '/nova-venda': (context) => const VendaCadastroPage(),
      '/cliente': (context) => const ClientesPage(),
      '/categorias': (context) => const CategoriaListPage(),
      '/vendedor':(context) => const VendedorHomePage(),
      '/vendas':(context) => const VendasListPage(),
      '/list-vendedor': (context) => const VendedorListPage(), 
       '/home_admin':(context) => const HomePageAdmin(), 
    },
  ));
}

