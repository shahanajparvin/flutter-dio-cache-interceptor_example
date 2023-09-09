import 'package:dio/dio.dart';
import 'package:flutter_dio_example/network/dio_exception.dart';

// ignore: constant_identifier_names
const String API_KEY =
    'cdc9a8ca8aa17b6bed3aa3611a835105bbb4632514d7ca8cf55dbbc5966a7cae';

//* Request methods PUT, POST, PATCH, DELETE needs access token,
//* which needs to be passed with "Authorization" header as Bearer token.
class AuthorizationInterceptor extends Interceptor {
  get Fluttertoast => null;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('-------gffhfhfg');
    if (_needAuthorizationHeader(options)) {
      options.headers['Authorization'] = 'Bearer $API_KEY';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final errorMessage = DioException.fromDioError(err).toString();

    print('---cvcxvcxvcx'+errorMessage);

  /*  Fluttertoast.showToast(
      msg: errorMessage,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );*/

    super.onError(err, handler);
  }

  bool _needAuthorizationHeader(RequestOptions options) {
    if (options.method == 'GET') {
      return false;
    } else {
      return true;
    }
  }
}
