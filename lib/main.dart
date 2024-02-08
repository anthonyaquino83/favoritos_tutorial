import 'package:flutter/material.dart';
import 'package:listadefavoritos/favorites.dart';
import 'package:provider/provider.dart';

// 1. Transformar MyHomePage em StatelessWidget
// 2. Criar ícone de favoritos no AppBar
// 3. Criar FavoritesPage
// 4. Criar navegação para FavoritesPage
// 5. Criar Lista de carros
// 6. Criar ListView.builder
// 7. Criar model Favorites extendendo ChangeNotifier
// 8. Extrair ListTile widget para CarTile
// 9. Refatorar ListTile
// 10. Criar o ChangeNotifierProvider
// 11. Declarar o Provider no CarTile
// 12. Incluir o ícone de favorito no CarTile
// 13. Incluir evento de adicionar ou remover carro na lista de favoritos
// 14. Mostrar Scaffold ao alterar a lista de favoritos
// FavoritesPage
// 15. Criar ListView.builder
// 16. Criar Consumer<Favorites>
// 17. Incluir o ícone de remover favorito
// 18. Mostrar Scaffold ao alterar a lista de favoritos
// 19. Refatorar para mostrar Dialog de confirmação

final List listCars = [
  'Sandero',
  'Uno',
  'Gol',
  'Onix',
  'Celta',
  'HB20',
  'Kwid',
  'Argo',
  'Mobi',
  'Ka'
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Favorites>(
      create: (context) => Favorites(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carros'),
        actions: <Widget>[
          TextButton.icon(
            onPressed: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const FavoritesPage(),
                ),
              );
            },
            icon: Icon(Icons.favorite_border),
            label: Text('  '),
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: listCars.length,
        itemBuilder: (BuildContext context, int index) {
          return CarTile(index: index);
        },
      ),
    );
  }
}

class CarTile extends StatelessWidget {
  CarTile({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    var favoriteCars = Provider.of<Favorites>(context);
    return ListTile(
      title: Text(
        listCars[index],
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: IconButton(
          icon: favoriteCars.list.contains(listCars[index])
              ? Icon(
                  Icons.favorite,
                  color: Colors.red,
                )
              : Icon(
                  Icons.favorite_border,
                ),
          onPressed: () {
            !favoriteCars.list.contains(listCars[index])
                ? favoriteCars.add(listCars[index])
                : favoriteCars.remove(listCars[index]);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  favoriteCars.list.contains(listCars[index])
                      ? 'Adicionado aos favoritos'
                      : 'Removido dos favoritos',
                ),
                duration: Duration(seconds: 1),
              ),
            );
          }),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Consumer<Favorites>(
        builder: (context, value, child) => ListView.builder(
          itemCount: value.list.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(value.list[index]),
              trailing: IconButton(
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Remove Favorite'),
                      content: const Text('Confirm?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Provider.of<Favorites>(context, listen: false)
                                .remove(value.list[index]);
                            Navigator.pop(context, 'OK');
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.close),
              ),
            );
          },
        ),
      ),
    );
  }
}
