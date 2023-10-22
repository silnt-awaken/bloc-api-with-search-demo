part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchQueryChanged extends SearchEvent {
  final String query;
  final List<Simpson> data;

  const SearchQueryChanged({required this.query, required this.data});

  @override
  List<Object> get props => [query, data];
}

class SearchClearQuery extends SearchEvent {
  const SearchClearQuery();
}
