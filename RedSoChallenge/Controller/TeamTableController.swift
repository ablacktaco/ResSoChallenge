//
//  TeamTableViewController.swift
//  RedSoChallenge
//
//  Created by 陳姿穎 on 2020/1/11.
//  Copyright © 2020 陳姿穎. All rights reserved.
//

import UIKit

//TODO
class TeamTableController: UIViewController, Storyboarded {
    
    private var networkManager: NetworkManager = NetworkManager()
    private var teamsData = RedSoModel(results: [])
    
    private var tableID: String!
    private var pageReadyToDownload: Int = 0
    
    private var isLoading: Bool = false
    
    @IBOutlet private var teamTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getEmployeeData(team: tableID, page: pageReadyToDownload) { (message, error) in
            if let error = error {
                print(error)
            }
            if let message = message {
                self.teamsData = message
                self.pageReadyToDownload += 1
                DispatchQueue.main.async {
                    self.teamTable.reloadData()
                }
            }
        }
        
        teamTable.dataSource = self
        teamTable.delegate = self
        
        teamTable.tableFooterView = UIView()
        
        teamTable.refreshControl = UIRefreshControl()
        teamTable.refreshControl?.tintColor = .white
        teamTable.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }

}

extension TeamTableController {
    
    static func setID(_ id: String) -> Self {
        let object = Self.instantiate()
        object.tableID = id
        
        return object
    }
    
    func getImageRatio(_ index: Int) -> CGFloat? {
        let cellImageView = UIImageView()
        ImageManager.shared.setImage(cellImageView, urlString: teamsData.results[index].url!)
        return cellImageView.image?.imageRatio()
    }
    
    @objc func handleRefreshControl() {
        pageReadyToDownload = 0
        networkManager.getEmployeeData(team: tableID, page: pageReadyToDownload) { (message, error) in
            if let error = error {
                print(error)
            }
            if let message = message {
                self.teamsData = message
                self.pageReadyToDownload += 1
                DispatchQueue.main.async {
                    self.teamTable.reloadData()
                    self.teamTable.refreshControl?.endRefreshing()
                }
            }
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
            
            cell.setImage(tableView, urlString: teamsData.results[indexPath.row].url!)
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
}

extension TeamTableController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if teamsData.results[indexPath.row].type == "banner", let imageRatio = getImageRatio(indexPath.row) {
            return tableView.frame.width / imageRatio
        }
        return UITableView.automaticDimension
    }
 
}

extension TeamTableController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        //
        if (offsetY > contentHeight - scrollView.frame.height * 4), !isLoading {
            //
            isLoading.toggle()
            networkManager.getEmployeeData(team: tableID, page: pageReadyToDownload) { (message, error) in
                if let error = error {
                    print(error)
                    self.isLoading.toggle()
                }
                if let message = message {
                    self.teamsData.results += message.results
                    self.pageReadyToDownload += 1
                    DispatchQueue.main.async {
                        self.teamTable.reloadData()
                        self.isLoading.toggle()
                    }
                }
            }
        }
    }

}

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

extension UIImage {

    func imageRatio() -> CGFloat {
        let imageRatio = CGFloat(self.size.width / self.size.height)
        return imageRatio
    }

}
