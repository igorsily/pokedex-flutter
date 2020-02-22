import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pokedex/models/pokeapi.dart';
import 'package:pokedex/pages/home/widget/header..dart';
import 'package:pokedex/pages/home/widget/poke_item.dart';
import 'package:pokedex/pages/poke_detail/poke_detail.dart';
import 'package:pokedex/stores/pokeapi.store.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _pokemonStore = Provider.of<PokeApiStore>(context);

    if (_pokemonStore.pokeAPI == null) {
          _pokemonStore.fetchPokemonList();
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double statusbarWidth = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
              top: -(240 / 4.7),
              left: screenWidth - (240 / 1.6),
              child: Opacity(
                child: Image.asset('assets/images/pokeball_dark.png',
                    height: 240, width: 240),
                opacity: 0.2,
              )),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: statusbarWidth,
                  color: Colors.blue,
                ),
                Header(),
                Expanded(child: Container(
                  child: Observer(
                    builder: (BuildContext context) {
                      PokeAPI _pokeApi = _pokemonStore.pokeAPI;
                      return (_pokeApi != null)
                          ? AnimationLimiter(
                              child: GridView.builder(
                                  physics: BouncingScrollPhysics(),
                                  padding: const EdgeInsets.all(12),
                                  addAutomaticKeepAlives: false,
                                  gridDelegate:
                                      new SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  itemCount:
                                      _pokemonStore.pokeAPI.pokemon.length,
                                  itemBuilder: (context, index) {
                                    Pokemon pokemon =
                                        _pokemonStore.getPokemon(index: index);
                                    return AnimationConfiguration.staggeredGrid(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 375),
                                        columnCount: 2,
                                        child: ScaleAnimation(
                                            child: GestureDetector(
                                          child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: PokeItem(
                                                index: index,
                                                name: pokemon.name,
                                                types: pokemon.type,
                                                number: pokemon.num,
                                              )),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        PokeDetail(index: index,
                                                name: pokemon.name,),
                                                    fullscreenDialog: true));
                                          },
                                        )));
                                  }),
                            )
                          : Center(child: CircularProgressIndicator());
                    },
                  ),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
