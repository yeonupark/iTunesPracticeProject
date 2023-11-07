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
    
    let disposeBag = DisposeBag()
    
    let viewModel = MusicViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configure()
        bind()
        setSearchController()
        
    }
     
    func bind() {
        
        let input = MusicViewModel.Input(text: searchBar.rx.searchButtonClicked.withLatestFrom(searchBar.rx.text.orEmpty) { $1 })
        
        let output = viewModel.transform(input: input)
        
        output.items
            .bind(to: tableView.rx.items(cellIdentifier: MusicTableViewCell.identifier, cellType: MusicTableViewCell.self)) { (row, element, cell) in
                cell.artistLabel.text = element.artistName
                cell.genreLabel.text = element.primaryGenreName
            }
            .disposed(by: disposeBag)
        
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

