A class of conversions between Shelf.Request in instances of jsonable_objects and Shelf.Responses created from jsonable_objects

## Usage

A simple usage example:

### Required
install dependencies with https://pub.dev/packages/jsonable_object


```dart
import 'package:shelf_request_response_2_json_utility/shelf_request_response_2_jsonable_object_utility.dart';

class Controller {
  final ShelfRequestResponse2JsonUtility<Person> // Person implements IConvertToJson
  shelfRequestResponse2JsonUtility =
  ShelfRequestResponse2JsonUtility<Person>(PersonFactory());

  @Route.post('/')
  FutureOr<Response> post(Request request) {
    var body = shelfRequestResponse2JsonUtility.body(request);
    return shelfRequestResponse2JsonUtility.ok(body);
  }

  Router get router => _$ControllerRouter(this);
}

```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
