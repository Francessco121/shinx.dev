import 'dart:async';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_proxy/shelf_proxy.dart';

const String _proxyTo = 'http://localhost:8080';
final Uri _proxyUri = Uri.parse('$_proxyTo/');

final _proxyHandler = proxyHandler(_proxyTo);
final _staticFileRegExp = new RegExp(r'\..+$');

Future<void> main() async {
  HttpServer server = await shelf_io.serve(requestHandler, 'localhost', 8081);

  print('Proxying at http://${server.address.host}:${server.port}');
}

FutureOr<Response> requestHandler(Request request) {
  // Don't redirect static files
  if (_staticFileRegExp.hasMatch(request.url.path)) {
    print('[${DateTime.now()}] Proxying static file: ${request.url.path}');

    return _proxyHandler(request);
  }

  // If path ends with '/' or is root, add 'index.html'
  if (request.url.path.endsWith('/') || request.url.path.isEmpty) {
    print('[${DateTime.now()}] Redirecting ${request.url.path} to ${request.url.path}index.html');

    return _proxyHandler(_buildProxyRequest(request, request.url.replace(
      path: request.url.path + 'index.html'
    )));
  }

  // If path doesn't end with '.html' then add it
  if (!request.url.path.endsWith('.html')) {
    print('[${DateTime.now()}] Redirecting ${request.url.path} to ${request.url.path}.html');

    return _proxyHandler(_buildProxyRequest(request, request.url.replace(
      path: request.url.path + '.html'
    )));
  }

  // Leave anything else alone
  return _proxyHandler(request);
}

Request _buildProxyRequest(Request originalRequest, Uri uri) {
  return new Request(
    originalRequest.method, 
    uri.replace(
      scheme: _proxyUri.scheme,
      host: _proxyUri.host,
      port: _proxyUri.port
    ),
    body: originalRequest.read(),
    context: originalRequest.context,
    encoding: originalRequest.encoding,
    handlerPath: originalRequest.handlerPath,
    headers: originalRequest.headers,
    protocolVersion: originalRequest.protocolVersion
  );
}