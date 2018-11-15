//
//  RxARSKViewDelegateProxy.swift
//  Pods
//
//  Created by jalil.kennedy on 10/12/18.
//

import Foundation
import RxSwift
import RxCocoa
import ARKit

class RxARSKViewDelegateProxy: DelegateProxy<ARSKView, ARSKViewDelegate>, ARSKViewDelegate, DelegateProxyType {
    static func registerKnownImplementations() {
        RxARSKViewDelegateProxy.register { RxARSKViewDelegateProxy(parentObject: $0) }
    }
    
    init(parentObject: ARSKView) {
        super.init(parentObject: parentObject, delegateProxy: RxARSKViewDelegateProxy.self)
    }
    
    fileprivate let arskViewDelegateNotSet = ARSKViewDelegateNotSet()
    fileprivate final class ARSKViewDelegateNotSet: NSObject, ARSKViewDelegate {
        func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
            return SKNode()
        }
        
        func view(_ view: ARSKView, didAdd node: SKNode, for anchor: ARAnchor) {
        }
        
        func view(_ view: ARSKView, willUpdate node: SKNode, for anchor: ARAnchor) {
        }
        
        func view(_ view: ARSKView, didUpdate node: SKNode, for anchor: ARAnchor) {
        }
        
        func view(_ view: ARSKView, didRemove node: SKNode, for anchor: ARAnchor) {
        }
    }
    
    // MARK: Delegate PublishSubjects
    var nodeForAnchor: PublishRelay<(ARSKView, ARAnchor)> = PublishRelay<(ARSKView, ARAnchor)>()
    var didAddNodeForAnchor: PublishRelay<(ARSKView, SKNode, ARAnchor)> = PublishRelay<(ARSKView, SKNode, ARAnchor)>()
    var willUpdateNodeForAnchor: PublishRelay<(ARSKView, SKNode, ARAnchor)> = PublishRelay<(ARSKView, SKNode, ARAnchor)>()
    var didUpdateNodeForAnchor: PublishRelay<(ARSKView, SKNode, ARAnchor)> = PublishRelay<(ARSKView, SKNode, ARAnchor)>()
    var didRemoveNodeForAnchor: PublishRelay<(ARSKView, SKNode, ARAnchor)> = PublishRelay<(ARSKView, SKNode, ARAnchor)>()
    
    // MARK: ARSKViewDelegate
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        nodeForAnchor.accept((view, anchor))
        return (forwardToDelegate() ?? arskViewDelegateNotSet).view?(view, nodeFor: anchor)
    }
    
    func view(_ view: ARSKView, didAdd node: SKNode, for anchor: ARAnchor) {
        didAddNodeForAnchor.accept((view, node, anchor))
        forwardToDelegate()?.view?(view, didAdd: node, for: anchor)
    }
    
    func view(_ view: ARSKView, willUpdate node: SKNode, for anchor: ARAnchor) {
        willUpdateNodeForAnchor.accept((view, node, anchor))
        forwardToDelegate()?.view?(view, willUpdate: node, for: anchor)
    }
    
    func view(_ view: ARSKView, didUpdate node: SKNode, for anchor: ARAnchor) {
        didUpdateNodeForAnchor.accept((view, node, anchor))
        forwardToDelegate()?.view?(view, didUpdate: node, for: anchor)
    }
    
    func view(_ view: ARSKView, didRemove node: SKNode, for anchor: ARAnchor) {
        didRemoveNodeForAnchor.accept((view, node, anchor))
        forwardToDelegate()?.view?(view, didRemove: node, for: anchor)
    }
}

extension ARSKView: HasDelegate {
}
