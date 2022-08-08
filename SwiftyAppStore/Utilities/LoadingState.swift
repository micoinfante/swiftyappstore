//
//  LoadingState.swift
//  SwiftyAppStore
//
//  Created by Mico Infante on 8/7/22.
//

import Foundation
import Combine

enum LoadingState<T> {
    case idle
    case loading
    case failed(Error)
    case loaded(T)
}

protocol LoadableObject: ObservableObject {
    associatedtype Output
    var state: LoadingState<Output> { get }
}
