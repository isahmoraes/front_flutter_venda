import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView( // 👈 permite rolagem e evita overflow
        child: Column(
          children: const [
            Header(),
            BannerSection(),
            AccessSection(),
            FeaturedVehicles(),
            Footer(),
          ],
        ),
      ),
    );
  }
}

// HEADER
class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      color: Colors.blue[900],
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isSmall = constraints.maxWidth < 600;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Compre Mais',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSmall ? 22 : 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isSmall) const SizedBox(height: 10),
              Row(
                mainAxisAlignment: isSmall ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
                children: const [
                  Spacer(),
                  HeaderMenuItem(title: 'Login', route: '/login'),
                  HeaderMenuItem(title: 'Contato', route: '/contato'),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class HeaderMenuItem extends StatelessWidget {
  final String title;
  final String route;

  const HeaderMenuItem({
    super.key,
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, route),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}

// BANNER
class BannerSection extends StatelessWidget {
  const BannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      color: Colors.blue[100],
      alignment: Alignment.center,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Seu próximo carro está aqui!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Encontre as melhores ofertas com a Compre Mais.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

// ACESSO VENDEDOR/CLIENTE
class AccessSection extends StatelessWidget {
  const AccessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 500;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Flex(
        direction: isSmall ? Axis.vertical : Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/vendedor');
            },
            icon: const Icon(Icons.store),
            label: const Text('Área do Vendedor'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[800],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
          SizedBox(height: isSmall ? 16 : 0, width: isSmall ? 0 : 20),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/cliente');
            },
            icon: const Icon(Icons.person),
            label: const Text('Área do Cliente'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
          SizedBox(height: isSmall ? 16 : 0, width: isSmall ? 0 : 20),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/home_admin');
            },
            icon: const Icon(Icons.person),
            label: const Text('Área do Admin'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 142, 62, 56),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}

// VEÍCULOS EM DESTAQUE
class FeaturedVehicles extends StatelessWidget {
  const FeaturedVehicles({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 1;
        if (constraints.maxWidth > 900) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth > 600) {
          crossAxisCount = 2;
        }

        return Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Veículos em Destaque',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) => const VehicleCard(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class VehicleCard extends StatelessWidget {
  const VehicleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Onix LTZ 1.0 Turbo',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text('R\$ 100.900', style: TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}

// FOOTER
class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      color: Colors.grey[200],
      child: const Center(
        child: Text(
          '© 2025 Compre Mais - Todos os direitos reservados.',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
