//
//  TopicCreateViewController.swift
//  vanilla
//
//  Created by Matthew Folsom on 4/20/17.
//  Copyright © 2017 mattfolsom. All rights reserved.
//

import UIKit

class TopicCreateViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topicTextView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topicTextView.textContainer.lineFragmentPadding = 0
        topicTextView.textContainerInset = UIEdgeInsets.zero
        topicTextView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        topicTextView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true) {}
    }

    @IBAction func next(_ sender: Any) {
        
     let storyboard = UIStoryboard(name: "Main", bundle: nil)
     let controller = storyboard.instantiateViewController(withIdentifier: "Video Record") as! VideoRecordViewController
     controller.topicText = topicTextView.text
     self.present(controller, animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.selectedRange = NSMakeRange(0, 0)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if range.location == 0 && textView.text == "My Stance Topic" {
            textView.text = ""
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        // if first time
     //   textView.selectedRange = NSMakeRange(0, 0)
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
