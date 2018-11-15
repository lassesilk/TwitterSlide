//
//  BookmarksController.swift
//  TwitterSlideTest
//
//  Created by Lasse Silkoset on 15/11/2018.
//  Copyright © 2018 Lasse Silkoset. All rights reserved.
//

import UIKit

class BookmarksController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        cell.textLabel?.text = "Bookmark: \(indexPath.row)"
        
        return cell
    }

}
