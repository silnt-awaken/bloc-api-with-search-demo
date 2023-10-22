import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpsons_demo/data/simpson_character/api/related_topic.dart'
    as simpson;
import 'package:simpsons_demo/data/ui_model.dart';
import 'package:simpsons_demo/data/wire_character/api/related_topic.dart'
    as wire;
import 'package:simpsons_demo/data/simpson_character/ui/simpson.dart';
import 'package:simpsons_demo/data/wire_character/ui/wire.dart';
import 'package:simpsons_demo/network/data_source.dart';

import '../../data/simpson_character/api/base_model.dart';

part 'data_source_event.dart';
part 'data_source_state.dart';

class DataSourceBloc<T extends BaseModel>
    extends Bloc<DataSourceEvent, DataSourceState> {
  final DataSource<T> simpsonDataSource;
  final DataSource<T> wireDataSource;
  DataSourceBloc(this.simpsonDataSource, this.wireDataSource)
      : super(const DataSourceState(simpsonData: [], wireData: [])) {
    on<DataSourceEventFetch>((event, emit) async {
      final List<Simpson> simpsonData = [];
      List<simpson.RelatedTopic> rawSimpsonData =
          await simpsonDataSource.fetchData() as List<simpson.RelatedTopic>;

      rawSimpsonData.map((simpson) {
        simpsonData.add(Simpson.fromRelatedTopic(simpson));
      }).toList();

      final List<Wire> wireData = [];
      List<wire.RelatedTopic> rawWireData =
          await wireDataSource.fetchData() as List<wire.RelatedTopic>;

      rawWireData.map((wire) {
        wireData.add(Wire.fromRelatedTopic(wire));
      }).toList();

      emit(state.copyWith(simpsonData: simpsonData, wireData: wireData));
    });

    on<DataSourceEventSelectTile>((event, emit) {
      emit(state.copyWith(currentSelectedTile: () => event.tile));
    });
  }
}
