//
//  NasaImages.swift
//  NasaImageViewer
//
//  Created by Renato Ioshida on 18/04/19.
//  Copyright © 2019 Renato Ioshida. All rights reserved.
//

import Foundation

struct NasaImage: Equatable,Codable{
    let id:Int
    let name:String
    let full_name:String
    let img_src:String
    var earth_date:String
}
