AFAbstractRESTClient is simple abstract solution to deal with REST webservices using AFNetworking.
It basically adds some structure to API calls by separating each type of operation to a class.

In classical approach one can use [façade pattern](http://en.wikipedia.org/wiki/Facade_pattern) to create a fat client with API methods.

This solution is based on [Template method pattern](http://en.wikipedia.org/wiki/Template_method_pattern) and allows developers to create API calls 'on-the-fly'. 

Typical HTTP request consists of a few steps:
* create request with address
* decorate request with authentication etc.
* add asynchronous task with request
* parse response data or display error
* return data to calling block

They can all be combined into one abstract task, which only asks for some information that's missing.
E.g. GET request asks only for path and call parseData when request is completed.
Examples are included in Tests.

## How to get started
- Download AFAbstractRESTClient
- call `pod install` to install required AFNetworking
- see `AFAbstractRESTClientTests.m` file with example test/usages
- run tests by pressing `Cmd+U`
- use in your own project if you like :)

##Example GET Call
* create class that inherits from AbstractGETAPICall and override required methods
``` objective-c
#import "AbstractGETAPICall.h"

@interface GitHubGETCall : AbstractGETAPICall

@end
```
``` objective-c
#import "GitHubGETCall.h"

@implementation GitHubGETCall

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

* use it anywhere in your code 
``` objective-c
GitHubGETCall *call = [[GitHubGETCall alloc] init];
[call executeAPICallWithSuccessBlock:^(id responseObject) {
	
} failure:^(NSError *error, id responseObject) {
    
}];
```