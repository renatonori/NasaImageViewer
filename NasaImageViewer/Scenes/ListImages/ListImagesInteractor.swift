//
//  ListImagesInteractor.swift
//  NasaImageViewer
//
//  Created by Renato Ioshida on 17/04/19.
//  Copyright © 2019 Renato Ioshida. All rights reserved.
//

import UIKit

protocol ListImageBusinessLogic {
    func getListImages(request:ListImages.FetchOrders.Request)
    func getSegmentList()
    func stopRequest()
}
protocol ListImagesDataStore {
    var nasaImages:[NasaImage]? {get}
}
class ListImagesInteractor: ListImageBusinessLogic,ListImagesDataStore{
    var nasaImages: [NasaImage]?

    var listImagesWorker:ListImagesWorker = ListImagesWorker()
    var presenter:ListImagesPresentationLogic?
    
    func getListImages(request:ListImages.FetchOrders.Request){
        listImagesWorker.fetchList(date: request.date, rover: request.rover, success: { (response) in
            self.nasaImages = response
            self.presenter?.presentFetchedImages(response: ListImages.FetchOrders.Response(images:response))
        }) { (error) in
            self.presenter?.showError()
        }
    }
    func stopRequest(){
        listImagesWorker.stopFetch()
    }
    func getSegmentList(){
        self.presenter?.presentAllRovers()
    }
}
