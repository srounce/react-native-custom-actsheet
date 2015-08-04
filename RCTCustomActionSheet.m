//
//  RCTActionSheet.m
//  RCTActionSheet
//
//  Created by 郭栋 on 15/8/4.
//  Copyright (c) 2015年 guodong. All rights reserved.
//

#import "RCTCustomActionSheet.h"

#import "RCTBridge.h"
#import "RCTUIManager.h"
#import "RCTSparseArray.h"
#import "RCTConvert.h"

@implementation RCTCustomActionSheet
{
    RCTResponseSenderBlock _callback;
}

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE()

- (dispatch_queue_t)methodQueue {
    return _bridge.uiManager.methodQueue;
}

- (NSDictionary *)constantsToExport {
    return @{
             @"FadesOnPress": @(IBActionSheetButtonResponseFadesOnPress),
             @"ReversesColorsOnPress": @(IBActionSheetButtonResponseReversesColorsOnPress),
             @"ShrinksOnPress": @(IBActionSheetButtonResponseShrinksOnPress),
             @"HighlightOnPress": @(IBActionSheetButtonResponseHighlightsOnPress),
             };
}

RCT_EXPORT_METHOD(showActionSheetWithOptions:(NSDictionary *)options callback:(RCTResponseSenderBlock)callback) {
    _callback = callback;
    [_bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, RCTSparseArray *viewRegistry) {
        NSNumber *viewTag = options[@"node"];
        UIView *view = viewRegistry[viewTag];
        
        NSString *title = options[@"title"];
        NSArray *buttons = options[@"buttons"];
        NSString *destructiveButtonTitle = options[@"destructiveButtonTitle"];
        NSString *cancelButtonTitle = options[@"cancelButtonTitle"];
        
        NSMutableArray *otherButtonTitles = [NSMutableArray array];
        for (int i = 0; i < buttons.count; i++) {
            [otherButtonTitles addObject:buttons[i][@"title"]];
        }
        
        IBActionSheet *actionSheet = [[IBActionSheet alloc] initWithTitle:title
                                                                 delegate:self
                                                        cancelButtonTitle:cancelButtonTitle
                                                   destructiveButtonTitle:destructiveButtonTitle
                                                        otherButtonTitlesArray:otherButtonTitles];
        
        if (options[@"buttonTextColor"]) {
            [actionSheet setButtonTextColor:[RCTConvert UIColor:options[@"buttonTextColor"]]];
        }
        if (options[@"buttonBackgroundColor"]) {
            [actionSheet setButtonBackgroundColor:[RCTConvert UIColor:options[@"buttonBackgroundColor"]]];
        }
        if (options[@"pressEffect"]) {
            [actionSheet setButtonResponse:((NSNumber *)options[@"pressEffect"]).integerValue];
        }
        if (options[@"titleFont"]) {
            [actionSheet setTitleFont:[RCTConvert UIFont:options[@"titleButtonFont"]]];
        }
        if (options[@"font"]) {
            [actionSheet setFont:[RCTConvert UIFont:options[@"font"]]];
        }
        if (options[@"cancelButtonFont"]) {
            [actionSheet setCancelButtonFont:[RCTConvert UIFont:options[@"cancelButtonFont"]]];
        }
        if (options[@"destructiveButtonFont"]) {
            [actionSheet setDestructiveButtonFont:[RCTConvert UIFont:options[@"destructiveButtonFont"]]];
        }
        
        for (int i = 0; i < buttons.count; i++) {
            NSDictionary *button = buttons[i];
            NSInteger index = i;
            if (actionSheet.hasDestructiveButton) {
                index = i + 1;
            }
            if (button[@"textColor"]) {
                [actionSheet setButtonTextColor:[RCTConvert UIColor:button[@"color"]]
                               forButtonAtIndex:index];
            }
            if (button[@"backgroundColor"]) {
                [actionSheet setButtonBackgroundColor:[RCTConvert UIColor:button[@"backgroundColor"]]
                                     forButtonAtIndex:index];
            }
            if (button[@"highlightTextColor"]) {
                [actionSheet setButtonHighlightTextColor:[RCTConvert UIColor:button[@"highlightTextColor"]]
                                        forButtonAtIndex:index];
            }
            if (button[@"highlightBackgroundColor"]) {
                [actionSheet setButtonHighlightBackgroundColor:[RCTConvert UIColor:button[@"highlightBackgroundColor"]]
                                              forButtonAtIndex:index];
            }
            if (button[@"font"]) {
                [actionSheet setFont:[RCTConvert UIFont:button[@"font"]] forButtonAtIndex:index];
            }
        }
        
        [actionSheet showInView:view];
    }];
}

#pragma mark - IBActionSheetDelegate Implementation

- (void)actionSheet:(IBActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    _callback(@[@(buttonIndex)]);
}

- (void)actionSheet:(IBActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    // do nothing
}

- (void)actionSheet:(IBActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // do nothing
}

@end
