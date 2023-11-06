//
//  MusicTableViewCell.swift
//  iTunesPracticeProject
//
//  Created by Yeonu Park on 2023/11/06.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MusicTableViewCell: UITableViewCell {
    static let identifier = "MusicTableViewCell"
    
    let artistLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textColor = .white
        label.backgroundColor = .systemBlue
        
        return label
    }()
    
    var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        configure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag() //
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(artistLabel)
        contentView.addSubview(genreLabel)
        
        artistLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(4)
        }
        
        genreLabel.snp.makeConstraints {
            $0.centerY.equalTo(artistLabel)
            $0.leading.equalTo(artistLabel.snp.trailing).offset(20)
            $0.height.equalTo(32)
            //$0.width.equalTo(100)
        }
    }
}
