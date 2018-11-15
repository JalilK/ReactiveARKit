//
//  ExampleSelectionViewModel.swift
//  ReactiveARKit_Example
//
//  Created by jalil.kennedy on 11/14/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import RxOptional

class ExampleSelectionViewModel {
    private let disposeBag: DisposeBag = DisposeBag()
    private var sections: [ExampleSelectionSection] = [
        ExampleSelectionSection(header: "", items: [ExampleSelection(titleString: "Delegate Observables", exampleType: .delegates)])
    ]
    
    private var selectedExampleSelectionRowRelay: PublishRelay<ExampleSelection?> = PublishRelay<ExampleSelection?>()
    private var selectedViewControllerRelay: PublishRelay<UIViewController> = PublishRelay<UIViewController>()
    
    lazy var sectionsObservable: Observable<[ExampleSelectionSection]> = { return Observable.just(sections) }()
    var exampleSelectionCellSelectedRelay: PublishRelay<ExampleSelection> = PublishRelay<ExampleSelection>()
    var dataSource: RxTableViewSectionedReloadDataSource<ExampleSelectionSection>!
    
    init() {
        setupDatasource()
    }
    
    private func setupObservers() {
//        selectedExampleSelectionRowRelay.filterNil().map { exampleSelection -> UIViewController in
//            switch exampleSelection.exampleType {
//            case .delegates:
//                return UIViewController
//            case .none:
//                return UIViewController()
//            }
//        }
//        .bind(to: selectedViewControllerRelay)
//        .disposed(by: disposeBag)
    }
    
    private func setupDatasource() {
        dataSource = RxTableViewSectionedReloadDataSource<ExampleSelectionSection>(configureCell: {
            _, tableView, _, item in
            guard let cell: ExampleSelectionTableViewCell = tableView.dequeueReusableCell() else { return UITableViewCell() }
            
            cell.configure(with: ExampleSelectionCellViewModel(exampleSelection: item))
            
            return cell
        })
    }
}

public enum ExampleType {
    case none
    case delegates
}

class ExampleSelectionCellViewModel {
    private var exampleSelectionRelay: BehaviorRelay<ExampleSelection>!
    
    var exampleTitle: Driver<String> {
        return exampleSelectionRelay.unsafelyUnwrapped.map { $0.titleString }.asDriver(onErrorJustReturn: "")
    }
    
    var exampleType: Driver<ExampleType> {
        return exampleSelectionRelay.unsafelyUnwrapped.map { $0.exampleType }.asDriver(onErrorJustReturn: .none)
    }
    
    var backgroundColor: Driver<UIColor> {
        return exampleSelectionRelay.unsafelyUnwrapped.map {
            switch $0.exampleType {
            case .none:
                return UIColor.white
            case .delegates:
                return UIColor.green
            }
        }
        .asDriver(onErrorJustReturn: UIColor.white)
    }
    
    init(exampleSelection: ExampleSelection) {
        exampleSelectionRelay = BehaviorRelay<ExampleSelection>(value: exampleSelection)
    }
}

struct ExampleSelection {
    var titleString: String
    var exampleType: ExampleType
}

struct ExampleSelectionSection {
    var header: String
    var items: [ExampleSelection]
}

extension ExampleSelectionSection: SectionModelType {
    typealias Item = ExampleSelection
    
    init(original: ExampleSelectionSection, items: [Item]) {
        self = original
        self.items = items
    }
}

