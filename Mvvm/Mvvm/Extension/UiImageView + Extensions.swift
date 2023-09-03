//
//  UiImageView + Extensions.swift
//  Mvvm
//
//  Created by Adarsh Singh on 04/09/23.
//

import UIKit
import Kingfisher

extension UIImageView{
    
    func setImage(with urlString: String){
        guard let url = URL.init(string: urlString) else{
            return
        }
        
        let resource = KF.ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}
