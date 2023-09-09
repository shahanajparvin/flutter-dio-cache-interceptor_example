/*
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor/src/model/cache_strategy.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:path_provider/path_provider.dart';



class CustomDioCacheInterceptor extends DioCacheInterceptor {
  //late final Directory cacheDir;
 // late final HiveCacheStore cacheStore;

  CustomDioCacheInterceptor({CacheOptions? customCacheOptions})
      : super(options: customCacheOptions ?? defaultCacheOptions) {
    _initializeCache();
  }

  void _initializeCache() async {
    cacheDir = await getTemporaryDirectory();

    static HiveCacheStore cacheStore = HiveCacheStore(
      cacheDir.path,
      hiveBoxName: "your_app_name",
    );
  }

  static CacheOptions defaultCacheOptions = CacheOptions(
    store: HiveCacheStore(
      cacheDir.path,
      hiveBoxName: "your_app_name",
    ),
    policy: CachePolicy.forceCache,
    priority: CachePriority.high,
    maxStale: const Duration(minutes: 5),
    hitCacheOnErrorExcept: [401, 404],
    keyBuilder: (request) {
      return request.uri.toString();
    },
    allowPostMethod: false, store: null,
  );
}
*/
