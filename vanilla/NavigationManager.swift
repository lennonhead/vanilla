//
//  NavigationManager.swift
//  vanilla
//
//  Created by Matthew Folsom on 3/19/17.
//  Copyright © 2017 mattfolsom. All rights reserved.
//

import UIKit

class NavigationManager: NSObject {
    
    
    
    static let sharedInstance: NavigationManager = {
        let instance = NavigationManager()
        instance.appDelegate = UIApplication.shared.delegate as? AppDelegate
        return instance
    }()
    
    var appDelegate: AppDelegate?
    
    func showResponse(topic: Topic) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Topic Response") as! ResponseViewController
        controller.topic = topic
        appDelegate?.window?.rootViewController?.present(controller, animated: true, completion: nil)
    }
}
