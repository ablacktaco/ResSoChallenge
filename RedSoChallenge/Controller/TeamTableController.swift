//
//  TeamTableViewController.swift
//  RedSoChallenge
//
//  Created by 陳姿穎 on 2020/1/11.
//  Copyright © 2020 陳姿穎. All rights reserved.
//

import UIKit

class TeamTableController: UIViewController, Storyboarded {
    
    private var networkManager: NetworkManager = NetworkManager()
    var teamsData = RedSoModel(results: [])
    
    var tableID: String!
    var currentPage: Int = 0
    
    var imageRatio: CGFloat?
    
    @IBOutlet var teamTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.getEmployeeData(team: tableID, page: currentPage) { (message, error) in
            if let error = error {
//                print(error)
            }
            if let message = message {
//                print(message)
                self.teamsData = message
                DispatchQueue.main.async {
                    self.teamTable.reloadData()
                }
            }
        }
        
        teamTable.dataSource = self
        teamTable.delegate = self
        
        teamTable.tableFooterView = UIView()
        
        teamTable.refreshControl = UIRefreshControl()
        teamTable.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }

}

extension TeamTableController {
    
    static func setID(_ id: String) -> Self {
        let object = Self.instantiate()
        object.tableID = id
        
        return object
    }
    
    @objc func handleRefreshControl() {
        
        
        DispatchQueue.main.async {
            self.teamTable.refreshControl?.endRefreshing()
        }
    }
    
}

extension TeamTableController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsData.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if teamsData.results[indexPath.row].type == "employee" {
            let cellIdentifier = "employeeCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EmployeeCell
            
            cell.setData(teamsData.results[indexPath.row])
            cell.selectionStyle = .none
            
            return cell
        } else {
            let cellIdentifier = "bannerCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BannerCell
            
            cell.setImage(teamsData.results[indexPath.row])
            imageRatio = cell.getImageRatio()
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
}

extension TeamTableController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if teamsData.results[indexPath.row].type == "banner", let imageRatio = imageRatio {
            return tableView.frame.width / imageRatio
        }
        
        return UITableView.automaticDimension
    }
 
}

//extension TeamTableController: UIScrollViewDelegate {
//
//
//
//}


protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)

        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        // load our storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
