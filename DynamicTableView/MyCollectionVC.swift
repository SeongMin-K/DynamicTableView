//
//  MyCollectionVC.swift
//  DynamicTableView
//
//  Created by SeongMinK on 2021/09/19.
//

import Foundation
import UIKit

class MyCollectionVC: UIViewController {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var mySegmentControl: UISegmentedControl!
    
    fileprivate let systemImageNameArray = [
        "moon", "zzz", "sparkles", "cloud", "tornado", "smoke.fill", "tv.fill", "gamecontroller", "headphones", "flame", "bolt.fill", "hare", "tortoise", "moon", "zzz", "sparkles", "cloud", "tornado", "smoke.fill", "tv.fill", "gamecontroller", "headphones", "flame", "bolt.fill", "hare", "tortoise", "ant", "hare", "car", "airplane", "heart", "bandage", "waveform.path.ecg", "staroflife", "bed.double.fill", "signature", "bag", "cart", "creditcard", "clock", "alarm", "stopwatch.fill", "timer"
    ]
    
    // Mark: - Lifecycles
    override func viewDidLoad() {
        super .viewDidLoad()
        print(#fileID, #function, "called")
        
        // 컬렉션 뷰에 대한 설정
        myCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
    }
}

// 데이터 소스 설정 - 데이터와 관련된 것들
extension MyCollectionVC: UICollectionViewDataSource {
    // 각 섹션에 들어가는 아이템 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.systemImageNameArray.count
    }
    
    // 각 컬렉션 뷰 셀에 대한 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = String(describing: MyCollectionViewCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MyCollectionViewCell
        
        cell.imageName = self.systemImageNameArray[indexPath.item]
        
        cell.contentView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        cell.contentView.layer.cornerRadius = 8
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        cell.profileImg.image = UIImage(systemName: self.systemImageNameArray[indexPath.item])
        cell.profileLabel.text = self.systemImageNameArray[indexPath.item]
        
        return cell
    }
}

// 컬렉션 뷰 델리겟 - 액션과 관련된 것들
extension MyCollectionVC: UICollectionViewDelegate {
    
}
