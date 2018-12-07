//
//  ViewController.swift
//  TwitterSlideTest
//
//  Created by Lasse Silkoset on 08/11/2018.
//  Copyright © 2018 Lasse Silkoset. All rights reserved.
//

import UIKit

class HomeController: UITableViewController, UIGestureRecognizerDelegate {
    
    deinit {
        print("HomeController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .red
        setupNavigationItems()
    }
    
    @objc func handleOpen() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.openMenu()
    }
    
    @objc func handleHide() {
       (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.closeMenu()
    }
    
   
    
    fileprivate func setupNavigationItems() {
        navigationItem.title = "Home"
        
        setupCircularNavigationButton()
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(handleOpen))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(handleHide))
    }
    
    fileprivate func setupCircularNavigationButton() {
        let image = #imageLiteral(resourceName: "Lasse").withRenderingMode(.alwaysOriginal)
        
        let customView = UIButton(type: .system)
        customView.addTarget(self, action: #selector(handleOpen), for: .touchUpInside)
        customView.setImage(image, for: .normal)
        customView.imageView?.contentMode = .scaleAspectFill
        
        customView.layer.cornerRadius = 20
        customView.clipsToBounds = true
        
        //customView uses autoLayout to put itself in navBar. Not respecting this frame
//        customView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        //Use constraints to create own layout
        customView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let barButtonItem = UIBarButtonItem(customView: customView)
        
        navigationItem.leftBarButtonItem = barButtonItem
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        
        cell.textLabel?.text = "Row: \(indexPath.row)"
        
        return cell
    }
}

