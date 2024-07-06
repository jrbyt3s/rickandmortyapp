import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmortyapp/models/character_model.dart';
import 'package:rickandmortyapp/provider/api_provider.dart';

class CharacterScreen extends StatelessWidget {
  const CharacterScreen({super.key, required this.character});
  final Character
      character; // en el constructor requerimos que nos envíen un caracter

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(character
            .name!), // aqui extraemos el nombre del personaje para ponerlo de titulo en el navBar
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.35,
              width: double.infinity,
              child: Hero(
                  tag: character.id!,
                  child: Image.network(
                    character.image!,
                    fit: BoxFit.cover,
                  )),
            ),
            //Conteiner es una tira Horizontal (ROW)
            Container(
              padding: EdgeInsets.all(10),
              height: size.height * 0.14,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  cardData("status", character.status!),
                  cardData("especie", character.species!),
                  cardData("status", character.origin!.name!),
                ],
              ),
            ),
            const Text(
              'Episodes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            EpisodeList(size: size, character: character),
          ],
        ),
      ),
    );
  }

  Widget cardData(String text1, String text2) {
    return Expanded(
        child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(text1),
          Text(
            text2,
            style: TextStyle(overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    ));
  }
}

//widged: lista de episodios:
class EpisodeList extends StatefulWidget {
  const EpisodeList({super.key, required this.size, required this.character});
  final Size size;
  final Character character;

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  @override
  void initState() {
    super.initState();
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.getEpisode(widget.character);
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    return SizedBox(
      height: widget.size.height * 0.35,
      child: ListView.builder(
        itemCount: apiProvider.episodes.length,
        itemBuilder: (context, index) {
          final episode = apiProvider.episodes[index];
          return ListTile(
            leading: Text(episode.episode!),
            title: Text(episode.name!),
            trailing: Text(episode.airDate!),
          );
        },
      ),
    );
  }
}
