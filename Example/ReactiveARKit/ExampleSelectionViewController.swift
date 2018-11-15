//
//  ExampleSelectionViewController.swift
//  ReactiveARKit_Example
//
//  Created by jalil.kennedy on 11/14/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ExampleSelectionViewController: UIViewController {
    @IBOutlet weak var exampleSelectionTableView: UITableView!
    
    private let disposeBag: DisposeBag = DisposeBag()
    private let viewModel: ExampleSelectionViewModel = ExampleSelectionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exampleSelectionTableView.register(cellClassWithXib: ExampleSelectionTableViewCell.self)

        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.sectionsObservable.bind(to: exampleSelectionTableView.rx.items(dataSource: viewModel.dataSource)).disposed(by: disposeBag)
        exampleSelectionTableView.rx.modelSelected(ExampleSelection.self).asDriver().drive(onNext: { model in
            switch model.exampleType {
            case .delegates:
                self.performSegue(withIdentifier: "DelegatesViewController", sender: self)
            case .none:
                return
            }
        }).disposed(by: disposeBag)
        //exampleSelectionTableView.rx.modelSelected(ExampleSelection.self).bind(to: viewModel.exampleSelectionCellSelectedRelay).disposed(by: disposeBag)
    }
}
