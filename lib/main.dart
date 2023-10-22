import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simpsons_demo/blocs/search/search_bloc.dart';
import 'package:simpsons_demo/network/wire_data_source.dart';
import 'package:simpsons_demo/presentation/device_layout.dart';
import 'package:simpsons_demo/presentation/components/search_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpsons_demo/presentation/tablet/tablet_view.dart';

import 'blocs/datasource/data_source_bloc.dart';
import 'network/simpsons_data_source.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint(bloc.toString());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool dataToggle = false;
  bool orientationToggle = false;
  DataSourceOrigins origin = DataSourceOrigins.simpsons;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              DataSourceBloc(SimpsonsDataSourceImpl(), WireDataSourceImpl())
                ..add(const DataSourceEventFetch()),
        ),
        BlocProvider(create: (context) => SearchBloc()),
      ],
      child: SafeArea(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: BlocBuilder<DataSourceBloc, DataSourceState>(
              builder: (context, state) {
                final data = origin == DataSourceOrigins.simpsons
                    ? state.simpsonData
                    : state.wireData;

                if (data.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Scaffold(
                    appBar: AppBar(
                      title: origin == DataSourceOrigins.simpsons
                          ? const Text('Simpsons demo')
                          : const Text('Wire demo'),
                      elevation: 0.5,
                    ),
                    floatingActionButton: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          onPressed: () async {
                            await SystemChrome.setPreferredOrientations([
                              orientationToggle
                                  ? DeviceOrientation.portraitUp
                                  : DeviceOrientation.landscapeLeft,
                              orientationToggle
                                  ? DeviceOrientation.portraitDown
                                  : DeviceOrientation.landscapeRight,
                            ]);
                            setState(() {
                              FocusScope.of(context).unfocus();
                              orientationToggle = !orientationToggle;
                            });
                          },
                          child: orientationToggle
                              ? const Icon(Icons.portrait)
                              : const Icon(Icons.landscape),
                        ),
                        const SizedBox(height: 16),
                        FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              FocusScope.of(context).unfocus();
                              dataToggle = !dataToggle;
                              origin = origin == DataSourceOrigins.simpsons
                                  ? DataSourceOrigins.wire
                                  : DataSourceOrigins.simpsons;
                              context
                                  .read<SearchBloc>()
                                  .add(const SearchClearQuery());
                            });
                          },
                          child: const Icon(Icons.swap_horiz),
                        ),
                      ],
                    ),
                    body: DeviceLayout(
                      phoneView: SearchView(data: data),
                      tabletView: Row(
                        children: [
                          SizedBox(width: 300, child: SearchView(data: data)),
                          const VerticalDivider(),
                          Expanded(
                            child: DetailView(
                              data: state.currentSelectedTile ?? data.first,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

enum DataSourceOrigins { wire, simpsons }
