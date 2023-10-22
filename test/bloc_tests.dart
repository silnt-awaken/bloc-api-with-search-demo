import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:simpsons_demo/blocs/datasource/data_source_bloc.dart';
import 'package:simpsons_demo/blocs/search/search_bloc.dart';
import 'package:simpsons_demo/data/simpson_character/api/related_topic.dart'
    as simpson;
import 'package:simpsons_demo/data/simpson_character/ui/simpson.dart';
import 'package:simpsons_demo/data/wire_character/api/related_topic.dart'
    as wire;
import 'package:simpsons_demo/data/wire_character/ui/wire.dart';
import 'package:simpsons_demo/mocks.dart';

void main() {
  late MockSimpsonsDataSource mockSimpsonsDataSource;
  late MockWireDataSource mockWireDataSource;

  setUp(() async {
    mockSimpsonsDataSource = MockSimpsonsDataSource();
    mockWireDataSource = MockWireDataSource();

    when(() => mockSimpsonsDataSource.fetchData())
        .thenAnswer((_) => Future.value([
              simpson.RelatedTopic(
                text: 'text',
                result: 'result',
                firstUrl: 'firstUrl',
              )
            ]));

    when(() => mockWireDataSource.fetchData()).thenAnswer((_) => Future.value([
          wire.RelatedTopic(
            text: 'text',
            result: 'result',
            firstUrl: 'firstUrl',
          )
        ]));
  });
  group('DataSourceBloc tests', () {
    blocTest<DataSourceBloc, DataSourceState>(
        'DataSourceBloc emits [DataSourceState] when DataSourceEventFetch is added.',
        build: () {
          return DataSourceBloc(mockSimpsonsDataSource, mockWireDataSource);
        },
        act: (bloc) => bloc.add(const DataSourceEventFetch()),
        expect: () => [
              isA<DataSourceState>().having(
                  (s) => s.simpsonData, 'simpsonData', [
                isA<Simpson>()
              ]).having((s) => s.wireData, 'wireData', [isA<Wire>()])
            ]);

    blocTest<DataSourceBloc, DataSourceState>(
        'DataSourceBloc emits [DataSourceState] when DataSourceEventSelectTile is added.',
        build: () {
          return DataSourceBloc(mockSimpsonsDataSource, mockWireDataSource);
        },
        act: (bloc) => bloc.add(DataSourceEventSelectTile(
                tile: Simpson(
              title: 'title',
              description: 'description',
              image: 'image',
            ))),
        expect: () => [
              isA<DataSourceState>().having(
                  (s) => s.currentSelectedTile,
                  'currentSelectedTile should be a Simpson obj',
                  isA<Simpson>()),
            ]);
  });

  group('SearchBloc tests', () {
    blocTest<SearchBloc, SearchState>(
        'SearchBloc emits [SearchState] when SearchEventSearch is added.',
        build: () {
          return SearchBloc();
        },
        act: (bloc) => bloc.add(SearchQueryChanged(query: 't', data: [
              Simpson(
                title: 'title',
                description: 'description',
                image: 'image',
              ),
              Simpson(
                title: 'bible',
                description: 'description',
                image: 'image',
              ),
            ])),
        expect: () => [
              isA<SearchState>().having(
                  (s) => s.filteredData,
                  'filtered data when query is valid',
                  allOf(isA<List<Simpson>>(), hasLength(1))),
            ]);

    blocTest<SearchBloc, SearchState>(
        'SearchBloc emits [SearchState] when SearchEventClearQuery is added.',
        build: () {
          return SearchBloc();
        },
        act: (bloc) => bloc.add(const SearchClearQuery()),
        expect: () => [
              isA<SearchState>()
                  .having((s) => s.query, 'query should be empty', ''),
            ]);
  });
}
