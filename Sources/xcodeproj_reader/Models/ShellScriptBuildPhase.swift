//
//  ShellScriptBuildPhase.swift
//  xcodeproj_reader
//
//  Created by Carlos Garcia on 13/11/21.
//

struct ShellScriptBuildPhase: Element {
    static let isa = "PBXShellScriptBuildPhase"
    let id: String
    let inputPaths: [String]
    let outputPaths: [String]
    let files: [String]
    let inputFileListPaths: [String]
    let outputFileListPaths: [String]
    let shellScript: String
    let buildActionMask: String
    let name: String
    let runOnlyForDeploymentPostprocessing: String
    let shellPath: String
    let showEnvVarsInLog: String

    init?(id: String, dict: [String:Any]) {
        guard
            let inputPaths = dict["inputPaths"] as? [String],
            let outputPaths = dict["outputPaths"] as? [String],
            let files = dict["files"] as? [String],
            let inputFileListPaths = dict["inputFileListPaths"] as? [String],
            let outputFileListPaths = dict["outputFileListPaths"] as? [String],
            let shellScript = dict["shellScript"] as? String,
            let buildActionMask = dict["buildActionMask"] as? String,
            let name = dict["name"] as? String,
            let runOnlyForDeploymentPostprocessing = dict["runOnlyForDeploymentPostprocessing"] as? String,
            let shellPath = dict["shellPath"] as? String,
            let showEnvVarsInLog = dict["showEnvVarsInLog"] as? String
        else { return nil }

        self.id = id
        self.inputPaths = inputPaths
        self.outputPaths = outputPaths
        self.files = files
        self.inputFileListPaths = inputFileListPaths
        self.outputFileListPaths = outputFileListPaths
        self.shellScript = shellScript
        self.buildActionMask = buildActionMask
        self.name = name
        self.runOnlyForDeploymentPostprocessing = runOnlyForDeploymentPostprocessing
        self.shellPath = shellPath
        self.showEnvVarsInLog = showEnvVarsInLog
    }
}
