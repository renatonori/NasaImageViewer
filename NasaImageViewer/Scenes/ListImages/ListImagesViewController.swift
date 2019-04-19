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
class ListImagesViewController: UIViewController,ShowImageDisplayLogic,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var failView: UIStackView!
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
        interactor?.getSegmentList()
        self.fetchImage()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    func setSegments(segments:[String]){
        self.segmentedControl.removeAllSegments()
        for (index,segment) in segments.enumerated(){
            self.segmentedControl.insertSegment(withTitle: segment, at: index, animated: false)
        }
        self.segmentedControl.selectedSegmentIndex = 0
    }
    
    //fetch Image list
    var displayedImages:[ListImages.FetchOrders.ViewModel.DisplayedImage] = []
    
    func fetchImage(){
        displayedImages.removeAll()
        self.imagesCollectionView.reloadData()
        interactor?.stopRequest()
        let request = ListImages.FetchOrders.Request(rover: self.getRover(), date: Date())
        interactor?.getListImages(request: request)
        self.showFail(fail: false)
        self.showLoading(show: true)
    }
    func getRover()->Rovers{
        switch self.segmentedControl.selectedSegmentIndex{
            case 0:
                return .Curiosity
            case 1:
                return .Opportunity
            case 2:
                return .Spirit
            default:
                return .Curiosity
        }
    }
    func displayFetchedImageList(viewModel: ListImages.FetchOrders.ViewModel) {
        self.showFail(fail: false)
        self.showLoading(show: false)
        displayedImages = viewModel.displayedImages
        DispatchQueue.main.async {
            self.imagesCollectionView.reloadData()
        }
    }
    func showFetchedError() {
        self.showFail(fail: true)
        self.showLoading(show: false)
    }
    func showFail(fail:Bool){
        DispatchQueue.main.async {
            self.failView.isHidden = !fail
            self.imagesCollectionView.isHidden = fail
        }
    }
    func showLoading(show:Bool){
        DispatchQueue.main.async {
            if show{
                self.activityIndicator.startAnimating()
            }else{
                self.activityIndicator.stopAnimating()
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    @IBAction func segmentedControlChange(_ sender: Any) {
        self.fetchImage()
    }
    @IBAction func tryAgainClicked(_ sender: Any) {
        self.fetchImage()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nasaImageCell", for: indexPath) as! NasaImageCollectionViewCell
        cell.setNasaImage(imageURLString: displayedImages[indexPath.row].img_src)
        cell.configure()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: size)
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
