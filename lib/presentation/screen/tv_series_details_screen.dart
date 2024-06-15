import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taller_final/config/networking/utils/parameters_api_util.dart';
import 'package:taller_final/domain/entity/tv_series_season_entity.dart';

import '../../domain/entity/tv_series_details_entity.dart';
import '../../infrastructure/model/state_enum.dart';
import '../provider/tv_series_provider.dart';
import '../widget/series_card_widget.dart';

class TvSeriesDetailsScreen extends ConsumerStatefulWidget {
  final int seriesId;

  const TvSeriesDetailsScreen({Key? key, required this.seriesId})
      : super(key: key);

  @override
  _TvSeriesDetailsScreenState createState() => _TvSeriesDetailsScreenState();
}

class _TvSeriesDetailsScreenState extends ConsumerState<TvSeriesDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .watch(tvSeriesProvider.notifier)
          .getTvSeriesDetails(seriesId: widget.seriesId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final stateList =
        ref.watch(tvSeriesProvider.select((value) => value.state));
    final tvSeries = ref
        .watch(tvSeriesProvider.select((value) => value.tvSeriesDetailsEntity));
    return Scaffold(
      appBar: AppBar(
        title: Text(stateList != StateEnum.ok ? '' : tvSeries?.name ?? ''),
      ),
      body: stateList == StateEnum.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : stateList == StateEnum.error && tvSeries == null
              ? const Center(
                  child: Text('Error intentelo mas tarde'),
                )
              : stateList == StateEnum.empty && tvSeries == null
                  ? const Center(
                      child: Text('No se han encontrado resultados'),
                    )
                  : _buildBody(tvSeries),
    );
  }

  Widget _buildBody(TvSeriesDetailsEntity? tvSeries) {
    if (tvSeries == null) {
      return const Center(
        child: Text('No se han encontrado resultados'),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del póster
            Image.network(
              '${ParametersApiUtil.baseUrlImage}${tvSeries.backdropPath}',
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),

            // Descripción de la serie
            Text(tvSeries.overview!),
            const SizedBox(height: 20),

            // Temporadas y otros datos
            const Text('Temporadas:'),
            const SizedBox(height: 8),
            if (tvSeries.seasons != null)
              ...tvSeries.seasons!.map((season) {
                return buildCard(season, null);
              })
            else
              const Text('No hay información disponible'),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Otros datos
                const SizedBox(height: 10),
                const Text('Otros datos:'),
                const SizedBox(height: 8),
                if (tvSeries.adult != null)
                  Text('Adulto: ${tvSeries.adult! ? 'Sí' : 'No'}'),
                if (tvSeries.id != null)
                  Text('ID: ${tvSeries.id!}',
                      style: const TextStyle(fontSize: 10)),
                if (tvSeries.numberOfEpisodes != null)
                  Text('Número de episodios: ${tvSeries.numberOfEpisodes!}',
                      style: const TextStyle(fontSize: 10)),
                if (tvSeries.originalName != null)
                  Text('Nombre original: ${tvSeries.originalName!}',
                      style: const TextStyle(fontSize: 10)),
                if (tvSeries.popularity != null)
                  Text('Popularidad: ${tvSeries.popularity!}',
                      style: const TextStyle(fontSize: 10)),
                if (tvSeries.status != null)
                  Text('Estado: ${tvSeries.status!}',
                      style: const TextStyle(fontSize: 10)),
                if (tvSeries.voteAverage != null)
                  Text('Promedio de votos: ${tvSeries.voteAverage!}',
                      style: const TextStyle(fontSize: 10)),
                if (tvSeries.voteCount != null)
                  Text('Conteo de votos: ${tvSeries.voteCount!}',
                      style: const TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(TvSeriesSeasonEntity season, VoidCallback? onTap) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(16),
          color: Colors.black.withOpacity(0.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Full-size image
              //Image.asset('assets/diamond.png'),
              //ImageFromNetwork(imageUrl: imageUrl, width: 20, height: 20),
              Image.network(
                '${ParametersApiUtil.baseUrlImage}${season.posterPath}',
                fit: BoxFit.cover,
                height: 150,
                width: double.infinity,
              ),

              // Translucent container for title and votes
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Center(
                        child: Text(
                          season.name ?? 'No name',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      // Votes
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildItem(
                              icon: Icons.movie,
                              text: season.seasonNumber.toString()),
                          buildItem(
                              icon: Icons.tv,
                              text: season.episodeCount.toString()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
