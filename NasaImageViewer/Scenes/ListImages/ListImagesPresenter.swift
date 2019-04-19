//
//  ListImagesPresenter.swift
//  NasaImageViewer
//
//  Created by Renato Ioshida on 17/04/19.
//  Copyright © 2019 Renato Ioshida. All rights reserved.
//

import UIKit
protocol ListImagesPresentationLogic {
    func presentFetchedImages(response:ListImages.FetchOrders.Response)
    func presentAllRovers()
    func showError()
}
class ListImagesPresenter:ListImagesPresentationLogic{
    weak var viewController: ShowImageDisplayLogic?
    
    func presentFetchedImages(response: ListImages.FetchOrders.Response) {
        var displayedImages:[ListImages.FetchOrders.ViewModel.DisplayedImage] = []
        for image in response.images{
            let displayerImg = ListImages.FetchOrders.ViewModel.DisplayedImage(id: image.id, name: image.name, full_name: image.full_name, img_src: image.img_src, earth_date: image.earth_date)
            displayedImages.append(displayerImg)
        }
        let viewModel = ListImages.FetchOrders.ViewModel(displayedImages: displayedImages)
        viewController?.displayFetchedImageList(viewModel: viewModel)
    }
    func showError() {
        viewController?.showFetchedError()
    }
    func presentAllRovers() {
        viewController?.setSegments(segments: ["Curiosity","Opportunity","Spirit"])
    }
}
