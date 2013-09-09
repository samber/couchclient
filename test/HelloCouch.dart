import "dart:convert" show UTF8;
import "dart:async";
import "package:couchclient/couchclient.dart";

void main() {
  // Connect to server per the provided Uris
  // Here assume your Couchbase Server is installed on localhost
  // Use "default" bucket with no password
  CouchClient.connect([Uri.parse("http://127.0.0.1:8091/pools")], "default", "")
  // When client is ready, access the database
  .then((client) => access(client))
  // Catch all possible errors/exceptions
  .catchError((err) => print('Exception: $err'));
}

// The unique document id of the document
final String DOC_ID = "beer_Wrath";

// The Json encoded document
final String VALUE =
  '{"name":"Wrath","abv":9.0,'
  '"type":"beer","brewery_id":"110f1a10e7",'
  '"updated":"2010-07-22 20:00:20",'
  '"description":"WRATH Belgian-style ",'
  '"style":"Other Belgian-Style Ales",'
  '"category":"Belgian and French Ale"}';

Future access(CouchClient client) {
  // Do a set
  return client.set(DOC_ID, UTF8.encode(VALUE))
  // Check if set succeeded and show message
  .then((ok) => print(ok ? "Set Succeeded" : "Set failed"))
  // Then get the value back by document id
  .then((_) => client.get(DOC_ID))
  // Check if get data equals to set one
  .then((val) => UTF8.decode(val.data) == VALUE)
  // Show message
  .then((ok) => print(ok ? "Get Succeeded" : "Get failed"))
  // Close the client
  .then((_) => client.close());
}
