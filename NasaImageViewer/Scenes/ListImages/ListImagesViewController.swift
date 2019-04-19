//
//  ListImagesViewController.swift
//  NasaImageViewer
//
//  Created by Renato Ioshida on 17/04/19.
//  Copyright © 2019 Renato Ioshida. All rights reserved.
//

import UIKit
protocol ShowImageDisplayLogic: class
{
    func displayFetchedImageList(viewModel: ListImages.FetchOrders.ViewModel)
    func showFetchedError()
    func setSegments(segments:[String])
}
class ListImagesViewController: UIViewController,ShowImageDisplayLogic,UICollectionViewDelegate,UICollectionViewDataSource{

    

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    var interactor: ListImageBusinessLogic?
    var router: (NSObjectProtocol & ListImagesRoutingLogic & ListImagesDataPassing)?
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
        let interactor = ListImagesInteractor()
        let presenter = ListImagesPresenter()
        let router = ListImagesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    func setSegments(segments:[String]){
        self.segmentedControl.removeAllSegments()
        for (index,segment) in segments.enumerated(){
            self.segmentedControl.insertSegment(withTitle: segment, at: index, animated: false)
        }
    }
    func displayFetchedImageList(viewModel: ListImages.FetchOrders.ViewModel) {
        
    }
    func showFetchedError() {

    }
    var imageArray = ["TEste","TEste","TEste","TEste","TEste","TEste","TEste","TEste","TEste","TEste","TEste","TEste","TEste"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "proCell", for: indexPath) as! CollectionViewCell
//        cell.proLbl.text = imageArray[indexPath.row]
//        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
