//
//  CustomMenuHeaderView.swift
//  TwitterSlideTest
//
//  Created by Lasse Silkoset on 15/11/2018.
//  Copyright © 2018 Lasse Silkoset. All rights reserved.
//

import UIKit

class CustomMenuHeaderView: UIView {
    
    let nameLabel = UILabel()
    let statsLabel = UILabel()
    let userNameLabel = UILabel()
    let profileImageView = ProfileImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupComponentsProps()
        
        setupStackView()
    }
    
    fileprivate func setupComponentsProps() {
        nameLabel.text = "Lasse N. Silkoset"
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        userNameLabel.text = "@lassesilk"
        statsLabel.text = "42 Following 7091 Followers"
        profileImageView.image = #imageLiteral(resourceName: "Lasse")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 48 / 2
        profileImageView.clipsToBounds = true
        
        setupAttributedText()
    }
    
    fileprivate func setupAttributedText() {
        statsLabel.font = UIFont.systemFont(ofSize: 14)
        
        let attributedText = NSMutableAttributedString(string: "42 ", attributes: [.font : UIFont.systemFont(ofSize: 17, weight: .medium)])
        attributedText.append(NSAttributedString(string: "Following   ", attributes: [.foregroundColor : UIColor.black]))
        attributedText.append(NSAttributedString(string: "7091 ", attributes: [.font : UIFont.systemFont(ofSize: 17, weight: .medium)]))
        attributedText.append(NSAttributedString(string: "Followers", attributes: [.foregroundColor : UIColor.black]))
        
        statsLabel.attributedText = attributedText
    }
    
    fileprivate func setupStackView() {
        let arrangedSubViews = [
            UIStackView(arrangedSubviews: [profileImageView, UIView()]),
            nameLabel,
            userNameLabel,
            SpacerView(space: 16),
            statsLabel
        ]
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
