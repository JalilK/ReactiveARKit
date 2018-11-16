//
//  ARSession+Rx.swift
//  Pods
//
//  Created by jalil.kennedy on 11/15/18.
//

import Foundation
import RxSwift
import RxCocoa
import ARKit

extension Reactive where Base: ARSession {
    public typealias DidUpdateFrameEvent = (ARSession, ARFrame)
    public typealias DidAddAnchorsEvent = (ARSession, [ARAnchor])
    public typealias DidUpdateAnchorsEvent = (ARSession, [ARAnchor])
    public typealias DidRemoveAnchorsEvent = (ARSession, [ARAnchor])
    
    /// Reactive wrapper for delegate method `didUpdateFrame`
    public var didUpdateFrame: ControlEvent<DidUpdateFrameEvent> {
        let source = RxARSessionDelegateProxy(parentObject: base).didUpdateFrame
        return ControlEvent(events: source)
    }
    
    /// Reactive wrapper for delegate method `didAddAnchors`
    public var didAddAnchors: ControlEvent<DidAddAnchorsEvent> {
        let source = RxARSessionDelegateProxy(parentObject: base).didAddAnchors
        return ControlEvent(events: source)
    }
    
    /// Reactive wrapper for delegate method `didUpdateAnchors`
    public var didUpdateAnchors: ControlEvent<DidUpdateAnchorsEvent> {
        let source = RxARSessionDelegateProxy(parentObject: base).didUpdateAnchors
        return ControlEvent(events: source)
    }
    
    /// Reactive wrapper for delegate method `didRemoveAnchors`
    public var didRemoveAnchors: ControlEvent<DidRemoveAnchorsEvent> {
        let source = RxARSessionDelegateProxy(parentObject: base).didRemoveAnchors
        return ControlEvent(events: source)
    }
}
