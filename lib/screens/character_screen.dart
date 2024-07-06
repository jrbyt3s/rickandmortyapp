import 'package:flutter/material.dart';
import 'package:rickandmortyapp/models/character_model.dart';

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
            )
          ],
        ),
      ),
    );
  }
}
