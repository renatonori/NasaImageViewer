//
//  ShowImageRouter.swift
//  NasaImageViewer
//
//  Created by Renato Ioshida on 17/04/19.
//  Copyright © 2019 Renato Ioshida. All rights reserved.
//

import UIKit
protocol ShowImageRoutingLogic {
    
}

protocol ShowImageDataPassing {
    var dataStore:ShowImageDataStore? {get}
}
class ShowImageRouter: NSObject,ShowImageRoutingLogic,ShowImageDataPassing {
    weak var viewController:ShowImageViewController?
    var dataStore: ShowImageDataStore?
}
