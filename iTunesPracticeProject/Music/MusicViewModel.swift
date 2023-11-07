//
//  MusicViewModel.swift
//  iTunesPracticeProject
//
//  Created by Yeonu Park on 2023/11/07.
//

import Foundation
import RxSwift
import RxCocoa

class MusicViewModel {
    
    struct Input {
        let text: Observable<String>
    }
    
    struct Output {
        let items : Observable<[MusicInfo]>
    }
    
    func transform(input: Input) -> Output {
        
        let items = input.text
            .flatMap {
                MusicAPIManager.fetchData(query: $0)
            }
            .map {
                $0.results
            }
        
        return Output(items: items)
    }
}
