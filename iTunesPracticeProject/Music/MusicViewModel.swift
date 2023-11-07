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
    
    //var data: [MusicInfo] = []
    lazy var items = PublishSubject<[MusicInfo]>()
    // BehaviorSubject(value: data)
}
