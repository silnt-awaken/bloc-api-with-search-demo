import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpsons_demo/data/simpson_character/ui/simpson.dart';
import 'package:simpsons_demo/data/ui_model.dart';
import 'package:simpsons_demo/presentation/tablet/tablet_view.dart';

import '../../blocs/datasource/data_source_bloc.dart';
import '../../blocs/search/search_bloc.dart';

class SearchView<T extends UIModel> extends StatefulWidget {
  final List<T> data;

  const SearchView({required this.data, super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late final TextEditingController _controller;
  bool _isClearable = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()
      ..addListener(() {
        setState(() {
          _isClearable = _controller.text.isNotEmpty;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state.query.isEmpty) {
          _controller.clear();
        }
      },
      builder: (context, searchState) {
        return Column(
          children: [
            BlocSelector<DataSourceBloc, DataSourceState, List<Simpson>>(
              selector: (state) {
                return state.simpsonData;
              },
              builder: (context, simpsonData) {
                return Visibility(
                  visible: simpsonData.isNotEmpty,
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _isClearable
                            ? GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  context
                                      .read<SearchBloc>()
                                      .add(const SearchClearQuery());

                                  context.read<DataSourceBloc>().add(
                                      DataSourceEventSelectTile(
                                          tile: widget.data.first));
                                },
                                child: const Icon(Icons.clear))
                            : null),
                    onChanged: (value) {
                      context.read<SearchBloc>().add(
                          SearchQueryChanged(query: value, data: simpsonData));
                    },
                  ),
                );
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchState.filteredData.isEmpty
                    ? widget.data.length
                    : searchState.filteredData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    selected: context
                                .read<DataSourceBloc>()
                                .state
                                .currentSelectedTile ==
                            null
                        ? index == 0
                        : switch ((
                            MediaQuery.of(context).orientation,
                            searchState.filteredData.isEmpty
                          )) {
                            (
                              Orientation.landscape,
                              true,
                            ) =>
                              context
                                      .read<DataSourceBloc>()
                                      .state
                                      .currentSelectedTile ==
                                  widget.data[index],
                            (Orientation.landscape, false) => context
                                    .read<DataSourceBloc>()
                                    .state
                                    .currentSelectedTile ==
                                searchState.filteredData[index],
                            _ => false,
                          },
                    selectedColor: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? Colors.blue
                        : null,
                    title: Text(searchState.filteredData.isEmpty
                        ? widget.data[index].title
                        : searchState.filteredData[index].title),
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      context.read<DataSourceBloc>().add(
                          DataSourceEventSelectTile(
                              tile: searchState.filteredData.isEmpty
                                  ? widget.data[index]
                                  : searchState.filteredData[index]));
                      if (MediaQuery.of(context).orientation ==
                          Orientation.portrait) {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailView(
                              data: widget.data[index],
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
