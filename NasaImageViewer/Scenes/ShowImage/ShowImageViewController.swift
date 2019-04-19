//
//  ShowImageViewController.swift
//  NasaImageViewer
//
//  Created by Renato Ioshida on 17/04/19.
//  Copyright © 2019 Renato Ioshida. All rights reserved.
//

import UIKit

class ShowImageViewController: UIViewController,UIScrollViewDelegate{
    
    @IBOutlet weak var nameLabbel: UILabel!
    
    @IBOutlet weak var nasaImageView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
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
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        self.fetchImage()
    }
    var fullName:String = ""
    var name:String = ""
    @IBAction func changeNameButton(_ sender: Any) {
        if self.nameLabbel.text == name{
            self.nameLabbel.text = fullName
        }else{
            self.nameLabbel.text = name
        }
    }
    func fetchImage(){
        let request = ShowImage.GetImage.Request()
        interactor?.getImage(request: request)
    }
    func showImage(viewModel:ShowImage.GetImage.ViewModel){
        let displayedOrder = viewModel.displayedOrder
        let url = URL(string: displayedOrder.image_src)!
        self.nasaImageView.load(url: url)
        self.fullName = displayedOrder.full_name
        self.name = displayedOrder.name
        self.nameLabbel.text = displayedOrder.name
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return nasaImageView
    }
}
