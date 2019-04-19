//
//  ListImagesWorker.swift
//  NasaImageViewer
//
//  Created by Renato Ioshida on 17/04/19.
//  Copyright © 2019 Renato Ioshida. All rights reserved.
//

import UIKit

class ListImagesWorker{
    func fetchList(date:Date,rover:Rovers,success:@escaping(([NasaImage])->Void), fail:@escaping (ImagesGetError?) -> Void){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let atualDate = formatter.string(from: date)
        
        let imageGetter = NasaImageGetterAPI()
        
        let imageURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/\(rover)/photos?earth_date=\(atualDate)&api_key=DEMO_KEY")
        
        imageGetter.getMovies(url: imageURL!, successHandler: { (images) in
            success(self.fetch(apiImages:images))
        }) { (error) in
            fail(error)
        }
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
