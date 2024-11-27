import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/character/data/remote/character_model.dart';
import 'package:rick_and_morty/shared/data/local/favorite_dao.dart';
import 'package:rick_and_morty/shared/data/local/favorite_model.dart';

class CharacterDetailPage extends StatefulWidget {
  const CharacterDetailPage({super.key, required this.characterModel});
  final CharacterModel characterModel;

  @override
  State<CharacterDetailPage> createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  bool _isFavorite = false;

  void _loadData() async {
    bool isFavorite = await FavoriteDao().isFavorite(widget.characterModel.id);

    setState(() {
      _isFavorite = isFavorite;
    });
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: height * 0.40,
                floating: true,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: widget.characterModel.id,
                    child: Image.network(
                        height: height * 0.40,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        widget.characterModel.image),
                  ),
                ),
              )
            ];
          },
          body: Column(
            children: [
              Text(widget.characterModel.name),
              Text(widget.characterModel.status),
              Text(widget.characterModel.species),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isFavorite = !_isFavorite;
                    });
                    _isFavorite
                        ? FavoriteDao().insertFavorite(FavoriteModel(
                            id: widget.characterModel.id,
                            name: widget.characterModel.name,
                            status: widget.characterModel.status,
                            species: widget.characterModel.species,
                            image: widget.characterModel.image))
                        : FavoriteDao()
                            .deleteFavorite(widget.characterModel.id);
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: _isFavorite ? Colors.red : Colors.grey,
                  ))
            ],
          )),
    );
  }
}
