//
//  ShowImagePresenter.swift
//  NasaImageViewer
//
//  Created by Renato Ioshida on 17/04/19.
//  Copyright © 2019 Renato Ioshida. All rights reserved.
//

import UIKit
protocol ShowImagePresentationLogic {
    func showImage(respose:ShowImage.GetImage.Response)
}
class ShowImagePresenter: ShowImagePresentationLogic {
    var viewController:ShowImageViewController?
    func showImage(respose: ShowImage.GetImage.Response) {
        let image:NasaImage = respose.image
        let displayedImage = ShowImage.GetImage.ViewModel.DisplayedImage(image_src: image.img_src, name: image.name, full_name: image.full_name)
        let viewModel = ShowImage.GetImage.ViewModel(displayedOrder: displayedImage)
        viewController?.showImage(viewModel: ShowImage.GetImage.ViewModel(displayedOrder: viewModel.displayedOrder))
    }
}
