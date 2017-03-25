//
//  TopicCollectionViewCell.swift
//  vanilla
//
//  Created by Matthew Folsom on 3/19/17.
//  Copyright © 2017 mattfolsom. All rights reserved.
//

import UIKit

class TopicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var topicLabel: UILabel!
    
    func setTopic(topic: Topic) {
        topicLabel.text = topic.topicString
    }
}
