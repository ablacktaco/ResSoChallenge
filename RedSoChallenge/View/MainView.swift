//
//  MainView.swift
//  RedSoChallenge
//
//  Created by 陳姿穎 on 2020/1/18.
//  Copyright © 2020 陳姿穎. All rights reserved.
//

import UIKit

class MainView: UIView {

    private weak var pageVC: TeamPageController?
    
    @IBAction private func tapToSwitchPage(_ sender: UIButton) {
        pageVC?.setPage(sender.tag)
    }

}

extension MainView {
    
    func getPageController(_ vc: TeamPageController) { self.pageVC = vc }
    
}
