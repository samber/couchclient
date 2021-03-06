//Copyright (C) 2013 Potix Corporation. All Rights Reserved.
//History: Wed, Mar 06, 2013  09:47:04 PM
// Author: henrichen

import 'dart:async';
import 'package:unittest/unittest.dart';
import 'package:couchclient/couchclient.dart';
import 'package:memcached_client/memcached_client.dart';
import 'CouchbaseTestUtil.dart' as cc;

void testPutDesignDocOP0(CouchClient client, String designDocName) {
  ViewDesign view1 = new ViewDesign('xyzview', 'function(doc, meta) {emit([doc.brewery_id]);}');
  expect(client.addDesignDoc(new DesignDoc(designDocName, views:[view1])), completion(true));
}

void main() {
  setupLogger();
  group('PutDesignDocOPTest:', () {
    CouchClient client;
    setUp(() => cc.prepareCouchClient().then((c) => client = c));
    tearDown(() => client.close());
    test('TestPutDesignDocOP0', () => testPutDesignDocOP0(client, 'xyzdoc'));
  });
}


