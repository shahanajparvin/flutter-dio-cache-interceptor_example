<div align="center">
  <h1>Flutter Dio Cache Interceptor Example</h1>
</div>

<h2>Overview</h2>

<p>Caching is a crucial process for storing API responses on a user's device to reduce network requests and improve performance in Flutter apps. This example demonstrates how to implement caching for API requests using the Dio HTTP client and the Dio Cache Interceptor.</p>

<h2>Key Components</h2>

<ul>
  <li><strong>Dio:</strong> A powerful HTTP client for Flutter.</li>
  <li><strong>Dio Cache Interceptor:</strong> An interceptor for Dio that allows efficient API response caching.</li>
  <li><strong>Hive:</strong> A fast and lightweight key-value database in Dart used as the cache store.</li>
</ul>

<h2>Implementation Steps</h2>

<h3>1. Add Dependencies</h3>

<p>In your `pubspec.yaml` file, add the required packages:</p>

<pre>
<code>
dependencies:
  dio: ^4.0.6
  dio_cache_interceptor: ^3.3.0
  dio_cache_interceptor_hive_store: ^3.2.0
  hive: ^2.0.5
</code>
</pre>

<h3>2. Set Up Cache Directory</h3>

<p>Get the temporary directory on the device where cached data will be stored. It's recommended to use the temporary directory provided by Flutter:</p>

<pre>
<code>
var cacheDir = await getTemporaryDirectory();
</code>
</pre>

<h3>3. Build Cache Store</h3>

<p>Create a cacheStore object, specifying the cache directory path and a unique hiveBoxName for your app:</p>

<pre>
<code>
var cacheStore = HiveCacheStore(
  cacheDir.path,
  hiveBoxName: "your_app_name",
);
</code>
</pre>

<h3>4. Define Cache Options</h3>

<p>Customize cache options to control caching behavior, such as cache policy, priority, maxStale duration, key building, and more:</p>

<pre>
<code>
var customCacheOptions = CacheOptions(
  store: cacheStore,
  policy: CachePolicy.forceCache,
  priority: CachePriority.high,
  maxStale: const Duration(minutes: 5),
  hitCacheOnErrorExcept: [401, 404],
  keyBuilder: (request) {
    return request.uri.toString();
  },
  allowPostMethod: false,
);
</code>
</pre>

<h3>5. Build Dio with Cache Interceptor</h3>

<p>Create a Dio instance and add the cache interceptor with your custom cache options:</p>

<pre>
<code>
var customDio = Dio()
  ..interceptors.add(DioCacheInterceptor(options: customCacheOptions));
</code>
</pre>

<h2>Best Practices for Network Calling and Error Handling</h2>

<p>Follow these best practices when using Dio for network requests:</p>

<ul>
  <li>Use Dio's try-catch mechanism to handle network errors gracefully.</li>
  <li>Implement loading indicators to provide feedback during network requests.</li>
  <li>Handle timeouts and connectivity issues.</li>
  <li>Display appropriate error messages to the user.</li>
</ul>

<h2>Usage</h2>

<p>Now, all your GET requests made using the customDio object will be cached in the user's device storage temporary directory while following best practices for network calling and error handling.</p>

<p>Feel free to explore and customize this example for your Flutter app's caching needs.</p>
