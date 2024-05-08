#import "ThingFlutterLoginPlugin.h"
#import <ThingSmartBaseKit/ThingSmartBaseKit.h>

static FlutterMethodChannel * sLoginPluginChannel;

@implementation ThingFlutterLoginPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    sLoginPluginChannel = [FlutterMethodChannel
                           methodChannelWithName:@"thing_flutter_login_plugin"
                           binaryMessenger:[registrar messenger]];
    ThingFlutterLoginPlugin* instance = [[ThingFlutterLoginPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:sLoginPluginChannel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
#ifdef DEBUG
    NSLog(@"=====>iOS Native receive FlutterMethodCall method:%@  arguments:%@", call.method, call.arguments);
#endif
    
    NSDictionary * dic = call.arguments;
    if (![dic isKindOfClass:NSDictionary.class]) {
        result(@{@"success":@(NO),
                 @"errorMsg": @"Illegal parameter"});
        return;
    }
    if ([@"sendVerifyCode" isEqualToString:call.method]) {
        [self sendVerifyCode:dic result:result];
    } else if ([@"registerByEmail" isEqualToString:call.method]) {
        [self registerByEmail:dic result:result];
    } else if ([@"loginByEmail" isEqualToString:call.method]) {
        [self loginByEmail:dic result:result];
    }
    else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)sendVerifyCode:(NSDictionary *)arguments result:(FlutterResult)result {
    NSString * usetName = [arguments objectForKey:@"userName"];
    NSString * region = [arguments objectForKey:@"region"];
    NSString * countryCode = [arguments objectForKey:@"countryCode"];
    NSUInteger type = [[arguments objectForKey:@"type"] integerValue];
    
    if (usetName.length == 0 ||
        countryCode.length == 0
        ) {
        result(@{@"success":@(NO),
                 @"errorMsg": @"Illegal parameter"});
        return;
    }
    
    [[ThingSmartUser sharedInstance] sendVerifyCodeWithUserName:usetName
                                                         region:region countryCode:countryCode type:type
                                                        success:^{
        result(@{@"success":@(YES)});
    } failure:^(NSError *error) {
        result(@{@"success":@(NO),
                 @"errorMsg": error.localizedDescription});
    }];
    
#ifdef DEBUG
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.class testCallFlutterFunc];
    });
#endif
}

- (void)registerByEmail:(NSDictionary *)arguments result:(FlutterResult)result {
    NSString * email = [arguments objectForKey:@"email"];
    NSString * password = [arguments objectForKey:@"password"];
    NSString * countryCode = [arguments objectForKey:@"countryCode"];
    NSString * code = [arguments objectForKey:@"code"];
    
    if (email.length == 0 ||
        password.length == 0 ||
        countryCode.length == 0
        ) {
        result(@{@"success":@(NO),
                 @"errorMsg": @"Illegal parameter"});
        return;
    }
    
    [[ThingSmartUser sharedInstance] registerByEmail:countryCode email:email password:password code:code success:^{
        result(@{@"success":@(YES)});
    } failure:^(NSError *error) {
        result(@{@"success":@(NO),
                 @"errorMsg": error.localizedDescription});
    }];
}

- (void)loginByEmail:(NSDictionary *)arguments result:(FlutterResult)result {
    NSString * email = [arguments objectForKey:@"email"];
    NSString * password = [arguments objectForKey:@"password"];
    NSString * countryCode = [arguments objectForKey:@"countryCode"];
    
    if (email.length == 0 ||
        password.length == 0 ||
        countryCode.length == 0
        ) {
        result(@{@"success":@(NO),
                 @"errorMsg": @"Illegal parameter"});
        return;
    }
    
    [[ThingSmartUser sharedInstance] loginByEmail:countryCode email:email password:password success:^{
        
        NSDictionary * userInfo = @{
            @"sid" : [ThingSmartUser sharedInstance].sid ? : @"",
            @"uid" : [ThingSmartUser sharedInstance].uid ? : @"",
            @"headIconUrl" : [ThingSmartUser sharedInstance].headIconUrl ? : @"",
            @"nickname" : [ThingSmartUser sharedInstance].nickname ? : @"",
            @"userName" : [ThingSmartUser sharedInstance].userName ? : @"",
            @"phoneNumber" : [ThingSmartUser sharedInstance].phoneNumber ? : @"",
            @"email" : [ThingSmartUser sharedInstance].email ? : @"",
            @"countryCode" : [ThingSmartUser sharedInstance].countryCode ? : @"",
            @"isLogin" : @([ThingSmartUser sharedInstance].isLogin ? 1 : 0),
            @"regionCode" : [ThingSmartUser sharedInstance].regionCode ? : @"",
            @"domain" : [ThingSmartUser sharedInstance].domain ? : @"",
            @"timezoneId" : [ThingSmartUser sharedInstance].timezoneId ? : @"",
            @"partnerIdentity" : [ThingSmartUser sharedInstance].partnerIdentity ? : @"",
            @"mbHost" : [ThingSmartUser sharedInstance].mbHost ? : @"",
            @"gwHost" : [ThingSmartUser sharedInstance].gwHost ? : @"",
            @"port" : @([ThingSmartUser sharedInstance].port),
            @"useSSL" : @([ThingSmartUser sharedInstance].useSSL ? 1 : 0),
            @"quicHost" : [ThingSmartUser sharedInstance].quicHost ? : @"",
            @"quicPort" : @([ThingSmartUser sharedInstance].quicPort),
            @"useQUIC" : @([ThingSmartUser sharedInstance].useQUIC ? 1 : 0),
            @"tempUnit" : @([ThingSmartUser sharedInstance].tempUnit),
            @"regFrom" : @([ThingSmartUser sharedInstance].regFrom),
            @"snsNickname" : [ThingSmartUser sharedInstance].snsNickname ? : @"",
            @"ecode" : [ThingSmartUser sharedInstance].ecode ? : @"",
            @"userType" : @([ThingSmartUser sharedInstance].userType),
            @"extras" : [ThingSmartUser sharedInstance].extras ? : @{},
            @"userAlias" : [ThingSmartUser sharedInstance].userAlias ? : @"",
        };

        result(@{@"success":@(YES),
                 @"result" : userInfo
               });
    } failure:^(NSError *error) {
        result(@{@"success":@(NO),
                 @"errorMsg": error.localizedDescription});
    }];
}

+ (void)testCallFlutterFunc {
    NSLog(@"=====>iOS Native call Flutter func");
    
    [sLoginPluginChannel invokeMethod:@"flutterFuncName" arguments:@{@"key" : @"value"} result:^(id  _Nullable result) {
        NSLog(@"=====>iOS Native call Flutter func result:%@", result);
    }];
}
@end
