//
//  Project.swift
//  xcodeproj_reader
//
//  Created by Carlos Garcia on 12/11/21.
//

/*
typealias TargetAttributesType = [String:[TargetAttributePosibleKey:Any]]

TargetAttributePosibleKey -> Type
    let ProvisioningStyle: String
    let SystemCapabilities: [String:[String:String]]?
    let CreatedOnToolsVersion: String?
    let LastSwiftMigration: String?
    let TestTargetID: String? // id
}

ProjectAttributePosibleKey -> Type
    let LastSwiftUpdateCheck: String
    let LastUpgradeCheck: String
    let TargetAttributes: [String:[TargetAttributePosibleKey:Any]]
}
*/

struct Project: Element {
    static let isa = "PBXProject"
    let id: String
//    let attributes: [String:Any] // ProjectAttributePosibleKey:Any
    let knownRegions: [String] // en, es, pt, Base
    let targets: [String] // ids
    let buildConfigurationList: String // id
    let mainGroup: String // id
    let productRefGroup: String // id
    let compatibilityVersion: String
    let developmentRegion: String
    let hasScannedForEncodings: String
    let projectDirPath: String
    let projectRoot: String

    init?(id: String, dict: [String:Any]) {
        guard
            let knownRegions = dict["knownRegions"] as? [String],
            let targets = dict["targets"] as? [String],
            let buildConfigurationList = dict["buildConfigurationList"] as? String,
            let mainGroup = dict["mainGroup"] as? String,
            let productRefGroup = dict["productRefGroup"] as? String,
            let compatibilityVersion = dict["compatibilityVersion"] as? String,
            let developmentRegion = dict["developmentRegion"] as? String,
            let hasScannedForEncodings = dict["hasScannedForEncodings"] as? String,
            let projectDirPath = dict["projectDirPath"] as? String,
            let projectRoot = dict["projectRoot"] as? String
        else { return nil }

        self.id = id
        self.knownRegions = knownRegions
        self.targets = targets
        self.buildConfigurationList = buildConfigurationList
        self.mainGroup = mainGroup
        self.productRefGroup = productRefGroup
        self.compatibilityVersion = compatibilityVersion
        self.developmentRegion = developmentRegion
        self.hasScannedForEncodings = hasScannedForEncodings
        self.projectDirPath = projectDirPath
        self.projectRoot = projectRoot
    }
}
