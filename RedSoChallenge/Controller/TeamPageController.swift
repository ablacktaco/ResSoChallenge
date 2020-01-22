//
//  TeamPageViewController.swift
//  RedSoChallenge
//
//  Created by 陳姿穎 on 2020/1/11.
//  Copyright © 2020 陳姿穎. All rights reserved.
//

import UIKit

class TeamPageController: UIPageViewController {

    //
    private lazy var rangersTableVC = TeamTableController.setID("rangers")
    private lazy var elasticTableVC = TeamTableController.setID("elastic")
    private lazy var dynamoTableVC = TeamTableController.setID("dynamo")
    
    private var teamTableVCs: [TeamTableController] {
        [rangersTableVC, elasticTableVC, dynamoTableVC]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPage(0)
        dataSource = self
    }

}

extension TeamPageController {
    
    func setPage(_ page: Int) {
        setViewControllers([teamTableVCs[page]], direction: .forward, animated: true, completion: nil)
    }
    
}

extension TeamPageController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = teamTableVCs.firstIndex(of: viewController as! TeamTableController), index > 0 {
            return teamTableVCs[index - 1]
        }
        return teamTableVCs.last
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = teamTableVCs.firstIndex(of: viewController as! TeamTableController), index < teamTableVCs.count - 1 {
            return teamTableVCs[index + 1]
        }
        return teamTableVCs.first
    }
    
}
