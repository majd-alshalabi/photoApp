import 'package:dio/dio.dart';

Future getHttp(int pageNum) async {
  try {
    var response = await Dio().get(
      'https://pixabay.com/api/?key=23080979-026f4ee13969ea4f544fe2d57&q=yellow+flowers&image_type=photo&page=$pageNum&per_page=8',
    );
    return response.data;
  } catch (e) {
    return null;
  }
}
