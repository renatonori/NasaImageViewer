//
//  ShowImageInteractor.swift
//  NasaImageViewer
//
//  Created by Renato Ioshida on 17/04/19.
//  Copyright © 2019 Renato Ioshida. All rights reserved.
//

import UIKit
protocol ShowImageBusinessLogic {
    func getImage(request:ShowImage.GetImage.Request)
}
protocol ShowImageDataStore{
    var nasaImage:NasaImage! {get set}
}
class ShowImageInteractor: NSObject,ShowImageBusinessLogic,ShowImageDataStore{
    var presenter:ShowImagePresentationLogic?
    var nasaImage: NasaImage!
    
    func getImage(request: ShowImage.GetImage.Request) {
        let response = ShowImage.GetImage.Response(image: nasaImage)
        self.presenter?.showImage(respose: response)
    }
}
