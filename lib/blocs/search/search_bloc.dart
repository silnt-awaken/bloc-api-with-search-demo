import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpsons_demo/data/simpson_character/ui/simpson.dart';
import 'package:simpsons_demo/util/string_customizations.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState(query: '', filteredData: [])) {
    on<SearchQueryChanged>((event, emit) {
      final filteredData = event.data
          .where((simpson) => simpson.title.toLowerCase().contains(event.query))
          .toList();

      emit(state.copyWith(query: event.query, filteredData: filteredData));
    });

    on<SearchClearQuery>((event, emit) {
      emit(state.copyWith(query: '', filteredData: []));
    });
  }

  @override
  String toString() {
    return 'SearchState{query: ${state.query}, filteredData: ${state.filteredData.map((e) => '${e.title.extractName}\n').toList()}}';
  }
}
