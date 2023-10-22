import 'package:mocktail/mocktail.dart';
import 'package:simpsons_demo/network/simpsons_data_source.dart';
import 'package:simpsons_demo/network/wire_data_source.dart';

class MockSimpsonsDataSource extends Mock implements SimpsonsDataSourceImpl {}

class MockWireDataSource extends Mock implements WireDataSourceImpl {}
