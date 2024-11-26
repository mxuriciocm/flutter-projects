import 'package:flutter/material.dart';
import 'package:newsly/news.dart';
import 'package:newsly/utils.dart';

class FavoriteNewsPage extends StatefulWidget {
  const FavoriteNewsPage({super.key});

  @override
  State<FavoriteNewsPage> createState() => _FavoriteNewsPageState();
}

class _FavoriteNewsPageState extends State<FavoriteNewsPage> {
  final TextEditingController _controller = TextEditingController();
  List<News> _news = [];
  List<News> _filteredNews = [];

  void loadData() async {
    List maps = await loadJsonFromAssets('assets/articles.json');
    setState(() {
      _news = maps.map((map) => News.fromJson(map)).toList();
      _filteredNews = _news;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void _filterNews(String value) {
    setState(() {
      _filteredNews = _news.where(
        (element) {
          return element.title.contains(value);
        },
      ).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextField(
            onChanged: _filterNews,
            controller: _controller,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)))),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredNews.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        _filteredNews[index].urlToImage,
                        height: 200,
                        fit: BoxFit.cover,
                        width: width,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox(
                              width: double.infinity,
                              height: 200,
                              child: Center(child: Text('No image found')));
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                if (mounted) {
                                  setState(() {
                                    _news.remove(_filteredNews[index]);
                                  });
                                }
                              },
                              icon: const Icon(
                                  Icons.remove_circle_outline_outlined)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          _filteredNews[index].title,
                          maxLines: 1,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(_filteredNews[index].author),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
