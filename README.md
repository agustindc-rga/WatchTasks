# WatchTasks

WatchTasks is a lightweight framework that provides a client/server interface between WatchKit Extensions and their parent Apps.

The WatchKit extension acts as the client, sending requests to the parent application, which acts as the server. This is done using a mechanism provided by the WatchKit framework which allows exchanging information in the form of NSDictionary instances:

```
WKInterfaceController:
+ (BOOL)openParentApplication:(NSDictionary *)userInfo reply:(void(^)(NSDictionary *replyInfo, NSError *error)) reply;
```

```
UIApplicationDelegate
- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void(^)(NSDictionary *replyInfo))reply;
```

## Usage

### Requests
The client will send instances of `WTTaskRequest` to the server, configured with a task type and  custom parameters. The task type can be any string, and is typically used by the task handlers to identify which requests should be handled. The parameters are sent via a dictionary, and its contents must be serializable to a property list file.

### Responses
The server will send back an instance of `WTTaskResponse` for every request received. The response contains a dictionary with any associated response data. The contents of this dictionary must be serializable to a property list file. Responses also have an associated error message string, which is used by the task handlers and the framework to report any errors in the task or the communication.

### Server
The main application is expected to create and manage an instance of `WTTaskServer` (or a subclass). This server should then be configured by registering classes that will act as task handlers. These classes need to implement the `WTTask` protocol. The application delegate should implement the `application:handleWatchKitExtensionRequest:reply` method, where the received dictionary should be converted to a request and sent to the server instance along with the reply block.

### Tasks
The `WTTask` protocol, used for task handlers, is used to determine which tasks the class can handle and then perform the actual handling. Typically the application code will contain several classes that implement this protocol, one per type of task.

### Client
The WatchKit extension is expected to create and manage an instance of `WTTaskClient` (or a subclass). This object is then used to send task requests to the main application.

## Examples

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

WatchTasks is available as a private Pod using [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "WatchTasks", :git => 'git@gitlab.web.rga.com:ba-ios/watch-tasks.git'

## Author

Agustin de Cabrera, agustin.decabrera@rga.com

## License

WatchTasks is available under the MIT license. See the LICENSE file for more info.

