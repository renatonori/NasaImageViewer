//
//  ShowImageViewController.swift
//  NasaImageViewer
//
//  Created by Renato Ioshida on 17/04/19.
//  Copyright © 2019 Renato Ioshida. All rights reserved.
//

import UIKit

class ShowImageViewController: UIViewController {
    var interactor: ShowImageInteractor?
    var router: (NSObjectProtocol & ShowImageRoutingLogic & ShowImageDataPassing)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    func setup(){
        let viewController = self
        let interactor = ShowImageInteractor()
        let presenter = ShowImagePresenter()
        let router = ShowImageRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func showImage(viewModel:ShowImage.GetImage.ViewModel){
        
    }
}
