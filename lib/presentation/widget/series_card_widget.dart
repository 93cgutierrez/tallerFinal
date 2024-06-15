import 'package:flutter/material.dart';
import 'package:taller_final/config/networking/utils/parameters_api_util.dart';

import 'image_from_network_widget.dart';

class SeriesCardWidget extends StatelessWidget {
  const SeriesCardWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.votes,
    this.onTap,
  }) : super(key: key);

  final String imageUrl;
  final String title;
  final int votes;
  final VoidCallback? onTap; // Make it nullable to allow no action

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(16),
        color: Colors.black.withOpacity(0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Full-size image
            //Image.asset('assets/diamond.png'),
            //ImageFromNetwork(imageUrl: imageUrl, width: 20, height: 20),
            Image.network(
              ParametersApiUtil.baseUrlImage + imageUrl,
              fit: BoxFit.cover,
              height: double.infinity,
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
                        title,
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
                      children: [
                        const Icon(
                          Icons.thumb_up_alt_rounded,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          votes.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
