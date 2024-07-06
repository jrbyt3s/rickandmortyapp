import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rickandmortyapp/provider/api_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
} // termina definicion de la clase

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController();
  bool isLoading = false;
  int page = 1;
  // DECLARAMOS UN initState para usar con el provider
  @override
  void initState() {
    super.initState();
    final apiProvider = Provider.of<ApiProvider>(context,
        listen:
            false); // fals e paraq no se llame desde aqui, antes que contruya la vista
    apiProvider.getCharacters(page);
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
        });
        page++;
        await apiProvider.getCharacters(page);
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //Declaramos el provider:
    final apiProvider = Provider.of<ApiProvider>(context);
    // renderizamos el scaffold
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rick and Morty",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: apiProvider.characters.isNotEmpty
            ? CharaterList(
                apiProvider: apiProvider,
                isLoading: isLoading,
                scrollController: scrollController,
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

class CharaterList extends StatelessWidget {
  const CharaterList(
      {super.key,
      required this.apiProvider,
      required this.scrollController,
      required this.isLoading});

  final ApiProvider apiProvider;
  final ScrollController scrollController;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.87,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5),
        itemCount: apiProvider.characters.length,
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index < apiProvider.characters.length) {
            final character = apiProvider.characters[index];
            // usamos el gesture detetor para hacer que detecte el onTap() y nos navegue a otra pagina.
            // El gesture detector envuelve a la Card
            return GestureDetector(
              onTap: () {
                context.go('/character',
                    extra:
                        character); // con el extra le enviamos el objeto character al screen character
              },
              child: Card(
                child: Column(
                  children: [
                    FadeInImage(
                        placeholder: const AssetImage(
                            'assets/images/portal-rick-and-morty.gif'),
                        image: NetworkImage(character.image!)),
                    Text(
                      character.name!, // propiedad Nombre de la clase caracter.
                      style: const TextStyle(
                          fontSize: 16, overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
