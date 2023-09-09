import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter_dio_example/network/api_service.dart';
import 'package:flutter_dio_example/network/interceptors/authorization_interceptor.dart';
import 'package:path_provider/path_provider.dart';

import '../models/post.dart';
import 'endpoints.dart';
import 'interceptors/interceptors.dart';


class DioService {
  late Dio _dio;

  // Private constructor
  DioService._privateConstructor() {
    _initializeDio();
  }

  static final DioService _instance = DioService._privateConstructor();

  // Singleton instance
  static DioService get instance => _instance;

  void _initializeDio() async {
    var cacheDir = await getTemporaryDirectory();

    var cacheStore = HiveCacheStore(
      cacheDir.path,
      hiveBoxName: "dio_cache_example",
    );

    var customCacheOptions = CacheOptions(
      store: cacheStore,
      policy: CachePolicy.forceCache,
      priority: CachePriority.high,
      maxStale: const Duration(minutes: 1),
      hitCacheOnErrorExcept: [401, 404],
      keyBuilder: (request) {
        return request.uri.toString();
      },
      allowPostMethod: false,
    );

    _dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.baseURL,
        connectTimeout: Endpoints.connectionTimeout,
        receiveTimeout: Endpoints.receiveTimeout,
        responseType: ResponseType.json,
      ),
    )..interceptors.addAll([
      DioCacheInterceptor(options: customCacheOptions),
      LoggerInterceptor()
    ]);
  }

  Future<List<Post>> fetchPosts() async {
    final response = await ApiService.handleApiCall(
      _dio.get(Endpoints.users),
    );
    print(response);
    List<Post> users = response.data
        .map((data) => Post.fromJson(data))
        .toList()
        .cast<Post>();
    return users;
  }

}
