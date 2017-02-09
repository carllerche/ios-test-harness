#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TestDelegate: UIResponder<UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@end

int main(int argc, char* argv[]);

// Terrible hack, but it is easy...
int argc;
char** argv;

@implementation TestDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.rootViewController = [[UIViewController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    int res = main(argc, argv);
    exit(res);
    
    return YES;
}

@end

int ios_main(int _argc, char** _argv) {
    argc = _argc;
    argv = _argv;
    
    @autoreleasepool {
        UIApplicationMain(_argc, _argv, nil, NSStringFromClass([TestDelegate class]));
    }
    
    return 0;
}
