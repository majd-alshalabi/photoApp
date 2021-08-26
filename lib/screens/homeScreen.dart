import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:task/constant.dart';
import 'package:task/helper/api/pixabayApi.dart';
import 'package:task/helper/database/jsonSaver.dart';
import 'package:task/helper/providerHelper.dart';
import 'package:task/module/imageModule.dart';
import 'package:task/reuseableWidget.dart';
import 'package:task/screens/detailsScreen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static final String id = "homePage";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  bool loading = true;
  bool noData = false;
  var databaseJsonData;
  int currentPage = 1;
  List<Hit> imageData = [];

  Future<bool> initStateFunction({isRefreshing = false}) async {
    if (isRefreshing) {
      currentPage = 1;
      final data = await getHttp(currentPage);
      if (data != null) {
        Welcome li = Welcome.fromJson(data);
        imageData = li.hits;
        if (currentPage == 1) await addJsonToDatabase(data);
        currentPage++;
        setState(() {});
        return true;
      } else {
        databaseJsonData = await getJsonFromDatabase();
        if (databaseJsonData == null) {
          return false;
        } else {
          imageData = [];
          for (int i = 0; i < databaseJsonData['hits'].length; i++) {
            imageData.add(Hit.fromJson(databaseJsonData['hits'][i]));
          }
          setState(() {});
          return true;
        }
      }
    }
    final data = await getHttp(currentPage);
    if (data != null) {
      Welcome li = Welcome.fromJson(data);
      imageData.addAll(li.hits);
      if (currentPage == 1) await addJsonToDatabase(data);
      currentPage++;
      setState(() {});
      return true;
    } else {
      if (currentPage == 1) {
        databaseJsonData = await getJsonFromDatabase();
        if (databaseJsonData == null) {
          return false;
        } else {
          imageData = [];
          for (int i = 0; i < databaseJsonData['hits'].length; i++) {
            imageData.add(Hit.fromJson(databaseJsonData['hits'][i]));
          }
          setState(() {});
          return true;
        }
      } else {
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MainDrawar(),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: secondColor,
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: SmartRefresher(
            enablePullUp: true,
            controller: refreshController,
            onLoading: () async {
              final result = await initStateFunction();
              if (result) {
                refreshController.loadComplete();
              } else {
                refreshController.loadFailed();
              }
            },
            onRefresh: () async {
              final result = await initStateFunction(isRefreshing: true);
              if (result) {
                refreshController.refreshCompleted();
              } else {
                refreshController.refreshFailed();
              }
            },
            child: ListView.builder(
              itemCount: imageData.length,
              itemBuilder: (context, idx) => Container(
                margin: EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height / 3,
                width: double.infinity,
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    onTap: () {
                      context.read<ProviderHelper>().imageUrl =
                          imageData[idx].webformatUrl;
                      Navigator.pushNamed(context, DetailsScreen.id);
                    },
                    child: CachedNetworkImage(
                      imageUrl: imageData[idx].webformatUrl,
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
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
