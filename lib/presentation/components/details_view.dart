import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailsView extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const DetailsView(
      {required this.image,
      required this.title,
      required this.description,
      super.key});

  @override
  Widget build(BuildContext context) {
    // an image at the top, convering the whole width, half the screen height,
    // and with a 16:9 aspect ratio, with some margin around it (16dp)
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          child: CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Placeholder(),
          ),
        ),
        // a title and description below the image, with some margin around it (16dp)
        Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
