import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PokeItem extends StatelessWidget {
  final String name;
  final int index;
  final Color color;
  final String number;
  final List<String> types;

  const PokeItem(
      {Key key, this.name, this.index, this.color, this.number, this.types})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Stack(
            // alignment: Alignment.bottomRight,
            children: <Widget>[
              Align(
                alignment: Alignment.bottomRight,
                child: Opacity(
                  child: Image.asset(
                    'assets/images/pokeball.png',
                    height: 80,
                    width: 80,
                  ),
                  opacity: 0.2,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: CachedNetworkImage(
                  height: 80,
                  width: 80,
                  placeholder: (context, url) => new Container(
                    color: Colors.transparent,
                  ),
                  imageUrl:
                      'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$number.png',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  name,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0, top: 30),
                child: setTipos(),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: getColorType(type: types[0]),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget setTipos() {
    List<Widget> lista = [];
    types.forEach((nome) {
      lista.add(
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(80, 255, 255, 255)),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  nome.trim(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      );
    });
    return Column(
      children: lista,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Color getColorType({String type}) {
    switch (type) {
      case 'Normal':
        return Colors.brown[400];
        break;
      case 'Fire':
        return Colors.red;
        break;
      case 'Water':
        return Colors.blue;
        break;
      case 'Grass':
        return Colors.green;
        break;
      case 'Electric':
        return Colors.amber;
        break;
      case 'Ice':
        return Colors.cyanAccent[400];
        break;
      case 'Fighting':
        return Colors.orange;
        break;
      case 'Poison':
        return Colors.purple;
        break;
      case 'Ground':
        return Colors.orange[300];
        break;
      case 'Flying':
        return Colors.indigo[200];
        break;
      case 'Psychic':
        return Colors.pink;
        break;
      case 'Bug':
        return Colors.lightGreen[500];
        break;
      case 'Rock':
        return Colors.grey;
        break;
      case 'Ghost':
        return Colors.indigo[400];
        break;
      case 'Dark':
        return Colors.brown;
        break;
      case 'Dragon':
        return Colors.indigo[800];
        break;
      case 'Steel':
        return Colors.blueGrey;
        break;
      case 'Fairy':
        return Colors.pinkAccent[100];
        break;
      default:
        return Colors.grey;
        break;
    }
  }
}
