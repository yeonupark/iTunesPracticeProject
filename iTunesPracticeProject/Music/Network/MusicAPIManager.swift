//
//  MusicAPIManager.swift
//  iTunesPracticeProject
//
//  Created by Yeonu Park on 2023/11/06.
//

import Foundation
import RxSwift
import Alamofire

enum APIError: Error {
    case invalidURL
    case unknown
    case statusError
}

class MusicAPIManager {
    
    static func fetchData(query: String) -> Observable<SearchMusicModel> {
        
        return Observable<SearchMusicModel>.create { value in
            
            let urlString = "https://itunes.apple.com/search?term=\(query)&limit=10"
            
            guard let url = URL(string: urlString) else {
                value.onError(APIError.invalidURL)
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
            
            print("URLSession 성공")
            if let _ = error {
                value.onError(APIError.unknown)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                value.onError(APIError.statusError)
                return
            }
            
            if let data = data, let musicData = try?
                JSONDecoder().decode(SearchMusicModel.self, from: data) {
                value.onNext(musicData)
                print(musicData)
            }
            print(data?.count)
        }.resume()
            
            return Disposables.create()
            
        }
    }
}
