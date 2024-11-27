import 'package:flutter/material.dart';
import 'package:newsly/domain/news.dart';
import 'package:newsly/presentation/newsdetails/news_details_screen.dart';
import 'package:newsly/data/remote/news_service.dart';
// import 'package:newsly/utils.dart';

class SearchNewsPage extends StatefulWidget {
  const SearchNewsPage({super.key});

  @override
  State<SearchNewsPage> createState() => _SearchNewsPageState();
}

class _SearchNewsPageState extends State<SearchNewsPage> {
  final TextEditingController _controller = TextEditingController();
  List<News> _news = [];

  void loadData() async {
    // List maps = await loadJsonFromAssets('assets/articles.json');
    // setState(() {
    //   _news = maps.map((map) => News.fromJson(map)).toList();
    // });

    List<News> news = await NewsService().searchNews(_controller.text);
    setState(() {
      _news = news;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextField(
            onSubmitted: (value) {
              loadData();
            },
            controller: _controller,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)))),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _news.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NewsDetailScreen(news: _news[index]),
                          ));
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: _news[index].title,
                            child: Image.network(
                              _news[index].urlToImage,
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
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              _news[index].title,
                              maxLines: 1,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(_news[index].author),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _news[index].description,
                              maxLines: 3,
                            ),
                          )
                        ],
                      ),
                    ),
                  ));
            },
          ),
        )
      ],
    );
  }
}
