//
//  ConfigurationList.swift
//  xcodeproj_reader
//
//  Created by Carlos Garcia on 13/11/21.
//

struct ConfigurationList: Element {
    static let isa = "XCConfigurationList"
    let id: String
    let buildConfigurations: [String] // ids
    let defaultConfigurationIsVisible: String
    let defaultConfigurationName: String

    init?(id: String, dict: [String:Any]) {
        guard
            let buildConfigurations = dict["buildConfigurations"] as? [String],
            let defaultConfigurationIsVisible = dict["defaultConfigurationIsVisible"] as? String,
            let defaultConfigurationName = dict["defaultConfigurationName"] as? String
        else { return nil }

        self.id = id
        self.buildConfigurations = buildConfigurations
        self.defaultConfigurationIsVisible = defaultConfigurationIsVisible
        self.defaultConfigurationName = defaultConfigurationName
    }
}
