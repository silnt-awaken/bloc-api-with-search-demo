part of 'data_source_bloc.dart';

sealed class DataSourceEvent extends Equatable {
  const DataSourceEvent();

  @override
  List<Object> get props => [];
}

class DataSourceEventFetch extends DataSourceEvent {
  const DataSourceEventFetch();
}

class DataSourceEventSelectTile<T extends UIModel> extends DataSourceEvent {
  final T tile;
  const DataSourceEventSelectTile({required this.tile});

  @override
  List<Object> get props => [tile];
}
