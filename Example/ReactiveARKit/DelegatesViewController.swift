//
//  DelegatesViewController.swift
//  ReactiveARKit_Example
//
//  Created by jalil.kennedy on 11/15/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ARKit
import RxSwift
import RxCocoa
import ReactiveARKit

class DelegatesViewController: UIViewController {
    @IBOutlet weak var skview: ARSKView!
    
    private let disposeBag: DisposeBag = DisposeBag()
    private let viewModel: DelegatesViewModel = DelegatesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupARSession()
    }
    
    private func setupARSession() {
        guard let scene = SKScene(fileNamed: "Scene") else { fatalError("Failed to load initial SKScene") }
        skview.presentScene(scene)
        
        #if debug
        skview.showsFPS = true
        skview.showsNodeCount = true
        #endif
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        skview.session.run(configuration)
    }
    
    private func bindViewModel() {
        skview.rx.didAddNodeForAnchor.bind(to: viewModel.didAddNodeForAnchorRelay).disposed(by: disposeBag)
        skview.rx.willUpdateNodeForAnchor.bind(to: viewModel.willUpdateNodeForAnchorRelay).disposed(by: disposeBag)
        skview.rx.didUpdateNodeForAnchor.bind(to: viewModel.didUpdateNodeForAnchorRelay).disposed(by: disposeBag)
        skview.rx.didRemoveNodeForAnchor.bind(to: viewModel.didRemoveNodeForAnchorRelay).disposed(by: disposeBag)
    }
}
