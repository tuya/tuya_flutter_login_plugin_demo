#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import <ThingSmartHomeKit/ThingSmartKit.h>


static NSString * const your_app_key = @"<#AppKey#>";
static NSString * const your_secret_key = @"<#SecretKey#>";

@implementation AppDelegate 

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    
  [[ThingSmartSDK sharedInstance] startWithAppKey:your_app_key secretKey:your_secret_key];
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
