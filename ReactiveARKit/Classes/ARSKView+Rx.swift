//
//  ARSKView+Rx.swift
//  Pods-ReactiveARKit_Example
//
//  Created by jalil.kennedy on 11/14/18.
//

import Foundation
import ARKit
import RxSwift
import RxCocoa

extension Reactive where Base: ARSKView {
    public typealias DidAddNodeForAnchorEvent = (ARSKView, SKNode, ARAnchor)
    public typealias WillUpdateNodeForAnchorEvent = (ARSKView, SKNode, ARAnchor)
    public typealias DidUpdateNodeForAnchorEvent = (ARSKView, SKNode, ARAnchor)
    public typealias DidRemoveNodeForAnchorEvent = (ARSKView, SKNode, ARAnchor)

    /// Reactive wrapper for 'delegate'
    ///
    /// For more information take a look at `DelegateProxyType` protocol documentation.
    public var delegate: DelegateProxy<ARSKView, ARSKViewDelegate> {
        return RxARSKViewDelegateProxy.proxy(for: base)
    }
    
    /// Reactive wrapper for delegate method didAddNodeForAnchor
    public var didAddNodeForAnchor: ControlEvent<DidAddNodeForAnchorEvent> {
        let source = RxARSKViewDelegateProxy.proxy(for: base).didAddNodeForAnchor
        return ControlEvent(events: source)
    }
    
    /// Reactive wrapper for delegate method willUpdateNodeForAnchor
    public var willUpdateNodeForAnchor: ControlEvent<WillUpdateNodeForAnchorEvent> {
        let source = RxARSKViewDelegateProxy.proxy(for: base).willUpdateNodeForAnchor
        return ControlEvent(events: source)
    }
    
    /// Reactive wrapper for delegate method didUpdateNodeForAnchor
    public var didUpdateNodeForAnchor: ControlEvent<DidUpdateNodeForAnchorEvent> {
        let source = RxARSKViewDelegateProxy.proxy(for: base).didUpdateNodeForAnchor
        return ControlEvent(events: source)
    }
    
    /// Reactive wrapper for delegate method didRemoveNodeForAnchor
    public var didRemoveNodeForAnchor: ControlEvent<DidRemoveNodeForAnchorEvent> {
        let source = RxARSKViewDelegateProxy.proxy(for: base).didRemoveNodeForAnchor
        return ControlEvent(events: source)
    }
}
