//
//  UIButton+.swift
//  SurfIT Test Task
//
//  Created by Денис Павлов on 01.06.2023.
//

import UIKit

extension UIButton {
    func createButtonForPlayingModule(systemImageName: String?, title: String? = nil, target: Any?, action: Selector) -> Self {
        
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let title = title {
            
            self.setTitle(title, for: .normal)
            self.setTitleColor(.tintColor, for: .normal)
        }
        
        if let imageName = systemImageName {
            let image = UIImage(systemName: imageName)
            self.setImage(image, for: .normal)
        }
        
        
        self.addTarget(target, action: action, for: .touchUpInside)
        self.backgroundColor = .clear
        return self
    }
}
