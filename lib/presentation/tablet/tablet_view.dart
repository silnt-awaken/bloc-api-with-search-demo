import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:simpsons_demo/data/ui_model.dart';
import 'package:simpsons_demo/network/constants.dart';

class DetailView<T extends UIModel> extends StatelessWidget {
  final T data;
  const DetailView({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    final constructedImage = imageBaseUrl + data.image;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              height: MediaQuery.of(context).size.height / 2,
              imageUrl: constructedImage,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) {
                return const Placeholder();
              },
            ),
            Column(
              children: [
                const SizedBox(height: 16),
                Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  data.description,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
