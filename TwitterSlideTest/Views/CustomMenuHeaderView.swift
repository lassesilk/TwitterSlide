//
//  CustomMenuHeaderView.swift
//  TwitterSlideTest
//
//  Created by Lasse Silkoset on 15/11/2018.
//  Copyright © 2018 Lasse Silkoset. All rights reserved.
//

import UIKit

class CustomMenuHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        let nameLabel = UILabel()
        nameLabel.text = "Lasse N. Silkoset"
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        
        let userNameLabel = UILabel()
        userNameLabel.text = "@lassesilk"
        
        let statsLabel = UILabel()
        statsLabel.text = "42 Following 7091 Followers"
        
        let arrangedSubViews = [UIView(), nameLabel, userNameLabel, SpacerView(space: 16), statsLabel]
        let stackView = UIStackView(arrangedSubviews: arrangedSubViews)
        stackView.axis = .vertical
        stackView.spacing = 4
        
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
