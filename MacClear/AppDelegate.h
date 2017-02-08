//
//  AppDelegate.h
//  MacClear
//
//  Created by dong on 2017/2/6.
//  Copyright © 2017年 chuansongmen. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
@property (weak) IBOutlet NSButton *QQClickBox;
@property (weak) IBOutlet NSButton *QQMusicClickBox;
@property (weak) IBOutlet NSButton *WXClickBox;
@property (weak) IBOutlet NSButton *WYMusicCickBox;
@property (weak) IBOutlet NSProgressIndicator *progress;
@property (weak) IBOutlet NSButton *startButton;

- (IBAction)startScanOrClear:(id)sender;

- (IBAction)changeClearApp:(id)sender;

@end

