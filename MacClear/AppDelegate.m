//
//  AppDelegate.m
//  MacClear
//
//  Created by dong on 2017/2/6.
//  Copyright © 2017年 chuansongmen. All rights reserved.
//

#import "AppDelegate.h"
#import "FCFileManager.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property (assign) BOOL scanEnd;

@end

static NSString *const QQPath = @"com.tencent.qq/Data/";
static NSString *const QQMusicPath = @"com.tencent.QQMusicMac/Data/";
static NSString *const WXPath = @"com.tencent.xinWeChat/Data/";
static NSString *const WYMusicPath = @"com.netease.163music/Data/";

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.progress.hidden = YES;
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (IBAction)startScanOrClear:(id)sender {
    NSButton *button = sender;
    button.enabled = NO;
    self.progress.hidden = NO;
    [self.progress startAnimation:self];
    NSString *path=NSHomeDirectory();//先去获取路径
    path = [path stringByAppendingPathComponent:@"Library/Containers"];
    NSMutableArray *appName = [NSMutableArray arrayWithCapacity:4];
    
    if (self.QQClickBox.state) {
        [appName addObject:QQPath];
    }
    if (self.QQMusicClickBox.state) {
        [appName addObject:QQMusicPath];
    }
    if (self.WXClickBox.state) {
        [appName addObject:WXPath];
    }
    if (self.WYMusicCickBox.state) {
        [appName addObject:WYMusicPath];
    }
    if (_scanEnd) {
        [appName enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *appPath = [path stringByAppendingPathComponent:obj];
            [FCFileManager removeItemAtPath:appPath];
        }];
        [self.startButton setTitle:@"清除完成"];
    }else{
        __block double allSize = 0.f;
        [appName enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *appPath = [path stringByAppendingPathComponent:obj];
            NSNumber *fileSize = [FCFileManager sizeOfDirectoryAtPath:appPath];
            allSize += fileSize.doubleValue;
            NSLog(@"%@",fileSize);
        }];
        if (allSize > 0) {
            button.enabled = YES;
        }
        [self.startButton setTitle:[NSString stringWithFormat:@"立即清除（%@）",[FCFileManager sizeFormatted:@(allSize)]]];
    }
    [self.progress stopAnimation:self];
    self.progress.hidden = YES;
    _scanEnd = !_scanEnd;
}


- (IBAction)changeClearApp:(id)sender {
    _scanEnd = NO;
    [self.startButton setTitle:@"开始扫描"];
    if (self.QQClickBox.state || self.QQMusicClickBox.state || self.WXClickBox.state || self.WYMusicCickBox.state) {
        self.startButton.enabled = YES;
    }else {
        self.startButton.enabled = NO;
    }
}


@end
