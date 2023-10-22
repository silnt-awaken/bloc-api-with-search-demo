part of 'search_bloc.dart';

class SearchState extends Equatable {
  final String query;
  final List<Simpson> filteredData;
  const SearchState({required this.query, required this.filteredData});

  @override
  List<Object> get props => [query, query];

  SearchState copyWith({String? query, List<Simpson>? filteredData}) {
    return SearchState(
      query: query ?? this.query,
      filteredData: filteredData ?? this.filteredData,
    );
  }
}
