//
//  VideoPreviewViewController.swift
//  vanilla
//
//  Created by Matthew Folsom on 3/19/17.
//  Copyright © 2017 mattfolsom. All rights reserved.
//

import UIKit
import SCRecorder

class VideoPreviewViewController: UIViewController {
    
    var session: SCRecordSession!
    var player: SCPlayer!
    
    @IBOutlet weak var playerContainer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        player = SCPlayer()
        player.loopEnabled = true
        
        let playerView = SCVideoPlayerView(player: player)
        playerView.playerLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerView.frame = playerContainer.frame
        playerContainer.addSubview(playerView)
        
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player.setItemBy(session.assetRepresentingSegments())
        player.play()
    }
    // needed funcs
    
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // nav back
    
    // export asset
    func exportAsset() {
        
        // check if already exported
        
        player.pause()
        
        /*
        let exportSession = SCAssetExportSession(session.assetRepresentingSegments())
        exportSession.videoConfiguration.preset = SCPresetHighestQuality
        exportSession.audioConfiguration.preset = SCPresetHighestQuality
        exportSession.videoConfiguration.maxFrameRate = 30.0
        exportSession.outputUrl = session.outputUrl
        exportSession.outputFileType = AVFileTypeMPEG4
        exportSession.delegate = self
        exportSession.contextType = SCContextTypeAuto
        
        // save export session for checking later
        
        exportSession.exportAsynchronouslyWithCompletionHandler(^())
        */
        // callback for export
        /*
         NSError *error = exportSession.error;
         if (error == nil) {
         
         // success
         self.exported = YES;
         completionBlock();
         
         } else {
         self.exported = NO;
         if (exportSession.cancelled) {
         dispatch_async(dispatch_get_main_queue(), ^{
         [KVNProgress showErrorWithStatus:@"Export Cancelled"];
         });
         } else {
         dispatch_async(dispatch_get_main_queue(), ^{
         [KVNProgress showErrorWithStatus:@"Failed to save"];
         });
         }
         [self hideLoader];
         }
         */
 
    }
 
    // save to camera roll
    // or
    // upload

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
 
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
