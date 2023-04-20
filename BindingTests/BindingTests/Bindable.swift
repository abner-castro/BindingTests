//
//  Bindable.swift
//  BindingTests
//
//  Created by Abner Castro on 20/04/23.
//

import Foundation

protocol Bindable {
    associatedtype Binder
    var value: Binder? { get set }
    var listener: ((Binder?) -> Void)? { get set }
    
    mutating func onNext(_ value: Binder?)
    mutating func changeBind(_ value: Binder?)
    mutating func bind(_ listener: @escaping (Binder?) -> Void)
}
