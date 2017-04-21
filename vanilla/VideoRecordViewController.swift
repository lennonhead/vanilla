//
//  VideoRecordViewController.swift
//  vanilla
//
//  Created by Matthew Folsom on 3/19/17.
//  Copyright © 2017 mattfolsom. All rights reserved.
//

import UIKit
import SCRecorder

class VideoRecordViewController: UIViewController, SCRecorderDelegate {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    public var topicText: String = ""
    
    var recorder: SCRecorder!
    var segmentViews: NSMutableArray!
    var minTimeMarkerView: UIView!
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var clearSegmentButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var segmentViewContainer: UIView!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var topicTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        recorder = VideoRecorderManager.shared().recorder
        recorder.delegate = self
        
        VideoRecorderManager.shared().startRecorderSession()
        clearSegmentButton.isHidden = true
        continueButton.isEnabled = false
        cancelButton.layer.shadowRadius = 6
        segmentViews = NSMutableArray()
        recordButton.addGestureRecognizer(VideoGestureRecognizer(target: self, action:#selector(handleRecordTouch(_:))))
        
        topicTextView.text = topicText
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addMinTimeSegmentView()
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        recorder.previewView = previewView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Recorder Delegate
    func recorder(_ recorder: SCRecorder, didAppendVideoSampleBufferIn session: SCRecordSession) {
        updateTimeline()
    }
    
    func recorder(_ recorder: SCRecorder, didComplete segment: SCRecordSessionSegment?, in session: SCRecordSession, error: Error?) {
        updateContinueState()
        if segment != nil {
            clearSegmentButton.isHidden = false
            addSegmentView()
        }
    }
 
    func updateTimeline() {
        var currentTime = kCMTimeZero
        if let session = recorder.session {
            currentTime = session.duration
        }
        
        if CGFloat(currentTime.seconds) < MIN_CAPTURE_LENGTH {
            progressBarView.backgroundColor = UIColor.red
        } else {
            progressBarView.backgroundColor = UIColor.green
        }
        
        if currentTime.seconds > 0 {
            let percentage = CGFloat(currentTime.seconds) / MAX_CAPTURE_LENGTH //recorder.maxRecordDuration.seconds
            updateProgressBarWidth(width: CGFloat(percentage) * view.frame.size.width)
        } else {
            updateProgressBarWidth(width: 0)
        }
    }
    
    func updateContinueState() {
        if let session = recorder.session {
            if(CGFloat(session.duration.seconds) < MIN_CAPTURE_LENGTH){
                continueButton.isEnabled = false;
            } else {
                continueButton.isEnabled = true;
            }
        }
    }
    
    func addMinTimeSegmentView() {
        let minTimePos = (MIN_CAPTURE_LENGTH/MAX_CAPTURE_LENGTH) * segmentViewContainer.frame.size.width
        let frame: CGRect = CGRect(x: minTimePos-1, y: 0, width: 2, height: progressBarView.frame.size.height)
        minTimeMarkerView = UIView.init(frame: frame)
        minTimeMarkerView.backgroundColor = UIColor.blue
        segmentViewContainer.addSubview(minTimeMarkerView)
    }
    
    func addSegmentView() {
        let segView = UIView.init(frame: CGRect(x: progressBarView.frame.size.width-2, y: 0, width: 2, height: progressBarView.frame.size.height))
        segView.backgroundColor = UIColor.white
        segmentViews.add(segView)
        segmentViewContainer.addSubview(segView)
        updateTimeline()
    }
    
    func removeSegmentView() {
        if segmentViews.count > 0 {
            (segmentViews.lastObject as! UIView).removeFromSuperview()
            segmentViews.removeLastObject()
        }
    }
    
    func updateProgressBarWidth(width: CGFloat) {
        progressBarView.frame = CGRect(x: progressBarView.frame.origin.x, y: progressBarView.frame.origin.y, width: width, height: progressBarView.frame.size.height)
    }
    
    //
    // MARK: - Button Actions
    //
    func handleRecordTouch(_ touchGesture: VideoGestureRecognizer) {
        if(touchGesture.state == UIGestureRecognizerState.began){
            recorder.record()
            recordButton.isSelected = true
        }
        if(touchGesture.state == UIGestureRecognizerState.ended){
            recorder.pause()
            recordButton.isSelected = false
        }
    }
    
    @IBAction func clearRecordingTapped(_ sender: Any) {
        if let session = recorder.session {
            session.removeLastSegment()
            removeSegmentView()
            if session.segments.count < 1 {
                clearSegmentButton.isHidden = true
            }
            updateContinueState()
            updateTimeline()
        }
    }
    
    @IBAction func switchCameraTapped(_ sender: Any) {
        recorder.switchCaptureDevices()
    }
    
    @IBAction func next(_ sender: Any) {
        performSegue(withIdentifier: "videoPreview", sender: self)
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true) {}
    }
    
    // MARK: - Navigation
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "videoPreview") {
            let previewVC = segue.destination as! VideoPreviewViewController
            previewVC.session = recorder.session
        }
    }

}
