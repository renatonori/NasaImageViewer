//
//  ListImagesWorker.swift
//  NasaImageViewer
//
//  Created by Renato Ioshida on 17/04/19.
//  Copyright © 2019 Renato Ioshida. All rights reserved.
//

import UIKit

class ListImagesWorker{
    
    var fetchRequest:URLSessionDataTask?
    
    func fetchList(date:Date,rover:Rovers,success:@escaping(([NasaImage])->Void), fail:@escaping (ImagesGetError?) -> Void){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let atualDate = formatter.string(from: date)
        
        let imageGetter = NasaImageGetterAPI()
        
        let imageURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/\(rover)/photos?earth_date=\(atualDate)&api_key=rNz2qJpBFsuNhsq5XFoPYiXsLPxo5hdfmOwm1qJ0")
        
        fetchRequest = imageGetter.getMovies(url: imageURL!, successHandler: { (images) in
            success(self.fetch(apiImages:images))
        }) { (error) in
            if let error = error{
                if error == .CannotGetImage{
                    self.fetchList(date: self.previousDay(fromDate: date), rover: rover, success: success, fail: fail)
                }
            }else{
                fail(error)
            }
        }
        
    }
    func stopFetch(){
        self.fetchRequest?.cancel()
    }
    func previousDay(fromDate:Date)->Date{
        return Calendar.current.date(byAdding: .day, value: -1, to: fromDate)!
    }
    func fetch(apiImages:[NasaImageAPI])->[NasaImage]{
        var nasaImageArray:[NasaImage] = []
        for image in apiImages{
            
            let nasaImage = NasaImage(id: image.id,
                      name: image.camera.name,
                      full_name: image.camera.full_name,
                      img_src: image.img_src,
                      earth_date: image.earth_date)
           nasaImageArray.append(nasaImage)
        }
        return nasaImageArray
    }
}
