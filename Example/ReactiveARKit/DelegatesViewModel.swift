//
//  DelegatesViewModel.swift
//  ReactiveARKit_Example
//
//  Created by jalil.kennedy on 11/15/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ReactiveARKit
import ARKit

class DelegatesViewModel {
    private let disposeBag: DisposeBag = DisposeBag()
    private var nodeCountDictionary: [Int:Int] = [:]

    var didAddNodeForAnchorRelay: PublishRelay<(ARSKView, SKNode, ARAnchor)> = PublishRelay<(ARSKView, SKNode, ARAnchor)>()
    var willUpdateNodeForAnchorRelay: PublishRelay<(ARSKView, SKNode, ARAnchor)> = PublishRelay<(ARSKView, SKNode, ARAnchor)>()
    var didUpdateNodeForAnchorRelay: PublishRelay<(ARSKView, SKNode, ARAnchor)> = PublishRelay<(ARSKView, SKNode, ARAnchor)>()
    var didRemoveNodeForAnchorRelay: PublishRelay<(ARSKView, SKNode, ARAnchor)> = PublishRelay<(ARSKView, SKNode, ARAnchor)>()
    
    init() {
        setupObservers()
    }
    
    private func setupObservers() {
        didAddNodeForAnchorRelay.subscribe(onNext: { event in
            let nameLabelNode = SKLabelNode(text: "Anchor")
            let updateCountLabelNode = SKLabelNode(text: "Update count: 0")
            updateCountLabelNode.position.y = nameLabelNode.frame.maxY
            
            self.nodeCountDictionary[ObjectIdentifier(updateCountLabelNode).hashValue] = 0
            
            switch event.2 {
            case is ARPlaneAnchor:
                nameLabelNode.text = "Plane"
            case is ARObjectAnchor:
                nameLabelNode.text = "Object"
            case is ARImageAnchor:
                nameLabelNode.text = "Image"
            case is ARFaceAnchor:
                nameLabelNode.text = "Face"
            default:
                return
            }
            
            event.1.addChild(nameLabelNode)
            event.1.addChild(updateCountLabelNode)
        }).disposed(by: disposeBag)

        willUpdateNodeForAnchorRelay.subscribe(onNext: { event in
            print("Will update node \(event.1) for anchor \(event.2) to \(event.0) session")
        }).disposed(by: disposeBag)

        didUpdateNodeForAnchorRelay.subscribe(onNext: { event in
            event.1.children.forEach {
                guard
                    let updateCount = self.nodeCountDictionary[ObjectIdentifier($0).hashValue],
                    let labelNode = $0 as? SKLabelNode
                    else { return }
                
                labelNode.text = "Update count: \(updateCount + 1)"
                self.nodeCountDictionary[ObjectIdentifier(labelNode).hashValue] = updateCount + 1
            }
        }).disposed(by: disposeBag)

        didRemoveNodeForAnchorRelay.subscribe(onNext: { event in
            print("Did remove node \(event.1) for anchor \(event.2) to \(event.0) session")
        }).disposed(by: disposeBag)
    }
}
