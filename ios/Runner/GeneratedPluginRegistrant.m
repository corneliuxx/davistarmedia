//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<app_review/AppReviewPlugin.h>)
#import <app_review/AppReviewPlugin.h>
#else
@import app_review;
#endif

#if __has_include(<flutter_inappwebview/InAppWebViewFlutterPlugin.h>)
#import <flutter_inappwebview/InAppWebViewFlutterPlugin.h>
#else
@import flutter_inappwebview;
#endif

#if __has_include(<package_info/FLTPackageInfoPlugin.h>)
#import <package_info/FLTPackageInfoPlugin.h>
#else
@import package_info;
#endif

#if __has_include(<phone_state_i/PhoneState_iPlugin.h>)
#import <phone_state_i/PhoneState_iPlugin.h>
#else
@import phone_state_i;
#endif

#if __has_include(<share/SharePlugin.h>)
#import <share/SharePlugin.h>
#else
@import share;
#endif

#if __has_include(<store_redirect/StoreRedirectPlugin.h>)
#import <store_redirect/StoreRedirectPlugin.h>
#else
@import store_redirect;
#endif

#if __has_include(<url_launcher/FLTURLLauncherPlugin.h>)
#import <url_launcher/FLTURLLauncherPlugin.h>
#else
@import url_launcher;
#endif

#if __has_include(<webview_flutter/FLTWebViewFlutterPlugin.h>)
#import <webview_flutter/FLTWebViewFlutterPlugin.h>
#else
@import webview_flutter;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [AppReviewPlugin registerWithRegistrar:[registry registrarForPlugin:@"AppReviewPlugin"]];
  [InAppWebViewFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"InAppWebViewFlutterPlugin"]];
  [FLTPackageInfoPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPackageInfoPlugin"]];
  [PhoneState_iPlugin registerWithRegistrar:[registry registrarForPlugin:@"PhoneState_iPlugin"]];
  [FLTSharePlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharePlugin"]];
  [StoreRedirectPlugin registerWithRegistrar:[registry registrarForPlugin:@"StoreRedirectPlugin"]];
  [FLTURLLauncherPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTURLLauncherPlugin"]];
  [FLTWebViewFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTWebViewFlutterPlugin"]];
}

@end
