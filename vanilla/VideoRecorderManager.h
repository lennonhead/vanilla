//
//  VideoRecorderManager.h
//  vanilla
//
//  Created by Matthew Folsom on 3/20/17.
//  Copyright © 2017 mattfolsom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SCRecorder/SCRecorder.h>

static CGFloat const MIN_CAPTURE_LENGTH = 5.0f;
static CGFloat const MAX_CAPTURE_LENGTH = 30.0f;

@interface VideoRecorderManager : NSObject

+ (instancetype)sharedManager;

@property (readonly) SCRecorder *recorder;

- (void)startRecorderSession;
- (void)stopRecorderSession;

//+(void)uploadVideo: fileURL:(NSURL*)fileURL fileType:(NSString*)fileType successBlock:(successBlock)successBlock;

@end

@interface VideoGestureRecognizer : UIGestureRecognizer {}

@end





