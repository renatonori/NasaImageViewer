//
//  ListImagesModels.swift
//  NasaImageViewer
//
//  Created by Renato Ioshida on 17/04/19.
//  Copyright © 2019 Renato Ioshida. All rights reserved.
//

import UIKit

public let allRovers:[String] = ["Curiosity","Opportunity","Spirit"]
enum Rovers:String{
    case Curiosity = "Curiosity"
    case Opportunity = "Opportunity"
    case Spirit = "Spirit"
}
enum ListImages
{
    // MARK: Use cases
    
    enum FetchOrders
    {
        struct Request
        {
            var rover:Rovers
        }
        struct Response
        {
            var images: [NasaImage]
        }
        struct ViewModel
        {
            
            struct DisplayedImage
            {
                var id:Int
                var name:String
                var full_name:String
                var img_src:String
                var earth_date:String
            }
            var displayedImages: [DisplayedImage]
        }
    }
}
