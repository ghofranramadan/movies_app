import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/var.dart';

class MovieWidget extends StatelessWidget {
  final String image;
  final String title;
  final String overview;
  final Function onTap;
  MovieWidget(
      {required this.title,
      required this.overview,
      required this.image,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap(),
      child: Container(
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
                child:
                    // Image(
                    //   image: NetworkImage(
                    //     'https://image.freepik.com/free-psd/3d-space-rocket-with-smoke_23-2148938939.jpg',
                    //   ),
                    //   height: 140,
                    //   fit: BoxFit.fill,
                    // ),
                    CachedNetworkImage(
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
                    const SizedBox(),
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
