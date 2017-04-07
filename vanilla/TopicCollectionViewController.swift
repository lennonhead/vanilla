//
//  TopicCollectionViewController.swift
//  vanilla
//
//  Created by Matthew Folsom on 3/19/17.
//  Copyright © 2017 mattfolsom. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Topic Cell"

class TopicCollectionViewController: UICollectionViewController {
    
    var dataArray: [Topic]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        

        // Register cell classes
        let nib = UINib(nibName: "TopicCollectionViewCell", bundle: nil)
        self.collectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        addDummyData()
    }
    
    func addDummyData() {
        dataArray = []
        
        let topic1 = Topic()
        topic1.topicString = "How bout that local sports team?"
        dataArray.append(topic1)
        
        let topic2 = Topic()
        topic2.topicString = "Why didn't the Giants make the World Series last year?"
        dataArray.append(topic2)
        
        let topic3 = Topic()
        topic3.topicString = "What do you like best about Stance?"
        dataArray.append(topic3)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TopicCollectionViewCell
        cell.setTopic(topic: dataArray[indexPath.item])
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NavigationManager.sharedInstance.showResponse(topic: dataArray[indexPath.item])
    }

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
