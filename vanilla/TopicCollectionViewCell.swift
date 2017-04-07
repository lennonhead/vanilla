//
//  TopicCollectionViewCell.swift
//  vanilla
//
//  Created by Matthew Folsom on 4/7/17.
//  Copyright © 2017 mattfolsom. All rights reserved.
//

import UIKit

class TopicCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var topicLabel: UILabel!
    
    func setTopic(topic: Topic) {
        topicLabel.text = topic.topicString
    }

}
