part of 'data_source_bloc.dart';

class DataSourceState<T extends UIModel> extends Equatable {
  final List<Simpson> simpsonData;
  final List<Wire> wireData;
  final T? currentSelectedTile;
  const DataSourceState({
    required this.simpsonData,
    required this.wireData,
    this.currentSelectedTile,
  });

  @override
  List<Object> get props =>
      [simpsonData, wireData, currentSelectedTile ?? false];

  DataSourceState copyWith(
      {List<Simpson>? simpsonData,
      List<Wire>? wireData,
      T? Function()? currentSelectedTile}) {
    return DataSourceState(
      simpsonData: simpsonData ?? this.simpsonData,
      wireData: wireData ?? this.wireData,
      currentSelectedTile: currentSelectedTile != null
          ? currentSelectedTile()
          : this.currentSelectedTile,
    );
  }
}
