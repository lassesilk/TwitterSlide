//
//  BaseSlidingController.swift
//  TwitterSlideTest
//
//  Created by Lasse Silkoset on 14/11/2018.
//  Copyright © 2018 Lasse Silkoset. All rights reserved.
//

import UIKit

//Bad solution, but using it for now so it is easier to catch memory leaks in view hierarchy debugger
class RightContainerView: UIView {}
class MenuContainerView: UIView {}
class DarkCoverView: UIView {}

class BaseSlidingController: UIViewController {
    
    let redView: RightContainerView = {
        let v = RightContainerView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let blueView: MenuContainerView = {
        let v = MenuContainerView()
        v.backgroundColor = .blue
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let darkCoverView: DarkCoverView = {
        let v = DarkCoverView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.7)
        v.alpha = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupViews()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
        
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view)
        var x = translation.x
        
        x = isMenuOpened ? x + menuWidth : x
        x = min(menuWidth, x)
        x = max(0, x)
        
        redViewLeadingConstraint.constant = x
        darkCoverView.alpha = x / menuWidth
        
        if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
    
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        if isMenuOpened {
           if abs(velocity.x) > velocityThreshold {
                closeMenu()
                return
            }
            if abs(translation.x) < menuWidth / 2 {
                openMenu()
            } else {
                closeMenu()
            }
        } else {
            if abs(velocity.x) > velocityThreshold {
                openMenu()
                return
            }
            
            
            if translation.x < menuWidth / 2 {
                closeMenu()
            } else {
                openMenu()
            }
        }
    }
    
     func openMenu() {
        isMenuOpened = true
        redViewLeadingConstraint.constant = menuWidth
        performAnimations()
    }
    
     func closeMenu() {
        redViewLeadingConstraint.constant = 0
        isMenuOpened = false
        performAnimations()
    }
    
    func didSelectMenuItem(indexPath: IndexPath) {
        
        performRightViewCleanUp()
        closeMenu()
        
        switch indexPath.row {
        case 0:
            rightViewController = UINavigationController(rootViewController: HomeController())
            
        case 1:
            rightViewController = UINavigationController(rootViewController: ListsController())
           
        case 2:
            rightViewController = BookmarksController()
        
        case 3:
            let tabBarController = UITabBarController()
            let momentsController = UIViewController()
            
            momentsController.navigationItem.title = "Moments"
            
            momentsController.view.backgroundColor = .orange
            let navController = UINavigationController(rootViewController: momentsController)
            navController.tabBarItem.title = "Moments"
            tabBarController.viewControllers = [navController]
            rightViewController = tabBarController
        default:
            print("show moments")
        }
        
        redView.addSubview(rightViewController.view)
        addChild(rightViewController)
        
        redView.bringSubviewToFront(darkCoverView)
        
    }
    
    var rightViewController: UIViewController = UINavigationController(rootViewController: HomeController())
    
    fileprivate func performRightViewCleanUp() {
        rightViewController.view.removeFromSuperview()
        rightViewController.removeFromParent()
    }
    
    fileprivate func performAnimations() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //Needed to animate constraints
            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isMenuOpened ? 1 : 0
        })
    }
    
    
    var redViewLeadingConstraint: NSLayoutConstraint!
    fileprivate let menuWidth: CGFloat = 300
    fileprivate let velocityThreshold: CGFloat = 500
    fileprivate var isMenuOpened = false
    
    fileprivate func setupViews() {
        view.addSubview(redView)
        view.addSubview(blueView)
        
        NSLayoutConstraint.activate([redView.topAnchor.constraint(equalTo: view.topAnchor),
                                     redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     redView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     
                                     blueView.topAnchor.constraint(equalTo: view.topAnchor),
                                     blueView.trailingAnchor.constraint(equalTo: redView.safeAreaLayoutGuide.leadingAnchor),
                                     blueView.widthAnchor.constraint(equalToConstant: menuWidth),
                                     blueView.bottomAnchor.constraint(equalTo: redView.bottomAnchor)
            ])
        
        redViewLeadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        redViewLeadingConstraint.isActive = true
        
        setupViewControllers()
    }
    
    fileprivate func setupViewControllers() {
        
        let menuController = MenuController()
        
        let homeView = rightViewController.view!
        let menuView = menuController.view!
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        redView.addSubview(homeView)
        redView.addSubview(darkCoverView)
        blueView.addSubview(menuView)
        
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: redView.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            homeView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            homeView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
            
            menuView.topAnchor.constraint(equalTo: blueView.topAnchor),
            menuView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor),
            menuView.bottomAnchor.constraint(equalTo: blueView.bottomAnchor),
            menuView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor),
            
            darkCoverView.topAnchor.constraint(equalTo: redView.topAnchor),
            darkCoverView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            darkCoverView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            darkCoverView.trailingAnchor.constraint(equalTo: redView.trailingAnchor)
            ])
        
        addChild(rightViewController)
        addChild(menuController)
    }
    
    
}
