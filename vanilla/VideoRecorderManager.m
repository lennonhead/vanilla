//
//  VideoRecorderManager.m
//  vanilla
//
//  Created by Matthew Folsom on 3/20/17.
//  Copyright © 2017 mattfolsom. All rights reserved.
//

#import "VideoRecorderManager.h"
#import <SCRecorder/SCRecorder.h>
//#import <AWSS3/AWSS3.h>
#import <UIKit/UIGestureRecognizerSubclass.h>
//#import <KVNProgress/KVNProgress.h>

@interface VideoRecorderManager () <SCRecorderDelegate>

@property (nonatomic, strong) SCRecorder *recorder;

@end

@implementation VideoRecorderManager

+ (instancetype)sharedManager
{
    static VideoRecorderManager *sharedInstance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[VideoRecorderManager alloc] init];
        [sharedInstance setupRecorder];
    });
    
    return sharedInstance;
}

- (void)setupRecorder {
    
    // Create the recorder
    self.recorder = [SCRecorder recorder]; // You can also use +[SCRecorder sharedRecorder]
    
    // Set the AVCaptureSessionPreset for the underlying AVCaptureSession.
    self.recorder.captureSessionPreset = AVCaptureSessionPresetHigh;
    
    // Set the video device to use
    self.recorder.device = AVCaptureDevicePositionFront;
    
    self.recorder.videoZoomFactor = 1;
    self.recorder.resetZoomOnChangeDevice=YES;
    
    self.recorder.mirrorOnFrontCamera = YES;
    //  self.recorder.keepMirroringOnWrite = YES;
    
    // Set the maximum record duration
    self.recorder.maxRecordDuration = CMTimeMake(60, 1);
    
    // Listen to the messages SCRecorder can send
    self.recorder.delegate = self;
}

- (void)startRecorderSession {
    
    // Start running the flow of buffers
    if (![self.recorder startRunning]) {
        NSLog(@"Something wrong there: %@", self.recorder.error);
    }
    
    // Create a new session and set it to the recorder
    self.recorder.session = [SCRecordSession recordSession];
}

- (void)stopRecorderSession {
    [self.recorder stopRunning];
    self.recorder.session = nil;
    self.recorder.previewView = nil;
}
/*
+ (void)uploadVideoForFileURL:(NSURL*)fileURL fileType:(NSString*)fileType successBlock:(successBlock)successBlock {
    //   [KVNProgress showWithStatus:@"uploading video"];
    
    // unique names for now, prob want to make more friendly
    NSString *userID = [AccountManager currentUser].objectId;
    NSInteger seconds = [[NSDate date] timeIntervalSinceReferenceDate];
    NSString *timeString = [NSString stringWithFormat:@"%ld", (long)seconds];
    NSString *contentKey = [NSString stringWithFormat:@"%@_%@_%@", userID, question.objectId,timeString];
    NSString *fileName = [NSString stringWithFormat:@"answers/%@/%@/%@.mp4",userID, question.objectId, contentKey];
    
    NSString *s3Bucket;
#if RELEASE
    s3Bucket = @"tiptalkapp.media.upload.production";
#elif STAGING
    s3Bucket = @"";
#else
    s3Bucket = @"tiptalkapp.media.upload.development";
#endif
    
    AWSS3TransferUtility *transferUtility = [AWSS3TransferUtility defaultS3TransferUtility];
    [[transferUtility uploadFile:fileURL
                          bucket:s3Bucket
                             key:fileName
                     contentType:fileType //self.exportSession.outputFileType
                      expression:nil
                completionHander:nil] continueWithBlock:^id(AWSTask *task) {
        if (task.error) {
            NSLog(@"Error: %@", task.error);
            dispatch_async(dispatch_get_main_queue(), ^{
                [KVNProgress showErrorWithStatus:@"Upload error"];
            });
        }
        if (task.exception) {
            NSLog(@"Exception: %@", task.exception);
        }
        if (task.result) {
            
            AWSS3TransferUtilityUploadTask *uploadTask = task.result;
            
            NSLog(@"aws upload task: %@", uploadTask);
            // Do something with uploadTask.
            
            [[VideoCaptureManager sharedManager] stopRecorderSession];
            
            [[QuestionManager sharedManager] answerQuestion:question contentKey:contentKey filePath:(NSString*)fileName withBlock:^(BOOL success, NSError *error) {
                if(success){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if(successBlock){
                            successBlock(YES, nil);
                        }
                        [KVNProgress showSuccessWithStatus:@"Success!"];
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if(successBlock){
                            successBlock(NO, error);
                        }
                        [KVNProgress showErrorWithStatus:@"save error"];
                    });
                }
            }];
        }
        if(successBlock){
            successBlock(NO, task.error);
        }
        return nil;
    }];
}

*/

@end

@implementation VideoGestureRecognizer

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.enabled) {
        self.state = UIGestureRecognizerStateBegan;
    }
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.enabled) {
        self.state = UIGestureRecognizerStateEnded;
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.enabled) {
        self.state = UIGestureRecognizerStateEnded;
    }
}

@end

