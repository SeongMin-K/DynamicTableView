//
//  MyHeartBtn.swift
//  DynamicTableView
//
//  Created by SeongMinK on 2021/10/03.
//

import Foundation
import UIKit

class MyHeartBtn: UIButton {
    
    var isActivated: Bool = false
    
    let activatedImage = UIImage(systemName: "heart.fill")?.withTintColor(.systemPink).withRenderingMode(.alwaysOriginal)
    let normalImage = UIImage(systemName: "heart")?.withTintColor(.systemGray2).withRenderingMode(.alwaysOriginal)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("MyHeartBtn - awakeFromNib() called")
        configureAction()
    }
    
    func setState(_ newValue: Bool) {
        print("MyHeartBtn - setState() called / newValue: \(newValue)")
        
        // 1. 현재 버튼의 상태 변경
        self.isActivated = newValue
        
        // 2. 변경된 상태에 따른 이미지 변경
        self.setImage(self.isActivated ? activatedImage : normalImage, for: .normal)
    }
    
    fileprivate func configureAction() {
        print("MyHeartBtn - configureAction() called")
        self.addTarget(self, action: #selector(onBtnClicked(_:)), for: .touchUpInside)
    }
    
    @objc fileprivate func onBtnClicked(_ sender: UIButton) {
        print("MyHeartBtn - onBtnClicked() called")
        self.isActivated.toggle()
        
        // 애니메이션 처리
        animate()
    }
    
    fileprivate func animate() {
        print("MyHeartBtn - animate() called")
        
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            guard let self = self else { return }
            let newImage = self.isActivated ? self.activatedImage : self.normalImage
            // 1. 클릭되면 크기 변경
            self.transform = self.transform.scaledBy(x: 0.5, y: 0.5)
            self.setImage(newImage, for: .normal)
        }, completion: { _ in
            // 2. 원래 크기로 되돌리기
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity
            })
        })
        
        
    }
}
