//
//  NasaImageCollectionViewCell.swift
//  NasaImageViewer
//
//  Created by Renato Ioshida on 19/04/19.
//  Copyright © 2019 Renato Ioshida. All rights reserved.
//

import UIKit

class NasaImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nasaImageView: UIImageView!
    
    
    func setNasaImage(imageURLString:String){
        let url:URL = URL(string: imageURLString)!
        nasaImageView.load(url: url)
    }
    func configure(){
        self.contentView.layer.cornerRadius = 8.0
        self.contentView.layer.masksToBounds = true
    
    }
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
