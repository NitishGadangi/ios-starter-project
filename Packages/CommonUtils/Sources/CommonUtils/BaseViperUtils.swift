//
//  File.swift
//  
//
//  Created by Nitish Gadangi on 09/07/24.
//

import Foundation
import UIKit

public protocol VIPERBaseBuilder {
    static func build() -> UIViewController
}

public protocol ViewModellable {
    associatedtype DataModel

    var model: DataModel { get }

    init(model: DataModel)

    //associatedtype Input
    //associatedtype Output
    // we can declare Inputs, Outputs as well here as params of transform func
    // which encapsulates UIInteractions that can be transformed to Outputs
    // func transform(input: Input) -> Output
}

// Example implementation
public class DummyViewModel: ViewModellable {
    public typealias DataModel = Void
    public let model: Void
    required public init(model: Void) {
        self.model = model
    }
}
