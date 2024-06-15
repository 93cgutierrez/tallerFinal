import 'dart:async';

import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:taller_final/config/networking/model/api_failure.dart';
import 'package:taller_final/domain/entity/tv_series_entity.dart';
import 'package:taller_final/infrastructure/model/state_enum.dart';
import 'package:taller_final/presentation/screen/tv_series_details_screen.dart';

import '../provider/tv_series_provider.dart';
import '../widget/series_card_widget.dart';

class PrincipalPage extends ConsumerStatefulWidget {
  const PrincipalPage({super.key});

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends ConsumerState<PrincipalPage> {
  final _searchController = TextEditingController();
  bool _showSearchOverlay = false;

  final _controller = StreamController<SwipeRefreshState>.broadcast();

  String currentText = '';

  Stream<SwipeRefreshState> get _stream => _controller.stream;

  Future<void> _refresh() async {
    await Future<void>.delayed(const Duration(seconds: 3));

    /// When all needed is done change state.
    _controller.sink.add(SwipeRefreshState.hidden);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.watch(tvSeriesProvider.notifier).getTopRatedTvSeries();
    });
  }

  @override
  Widget build(BuildContext context) {
    final tvSeriesList =
        ref.watch(tvSeriesProvider.select((value) => value.tvSeries));
    final stateList =
        ref.watch(tvSeriesProvider.select((value) => value.state));
    return Scaffold(
      appBar: AppBarWithSearchSwitch(
        onChanged: (text) {
          _searchController.text = text;
          if (currentText != text && text.isNotEmpty) {
            currentText = text;
            ref.watch(tvSeriesProvider.notifier).searchTvSeries(query: text);
          } else if (text.isEmpty) {
            currentText = text;
            ref.watch(tvSeriesProvider.notifier).getTopRatedTvSeries();
          }
        },
        onSubmitted: (text) {
          _searchController.text = text;
          if (currentText != text && text.isNotEmpty) {
            currentText = text;
            ref.watch(tvSeriesProvider.notifier).searchTvSeries(query: text);
          } else if (text.isEmpty) {
            currentText = text;
            ref.watch(tvSeriesProvider.notifier).getTopRatedTvSeries();
          }
        },
        onCleared: () {
          _searchController.clear();
        },
        animation: AppBarAnimationSlideLeft.call,
        // animation: (child) => AppBarAnimationSlideLeft(
        //     milliseconds: 400, withFade: false, percents: 0.25, child: child),
        appBarBuilder: (context) {
          return AppBar(
            title: const Text("Todo sobre series"),
            actions: const [
              // AppBarSpeechButton(),  // in version 2.0+
              AppBarSearchButton(),
              // or
              // IconButton(onPressed: AppBarWithSearchSwitch.of(context)?startSearch, icon: Icon(Icons.search)),
            ],
          );
        },
      ),
/*      AppBar(
        title: const Text('Mi aplicación'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _showSearchOverlay = !_showSearchOverlay;
              });
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),*/
      body: stateList == StateEnum.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : stateList == StateEnum.error &&
                  (tvSeriesList == null || tvSeriesList.isEmpty)
              ? const Center(
                  child: Text('Error intentelo mas tarde'),
                )
              : stateList == StateEnum.empty &&
                      (tvSeriesList == null || tvSeriesList.isEmpty)
                  ? const Center(
                      child: Text('No se han encontrado resultados'),
                    )
                  : GridView.count(
                      crossAxisCount: 2,
                      padding: const EdgeInsets.all(16.0),
                      childAspectRatio: 8.0 / 9.0,
                      children: _buildListCard(context, tvSeriesList),
                    ),
/*      Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Text('Contenido de la aplicación: ${tvSeriesList?.length}'),
        ],
      ),*/
/*      SwipeRefresh.material(
        stateStream: _stream,
        onRefresh: _refresh,
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Text('Contenido de la aplicación: ${_searchController.text}'),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showSearchOverlay = !_showSearchOverlay;
                  });
                },
                child: const Text('Mostrar búsqueda'),
              ),
            ],
          ),
        ],
      ),*/
    );
/*      Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                const SizedBox(height: 16.0),
                Text(
                  'SHRINE',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            const SizedBox(height: 120.0),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                // Removed filled: true
                labelText: 'Busqueda',
              ),
            ),
            const SizedBox(height: 12.0),
            OverflowBar(
              alignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 8.0,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    ),
                  ),
                  child: const Text(
                    'NEXT',
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );*/
  }

  List<SeriesCardWidget> _buildListCard(
      BuildContext context, List<TvSeriesEntity>? tvSeriesList) {
    if (tvSeriesList == null) {
      return const <SeriesCardWidget>[];
    }

    if (tvSeriesList.isEmpty) {
      return const <SeriesCardWidget>[];
    }

    return tvSeriesList.map((seriesEntity) {
      return SeriesCardWidget(
        imageUrl: seriesEntity.posterPath ?? '',
        title: seriesEntity.name ?? '',
        votes: seriesEntity.voteCount ?? 0,
        onTap: () async {
          await ref.watch(tvSeriesProvider.notifier).cleanTvSeriesDetails();
          if (kDebugMode) {
            print('details: ${seriesEntity.name}');
          }
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  TvSeriesDetailsScreen(seriesId: seriesEntity.id ?? 0),
            ),
          );
        },
      );
    }).toList();
  }
}
