//
//  ChatRoomsMenuController.swift
//  TwitterSlideTest
//
//  Created by Lasse Silkoset on 15/11/2018.
//  Copyright © 2018 Lasse Silkoset. All rights reserved.
//

import UIKit

extension ChatRoomsMenuController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            filteredResults = chatroomGroups
            tableView.reloadData()
            return
        }
        
        print(searchText)
        //Filter based on searchtext
        
//        var results = [[String]]()
        
//        chatroomGroups.forEach { (group) in
//            let filteredGroup = group.filter({ (chatroomName) -> Bool in
//                return chatroomName.lowercased().contains(searchText.lowercased())
//            })
//
//            results.append(filteredGroup)
//        }
//        print(results)
//        filteredResults = results
        
        filteredResults = chatroomGroups.map({ (group) -> [String] in
            return group.filter { $0.lowercased().contains(searchText.lowercased())}
        })
        
        tableView.reloadData()
    }
}

class ChatRoomsMenuController: UITableViewController {
    
    
    let chatroomGroups = [
    ["general", "introduction"],
    ["jobs"],
    ["Brian Voong", "Steve Jobs", "Tim Cook", "Barack Obama"]
    ]
    
    var filteredResults = [[String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //This is making a copy and not a direct reference.
        filteredResults = chatroomGroups

        tableView.separatorStyle = .none
        
        tableView.backgroundColor = #colorLiteral(red: 0.2980392157, green: 0.2078431373, blue: 0.2862745098, alpha: 1)
        
    }
    
    fileprivate class ChatroomHeaderLabel: UILabel {
        override func drawText(in rect: CGRect) {
            super.drawText(in: rect.insetBy(dx: 16, dy: 0))
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let text = section == 0 ? "UNREADS" : section == 1 ? "CHANNELS" : "DIRECT MESSAGES"
        
        let label = ChatroomHeaderLabel()
        label.text = text
        label.textColor = UIColor(red: 0.4745098039, green: 0.4078431373, blue: 0.4666666667, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.2980392157, green: 0.2078431373, blue: 0.2862745098, alpha: 1)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return filteredResults.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredResults[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ChatroomMenuCell(style: .default, reuseIdentifier: nil)
        
        let text = filteredResults[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = text
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        let attributedText = NSMutableAttributedString(string: "#  ", attributes: [.foregroundColor:  #colorLiteral(red: 0.4745098039, green: 0.4078431373, blue: 0.4666666667, alpha: 1), .font: UIFont.systemFont(ofSize: 18, weight: .regular)])
        attributedText.append(NSAttributedString(string: text, attributes: [.foregroundColor: UIColor.white]))
        cell.textLabel?.attributedText = attributedText
        
        cell.textLabel?.attributedText = attributedText
        
        return cell
    }

}
