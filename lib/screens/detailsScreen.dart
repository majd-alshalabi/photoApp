import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:task/constant.dart';
import 'package:task/helper/providerHelper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  static const String id = "_detailsScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondColor,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                imageUrl: context.read<ProviderHelper>().imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  child: new Text(
                    'see at the image site',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  onTap: () => launch(context.read<ProviderHelper>().imageUrl)),
            ],
          ),
        ),
      ),
    );
  }
}
