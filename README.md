**AFAbstractRESTClient** is simple abstract solution to deal with REST webservices using AFNetworking.
It basically adds some structure to API calls by separating each type of operation to a class.

In classical approach one can use [façade pattern](http://en.wikipedia.org/wiki/Facade_pattern) to create a fat client with API methods.

This solution is based on [Template method pattern](http://en.wikipedia.org/wiki/Template_method_pattern) and allows developers to create API calls 'on-the-fly'. 

Typical HTTP request consists of a few steps combined into one operation in abstract class which calls only a few methods it needs from subclass.
Framework `Abstract[GET|POST|DELETE]APICall` classes are responsible for:
* turning on status bar network indicator,
* asking subclass for `path` for given API call,
* asking subclass for `query params` (optional),
* configuring AFJSONRequestOperation given all parameters needed,
* logging success data or error failure,
* asking subclass to parse data from passed JSON object,
* calling success or failure block accordingly to call result,
* turning off status bar network indicator.
 
In most typical situation you don't have to write this whole logic yourself. You only need to override 2 methods: `path` and `parse data` to communicate with your API.

Examples for GET and POST requests are included in Tests.

## How to get started

### If you use cocoapods (you should! :) )
- add `pod 'AFAbstractRESTClient'` into your Podfile
- run `pod install`
- add `NSString *kServerURLString = @"http://YOUR_SERVER_ADDRESS/";` somewhere in your app. This is basic URL for your server. Each `path` method inside *Call object should return path related to this.
- open `AFAbstractRESTClient-Prefix.pch` file and uncomment useful macros `NETWORK_ON` and `NETWORK_OFF` to show status bar network indicator
- see `AFAbstractRESTClientTests.m` file with example test/usages for GET and POST requests

### If you don't use cocoapods or just want to test the library alone
- Download AFAbstractRESTClient
- call `pod install` to install required AFNetworking
- if you have never used [cocoapods](http://cocoapods.org/) remember to open `AFAbstractRESTClient.xcworkspace` rather than `AFAbstractRESTClient.xcodeproj`
- see `AFAbstractRESTClientTests.m` file with example test/usages for GET and POST requests
- run tests by pressing `Cmd+U`
- use in your own project (by dragging the project into your project in Xcode) if you like :)

## Example GET Call
* create class that inherits from AbstractGETAPICall and override **only required methods**:

``` objective-c
#import "AbstractGETAPICall.h"

@interface GithubGETCall : AbstractGETAPICall

@end
```
``` objective-c
#import "GithubGETCall.h"

@implementation GithubGETCall

- (NSString*) path {
    return @"https://api.github.com/repos/burczyk/AFAbstractRESTClient";
}

- (void) parseResponseData: (id) JSON withSuccessBlock:(void (^)(id JSON)) blockSuccess {
    // You can parse your data here, e.g. write them to Core Data/SQLite or create your own model.
    // After parsing you can return either JSON or parsed object as input for block is (id)
    blockSuccess(JSON);
}

@end
```

* use it anywhere in your code in simple way:

``` objective-c
GithubGETCall *call = [[GithubGETCall alloc] init];
[call executeAPICallWithSuccessBlock:^(id responseObject) {
	
} failure:^(NSError *error, id responseObject) {
    
}];
```

## Example POST Call with multipart/form-data
* create class that inherits from AbstractPOSTAPICall and override **only required methods**:

``` objective-c
#import "AbstractPOSTAPICall.h"

@interface HttpBinPOSTCall : AbstractPOSTAPICall

@end
```
``` objective-c
#import "HttpBinPOSTCall.h"

@implementation HttpBinPOSTCall

- (NSString*) path {
    return @"post";
}

- (NSDictionary*) queryParams {
    return @{ @"arg1" : @"value1", @"arg2" : @3.141592 };
}

- (void) constructBody:(id <AFMultipartFormData>) formData {
    
    // image source: http://commons.wikimedia.org/wiki/File:Mila_Kunis_2012.jpg
    NSData *image = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Mila_Kunis_2012.jpg/128px-Mila_Kunis_2012.jpg"]];
    
    [formData appendPartWithFormData:[@"example data" dataUsingEncoding:NSUTF8StringEncoding] name:@"key1"];
    [formData appendPartWithFormData:image name:@"Mila_Kunis_2012.jpg"];
}

@end
```

* use it anywhere in your code in simple way:

``` objective-c
HttpBinPOSTCall *call = [[HttpBinPOSTCall alloc] init];
[call executeAPICallWithSuccessBlock:^(id responseObject) {

} failure:^(AFHTTPRequestOperation *operation, NSError *error) {

} progress:^(long long totalBytesWritten, long long totalBytesExpectedToWrite) {

}];
```

## License
**AFAbstractRESTClient** is available under the MIT license. See the LICENSE file for more info.
