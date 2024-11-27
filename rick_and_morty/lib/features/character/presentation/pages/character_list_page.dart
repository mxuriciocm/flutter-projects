import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rick_and_morty/core/app_constants.dart';
import 'package:rick_and_morty/features/character/data/remote/character_model.dart';
import 'package:rick_and_morty/features/character/data/remote/character_service.dart';
import 'package:rick_and_morty/features/character/presentation/pages/character_detail_page.dart';
import 'package:rick_and_morty/features/character/presentation/widgets/character_list_item.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  final PagingController<int, CharacterModel> _pagingController =
      PagingController(firstPageKey: AppConstants.initialPage);

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await CharacterService().getCharacters(pageKey);
      final isLastPage = newItems.length < AppConstants.pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        _pagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (e) {
      _pagingController.error = e;
    }
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PagedListView<int, CharacterModel>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, item, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CharacterDetailPage(characterModel: item),
                      ));
                },
                child: CharacterListItem(characterModel: item));
          },
        ),
      ),
    );
  }
}
