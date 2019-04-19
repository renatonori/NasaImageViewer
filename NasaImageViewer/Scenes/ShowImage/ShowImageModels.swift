//
//  ShowImageModels.swift
//  NasaImageViewer
//
//  Created by Renato Ioshida on 17/04/19.
//  Copyright © 2019 Renato Ioshida. All rights reserved.
//

import UIKit

enum ShowImage
{
    // MARK: Use cases
    enum GetImage
    {
        struct Request
        {
        }
        struct Response
        {
            var image: NasaImage
        }
        struct ViewModel
        {
            struct DisplayedImage
            {
                var image_src:String
                var name: String
                var full_name:String
            }
            var displayedOrder:DisplayedImage
        }
    }
}
