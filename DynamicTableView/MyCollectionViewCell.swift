//
//  MyCollectionViewCell.swift
//  DynamicTableView
//
//  Created by SeongMinK on 2021/09/19.
//

import Foundation
import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileLabel: UILabel!
    
    var imageName: String = "" {
        didSet {
            print("MyCollectionViewCell / imageName - didSet() : \(imageName)")
//            self.profileImg.image = UIImage(systemName: imageName)
//            self.profileLabel.text = imageName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("MyCollectionViewCell - awakeFromNib() called")
    }
}
