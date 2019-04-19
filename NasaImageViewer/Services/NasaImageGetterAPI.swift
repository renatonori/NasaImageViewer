//
//  NasaImageGetterAPI.swift
//  NasaImageViewer
//
//  Created by Renato Ioshida on 18/04/19.
//  Copyright © 2019 Renato Ioshida. All rights reserved.
//

import UIKit
struct NasaImageAPI:Codable{
    let id:Int
    let camera:CameraInformationAPI
    let img_src:String
    let earth_date:String
}
struct NasaImagesAPI:Codable {
    let photos:[NasaImageAPI]
}
struct CameraInformationAPI:Codable {
    let name:String
    let full_name:String
}

class NasaImageGetterAPI: NSObject {
    func getMovies(url: URL, successHandler: @escaping ([NasaImageAPI]) -> Void, errorHandler: @escaping (ImagesGetError?) -> Void) {
        let task = URLSession.shared.dataTask(with: url){ (result) in
            switch result {
            case .success( _ , let data):
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(NasaImagesAPI.self, from:
                        data) //Decode JSON Response Data
                    errorHandler(.CannotGetImage("No Image Founded"))
//                    if model.photos.count > 0{
//                        successHandler(model.photos)
//                    }else{
//                        errorHandler(.CannotGetImage("No Image Founded"))
//                    }
                } catch let parsingError {
                    errorHandler(.CannotGet(parsingError.localizedDescription))
                }
                break
            case .failure(let error):
                errorHandler(.CannotGet(error.localizedDescription))
                break
            }
        }
        task.resume()
       
    }
}

enum ImagesGetError: Equatable, Error
{
    case CannotGet(String)
    case CannotGetImage(String)
}

extension URLSession {
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}
