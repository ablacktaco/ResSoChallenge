//
//  DataCell.swift
//  RedSoChallenge
//
//  Created by 陳姿穎 on 2020/1/11.
//  Copyright © 2020 陳姿穎. All rights reserved.
//

import UIKit

class EmployeeCell: UITableViewCell {
    
    private var downloadCompletionBlock: ((_ data: Data) -> Void)?
    
    @IBOutlet private var employeeImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var positionLabel: UILabel!
    @IBOutlet private var expertiseLabel: UILabel!
    
}

extension EmployeeCell {
    
    func setData(_ data: RedSoModel.Result) {
        nameLabel.text = data.name
        positionLabel.text = data.position
        expertiseLabel.text = setExpertise(data.expertise!)
        setImage(data)
    }
    
    fileprivate func setExpertise(_ data: [String]) -> String {
        var employeeExpertise: String = ""
        
        data.forEach({ (expertise) in
            employeeExpertise += "\(expertise), "
        })
        employeeExpertise.removeLast(2)
        
        return employeeExpertise
    }
    
    fileprivate func setImage(_ data: RedSoModel.Result) {
        downloadByDownloadTask(urlString: data.avatar!, completion: { (data) in
            self.employeeImageView.image = UIImage(data: data)
        })
        employeeImageView.layer.cornerRadius = employeeImageView.frame.width / 2
        employeeImageView.clipsToBounds = true
    }
    
    fileprivate func downloadByDownloadTask(urlString: String?, completion: @escaping (Data) -> Void){
        if let urlString = urlString {
            let url = URL(string: urlString)!
            let request = URLRequest(url: url)
            
            let configiguration = URLSessionConfiguration.default
            configiguration.timeoutIntervalForRequest = .infinity
            
            let urlSession = URLSession(configuration: configiguration, delegate: self, delegateQueue: OperationQueue.main)
            
            let task = urlSession.downloadTask(with: request)
            
            downloadCompletionBlock = completion
            
            task.resume()
        }
    }
    
}

extension EmployeeCell: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let data = try! Data(contentsOf: location)
        if let block = downloadCompletionBlock {
            block(data)
        }
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
//        print(progress)
    }
    
}
