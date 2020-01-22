//
//  MainViewController.swift
//  RedSoChallenge
//
//  Created by 陳姿穎 on 2020/1/11.
//  Copyright © 2020 陳姿穎. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    private var mainView: MainView { view as! MainView }
    private var pageVC: TeamPageController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.getPageController(pageVC)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let pageVC = segue.destination as? TeamPageController else { return }
        self.pageVC = pageVC
    }

}
