//
//  BannerCell.swift
//  RedSoChallenge
//
//  Created by 陳姿穎 on 2020/1/14.
//  Copyright © 2020 陳姿穎. All rights reserved.
//

import UIKit

class BannerCell: UITableViewCell {

    private var downloadCompletionBlock: ((_ data: Data) -> Void)?
    
    @IBOutlet private var bannerImageView: UIImageView!
}

extension BannerCell {
    
    func setImage(_ data: RedSoModel.Result) {
        downloadByDownloadTask(urlString: data.url!, completion: { (data) in
            self.bannerImageView.image = UIImage(data: data)
        })
    }
    
    func getImageRatio() -> CGFloat? {
        if let imageCrop = bannerImageView.image?.getImageRatio() {
            return imageCrop
        }
        return nil
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

extension BannerCell: URLSessionDownloadDelegate {
    
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

extension UIImage {

    func getImageRatio() -> CGFloat {
        let imageRatio = CGFloat(self.size.width / self.size.height)
        return imageRatio
    }

}
