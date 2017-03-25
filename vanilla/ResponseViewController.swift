//
//  ResponseViewController.swift
//  vanilla
//
//  Created by Matthew Folsom on 3/21/17.
//  Copyright © 2017 mattfolsom. All rights reserved.
//

import UIKit
import SCRecorder

class ResponseViewController: UIViewController, SCPlayerDelegate {
    
    var topic: Topic?
    var player: SCPlayer!
    var progressTimer: Timer!
    
    @IBOutlet weak var playerContainer: UIView!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var progressBarView: UIView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = SCPlayer()
        player.loopEnabled = false
        player.delegate = self

        let playerView = SCVideoPlayerView(player: player)
        playerView.playerLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerView.frame = playerContainer.frame
        playerContainer.addSubview(playerView)
        
        // add constraints
        playerView.leftAnchor.constraint(equalTo: playerContainer.leftAnchor).isActive = true
        playerView.rightAnchor.constraint(equalTo: playerContainer.rightAnchor).isActive = true
        playerView.topAnchor.constraint(equalTo: playerContainer.topAnchor).isActive = true
        playerView.bottomAnchor.constraint(equalTo: playerContainer.bottomAnchor).isActive = true
        
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        
        topicLabel.text = topic?.topicString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // set preview?
        // [self.previewImage pin_setImageFromURL:[NSURL URLWithString:self.answer.thumbnailUrl] completion:^(PINRemoteImageManagerResult * _Nonnull result) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        // previously reset frame
        
        // @"http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8"
        //  @"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"
        let url = URL(string: "http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8")
        player.setItemBy(url)
        
        progressTimer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(progressUpdate), userInfo: nil, repeats: true)
        player.play()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        progressTimer.invalidate()
    }
    
    func progressUpdate() {
        
        let currTime = CMTimeGetSeconds(player.currentItem!.currentTime())
        let maxTime = CMTimeGetSeconds(player.currentItem!.duration)
        var width = 0.0
        
        if currTime > 0.0 {
            width = (currTime / maxTime) * Double(view.frame.size.width)
        }
        
        progressBarView.frame = CGRect(x: progressBarView.frame.origin.x, y: progressBarView.frame.origin.y, width: CGFloat(width), height: progressBarView.frame.size.height)
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true) {
            
        }
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
