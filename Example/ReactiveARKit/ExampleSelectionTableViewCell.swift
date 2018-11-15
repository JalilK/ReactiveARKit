//
//  ExampleSelectionTableViewCell.swift
//  ReactiveARKit_Example
//
//  Created by jalil.kennedy on 11/14/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ExampleSelectionTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    private var disposeBag: DisposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with viewModel: ExampleSelectionCellViewModel) {
        viewModel.exampleTitle.drive(titleLabel.rx.text).disposed(by: disposeBag)
        viewModel.backgroundColor.drive(contentView.rx.backgroundColor).disposed(by: disposeBag)
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
}
