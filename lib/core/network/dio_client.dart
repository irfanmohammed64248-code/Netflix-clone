import 'package:api_netflix/core/constants/api_constants.dart';
import 'package:dio/dio.dart';

class DioClient {
  final Dio dio = Dio(BaseOptions(baseUrl: "https://api.themoviedb.org/3"));

  DioClient() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers["Authorization"] =
              "Bearer ${ApiConstants.accessToken}";
          handler.next(options);
        },
      ),
    );
  }
}
