//
//  TopicFeedViewController.swift
//  vanilla
//
//  Created by Matthew Folsom on 3/19/17.
//  Copyright © 2017 mattfolsom. All rights reserved.
//

import UIKit
//import TopicCollectionViewController

class TopicFeedViewController: UIViewController {
    
    var collectionVC: TopicCollectionViewController!

    @IBOutlet weak var collectionContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // add nav button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Record", style: .plain, target: self, action: #selector(recordTapped))
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        collectionVC = storyboard.instantiateViewController(withIdentifier: "Topic Collection") as! TopicCollectionViewController
        
        if let collectionView = collectionVC.collectionView {
            var frame = collectionContainer.frame
            frame.origin.x = 0
            frame.origin.y = 0
            collectionView.frame = frame
            collectionContainer.addSubview(collectionView)
            
            collectionView.topAnchor.constraint(equalTo: collectionContainer.topAnchor).isActive = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func recordTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Video Record")
        self.present(controller, animated: true, completion: nil)
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
