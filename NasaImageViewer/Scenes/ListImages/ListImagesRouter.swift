//
//  ListImagesRouter.swift
//  NasaImageViewer
//
//  Created by Renato Ioshida on 17/04/19.
//  Copyright © 2019 Renato Ioshida. All rights reserved.
//

import UIKit

@objc protocol ListImagesRoutingLogic{
    func routeToShowImage(segue:UIStoryboardSegue?)
}
protocol ListImagesDataPassing {
    var dataStore:ListImagesDataStore? {get}
}
class ListImagesRouter: NSObject,ListImagesRoutingLogic, ListImagesDataPassing{

    weak var viewController: ListImagesViewController?
    var dataStore: ListImagesDataStore?
    
    func routeToShowImage(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! ShowImageViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToShowImage(source: dataStore!, destination: &destinationDS)
        } else {
            let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "ShowImageViewController") as! ShowImageViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToShowImage(source: dataStore!, destination: &destinationDS)
            navigateToshowImage(source: viewController!, destination: destinationVC)
        }
    }
    func navigateToshowImage(source: ListImagesViewController, destination: ShowImageViewController)
    {
        source.show(destination, sender: nil)
    }
    func passDataToShowImage(source: ListImagesDataStore, destination: inout ShowImageDataStore)
    {
        let selectedRow = viewController?.imagesCollectionView.indexPathsForSelectedItems?.first
        
//        let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
        destination.nasaImage = source.nasaImages?[(selectedRow?.row)!]
    }

}
