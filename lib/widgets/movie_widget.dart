import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/var.dart';

class MovieWidget extends StatelessWidget {
  final String image;
  final String title;
  final String overview;
  final String releaseDate;
  MovieWidget(
      {required this.title,
      required this.overview,
      required this.image,
      required this.releaseDate});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              child: CachedNetworkImage(
                imageUrl: Constant.baseUrlOfImage + image,
                height: 140,
                fit: BoxFit.fill,
                placeholder: (_, __) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (_, __, ___) => Center(
                  child: Icon(
                    Icons.error,
                    color: Theme.of(context).errorColor,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    child: Text(
                      title,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  // const Spacer(),
                  Text(
                    overview,
                    style: Theme.of(context).textTheme.headline1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Text(
                    releaseDate,
                    style: Theme.of(context).textTheme.headline5,
                    maxLines: 1,
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
