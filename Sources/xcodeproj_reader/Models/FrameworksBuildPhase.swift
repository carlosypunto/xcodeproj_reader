//
//  FrameworksBuildPhase.swift
//  xcodeproj_reader
//
//  Created by Carlos Garcia on 12/11/21.
//

struct FrameworksBuildPhase: Element {
    static let isa = "PBXFrameworksBuildPhase"
    let id: String
    let files: [String] // ids
    let buildActionMask: String
    let runOnlyForDeploymentPostprocessing: String

    init?(id: String, dict: [String:Any]) {
        guard
            let files = dict["files"] as? [String],
            let buildActionMask = dict["buildActionMask"] as? String,
            let runOnlyForDeploymentPostprocessing = dict["runOnlyForDeploymentPostprocessing"] as? String
        else { return nil }

        self.id = id
        self.files = files
        self.buildActionMask = buildActionMask
        self.runOnlyForDeploymentPostprocessing = runOnlyForDeploymentPostprocessing
    }
}
