//Copyright (C) 2013 Potix Corporation. All Rights Reserved.
//History: Thu, Mar 07, 2013  02:43:41 PM
// Author: hernichen

part of couchclient;

abstract class PutHttpOP extends HttpOP {
  String value;

  Future<HttpResult> handleCommand(HttpClient hc, Uri baseUri, Uri cmd,
      AuthDescriptor authDescriptor) {
    final String user = authDescriptor == null ? null : authDescriptor.bucket;
    final String pass = authDescriptor == null ? null : authDescriptor.password;
    //_logger.finest("user:$user, pass:$pass");
    return HttpUtil.uriPut(hc, baseUri, cmd, user, pass, this.value,
        {'content-type' : 'application/json'});
  }
}

