//
//  ConversationsListViewController.swift
//  Chat
//
//  Created by Семен Кривоносов on 07/10/2018.
//  Copyright © 2018 Семен Кривоносов. All rights reserved.
//

import UIKit

class ConversationsListViewController: UITableViewController {

    
    // TEST DATA
    
    lazy var onlineConversationsList : [(String?, String?, Date?, Bool, Bool)] = {
        var result : [(String?, String?, Date?, Bool, Bool)] = []
        let messages = ["Hello", "Fuck u", nil]
        let names = ["Denis Chuvashev", "Vlad Tatarin", nil]
        let dates = [Date(), Date(timeIntervalSince1970: 50000), Calendar.current.date(byAdding: .hour, value: -25, to: Date())]
        let unreads = [true, false]
        for name in names {
            for message in messages {
                for date in dates {
                    for unread in unreads {
                        result += [(name, message, date, true, unread)]
                    }
                }
            }
        }
        return result
    }()
    lazy var historyConversationsList : [(String?, String?, Date?, Bool, Bool)] = {
        var result : [(String?, String?, Date?, Bool, Bool)] = []
        let messages = ["Hi", "Fuck u", nil]
        let names = ["Alex Michalevich", "Valera Vamosov", nil]
        let dates = [Date(), Date(timeIntervalSince1970: 33333333), Calendar.current.date(byAdding: .month, value: -1, to: Date())]
        let unreads = [true, false]
        for name in names {
            for message in messages {
                for date in dates {
                    for unread in unreads {
                        result += [(name, message, date, false, unread)]
                    }
                }
            }
        }
        return result
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return onlineConversationsList.count
        case 1:
            return historyConversationsList.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath) as! ConversationCell
        let name : String?, message : String?, date : Date?, online : Bool, unreadMessage : Bool
        switch indexPath.section {
        case 0:
            (name, message, date, online, unreadMessage) = onlineConversationsList[indexPath.row]
        case 1:
            (name, message, date, online, unreadMessage) = historyConversationsList[indexPath.row]
        default:
            fatalError("Index Is Invalid")
        }
        cell.setParams(name, message, date, online, unreadMessage)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Online"
        case 1:
            return "History"
        default:
            return nil
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toConversation" {
            if let cell = sender as? ConversationCell,
                let conversationViewController = segue.destination as? ConversationViewController { 
                conversationViewController.navigationItem.title = cell.name ?? "Undefined Name"
            }
        }
        else if segue.identifier == "toThemes" {
            guard let themesNVC = segue.destination as? UINavigationController, let themesVC = themesNVC.viewControllers.first as? ThemesViewController else { return }
            themesVC.delegate = self
        }
        else {
            super.prepare(for: segue, sender: sender)
        }
    }
    @IBAction func unwindToConversationList(unwindSegue: UIStoryboardSegue) {
        
    }
}
extension ConversationsListViewController: ThemesViewControllerDelegate {
    func themesViewController(_ controller: ThemesViewController, didSelectTheme selectedTheme: UIColor) {
        controller.view.backgroundColor = selectedTheme
        UINavigationBar.appearance().barTintColor = selectedTheme
        guard let colorData =  try? NSKeyedArchiver.archivedData(withRootObject: selectedTheme, requiringSecureCoding: false) else { return }
        UserDefaults.standard.set(colorData, forKey: "Theme")
        logThemeChanging(selectedTheme: selectedTheme)
    }
    private func logThemeChanging(selectedTheme: UIColor) {
        print(#function, selectedTheme.debugDescription)
    }
    
}
