//
//  MusicViewController.swift
//  iTunesPracticeProject
//
//  Created by Yeonu Park on 2023/11/06.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MusicViewController: UIViewController {
    
    private let tableView: UITableView = {
       let view = UITableView()
        view.register(MusicTableViewCell.self, forCellReuseIdentifier: MusicTableViewCell.identifier)
        view.backgroundColor = .white
        view.rowHeight = 180
        view.separatorStyle = .none
       return view
     }()
    
    let searchBar = UISearchBar()
    
    var data: [MusicInfo] = []
     
    lazy var items = BehaviorSubject(value: data)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configure()
        bind()
        setSearchController()
        
    }
     
    func bind() {
        
        // cellforRowAt
        items
            .bind(to: tableView.rx.items(cellIdentifier: MusicTableViewCell.identifier, cellType: MusicTableViewCell.self)) { (row, element, cell) in
                cell.artistLabel.text = element.artistName
                cell.genreLabel.text = element.primaryGenreName
            }
            .disposed(by: disposeBag)

        
        let request = MusicAPIManager
            .fetchData()
            .asDriver(onErrorJustReturn: SearchMusicModel(resultCount: 0, results: []))
            
        request
            .drive(with: self) { owner, result in
                owner.items.onNext(result.results)
            }
            .disposed(by: disposeBag)
        
        request
            .map { data in
                "\(data.results.count)개의 검색 결과"
            }
            .drive(with: self) { owner, result in
                owner.searchBar.text = result
            }
            .disposed(by: disposeBag)
        
        
//        searchBar
//            .rx
//            .searchButtonClicked
//            .withLatestFrom(searchBar.rx.text.orEmpty) { void, text in
//                return text
//            }
//            .subscribe(with: self, onNext: { owner, text in
//                owner.data.insert(text, at: 0)
//                owner.items.onNext(owner.data)
//            })
//            .disposed(by: disposeBag)
//        
//        searchBar
//            .rx
//            .text
//            .orEmpty
//            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
//            .distinctUntilChanged()
//            .subscribe(with: self) { owner, value in
//                
//                let result = value == "" ? owner.data : owner.data.filter { $0.contains(value)}
//                owner.items.onNext(result)
//                
//                print("== 실시간 검색 == \(value)")
//            }
//            .disposed(by: disposeBag)
        
    }
    
    private func setSearchController() {
        view.addSubview(searchBar)
        self.navigationItem.titleView = searchBar
    }

    
    private func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

    }
}

