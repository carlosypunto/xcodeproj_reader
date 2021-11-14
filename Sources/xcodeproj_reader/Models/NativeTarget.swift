//
//  NativeTarget.swift
//  xcodeproj_reader
//
//  Created by Carlos Garcia on 12/11/21.
//

/*
sourceTree

"\"<group>\""
"SOURCE_ROOT"
*/

/*
 productType

"com.apple.product-type.application"
"com.apple.product-type.bundle.unit-test"
*/

struct NativeTarget: Element {
    static let isa = "PBXNativeTarget"
    let id: String
    let buildPhases: [String] // ids
    let dependencies: [String] // ids
    let buildRules: [String] // ids
    let buildConfigurationList: String // id
    let name: String
    let productName: String
    let productReference: String // id
    let productType: String

    init?(id: String, dict: [String:Any]) {
        guard
            let buildPhases = dict["buildPhases"] as? [String],
            let dependencies = dict["dependencies"] as? [String],
            let buildRules = dict["buildRules"] as? [String],
            let buildConfigurationList = dict["buildConfigurationList"] as? String,
            let name = dict["name"] as? String,
            let productName = dict["productName"] as? String,
            let productReference = dict["productReference"] as? String,
            let productType = dict["productType"] as? String
        else { return nil }

        self.id = id
        self.buildPhases = buildPhases
        self.dependencies = dependencies
        self.buildRules = buildRules
        self.buildConfigurationList = buildConfigurationList
        self.name = name
        self.productName = productName
        self.productReference = productReference
        self.productType = productType
    }
}
