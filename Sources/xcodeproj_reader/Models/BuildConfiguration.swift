//
//  BuildConfiguration.swift
//  xcodeproj_reader
//
//  Created by Carlos Garcia on 13/11/21.
//

struct BuildConfiguration: Element {
    static let isa = "XCBuildConfiguration"
    let id: String
    let buildSettings: [String:String]
    let baseConfigurationReference: String // id
    let name: String

    init?(id: String, dict: [String:Any]) {
        guard
            let buildSettings = dict["buildSettings"] as? [String:String],
            let baseConfigurationReference = dict["baseConfigurationReference"] as? String,
            let name = dict["name"] as? String
        else { return nil }

        self.id = id
        self.buildSettings = buildSettings
        self.baseConfigurationReference = baseConfigurationReference
        self.name = name
    }
}
