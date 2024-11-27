abstract class NewsEvent {}

class SearchNewsEvent extends NewsEvent {
  final String query;

  SearchNewsEvent({required this.query});
}
