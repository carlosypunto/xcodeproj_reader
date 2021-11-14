//
//  Container.swift
//  xcodeproj_reader
//
//  Created by Carlos Garcia on 14/11/21.
//

import Foundation

class Container {
    private var buildFiles: Set<BuildFile> = []
    private var containerItemProxys: Set<ContainerItemProxy> = []
    private var fileReferences: Set<FileReference> = []
    private var resourcesBuildPhases: Set<ResourcesBuildPhase> = []
    private var frameworksBuildPhases: Set<FrameworksBuildPhase> = []
    private var groups: Set<Group> = []
    private var nativeTargets: Set<NativeTarget> = []
    private var projects: Set<Project> = []
    private var shellScriptBuildPhases: Set<ShellScriptBuildPhase> = []
    private var sourcesBuildPhases: Set<SourcesBuildPhase> = []
    private var targetDependencys: Set<TargetDependency> = []
    private var variantGroups: Set<VariantGroup> = []
    private var buildConfigurations: Set<BuildConfiguration> = []
    private var configurationLists: Set<ConfigurationList> = []
    private var typeOf: [String:String] = [:]
    private var fileReferencePaths: [String:String] = [:]
    private var project: Project!

    private func printType(of id: String) {
        guard let type = typeOf[id] else { return }
        print(type)
    }

    let projPath: String
    let projectDirectoryPath: String
    var pbxPath: String {
        "\(projPath)/project.pbxproj"
    }

    init(xcodeprojPath: String) {
        let url = URL(fileURLWithPath: xcodeprojPath)
        projPath = url.path
        projectDirectoryPath = url.deletingLastPathComponent().path
        extract()
    }

    private func extract() {
        guard
            let dictionary = NSDictionary(contentsOfFile: pbxPath)
        else { print("Unable to get dictionary from path"); exit(-1) }

        guard
            let objects = dictionary["objects"] else { exit(0) }
        guard
            let objectsDictionary = objects as? [String: [String: Any]] else { exit(0) }
        extractObjects(objectsDictionary: objectsDictionary)

        guard
            let project = projects.first
        else { print("Project do not exist in xcodeproj"); exit(-1) }
        self.project = project
        extract(project: project)
    }

    private func extract(project: Project) {
        extractGroups(mainGroupId: project.mainGroup)
        extractProducts(productGroupId: project.productRefGroup)
        extractBuidConfiguration(buidConfigurationId: project.buildConfigurationList)
    }

    private func extractGroups(mainGroupId: String) {
        if let mainGroup = groups.first(where: { $0.id == mainGroupId }) {
            _ = Node.create(group: mainGroup, parent: nil, inContainer: self)
        }
    }

    func group(withId id: String) -> Group? {
        groups.first(where: { $0.id == id })
    }

    func fileReference(withId id: String) -> FileReference? {
        fileReferences.first(where: { $0.id == id })
    }

    private func extractProducts(productGroupId: String) {
    }

    private func extractBuidConfiguration(buidConfigurationId: String) {
    }

    private func extractObjects(objectsDictionary: [String: [String: Any]]) {
        for dictKey in objectsDictionary.keys {
            let key = String(dictKey)

            guard
                let object = objectsDictionary[dictKey],
                let isa = object["isa"] as? String
            else { continue }

            typeOf[key] = isa

            switch isa {
            case "PBXBuildFile":
                if let buildFile = BuildFile(id: key, dict: object) {
                    buildFiles.insert(buildFile)
                }
            case "PBXContainerItemProxy":
                if let containerItemProxy = ContainerItemProxy(id: key, dict: object) {
                    containerItemProxys.insert(containerItemProxy)
                }
            case "PBXFileReference":
                if let fileReference = FileReference(id: key, dict: object) {
                    fileReferences.insert(fileReference)
                }
            case "PBXResourcesBuildPhase":
                if let resourcesBuildPhase = ResourcesBuildPhase(id: key, dict: object) {
                    resourcesBuildPhases.insert(resourcesBuildPhase)
                }
            case "PBXFrameworksBuildPhase":
                if let frameworksBuildPhase = FrameworksBuildPhase(id: key, dict: object) {
                    frameworksBuildPhases.insert(frameworksBuildPhase)
                }
            case "PBXGroup":
                if let group = Group(id: key, dict: object) {
                    groups.insert(group)
                }
            case "PBXNativeTarget":
                if let nativeTarget = NativeTarget(id: key, dict: object) {
                    nativeTargets.insert(nativeTarget)
                }
            case "PBXProject":
                if let project = Project(id: key, dict: object) {
                    projects.insert(project)
                }
            case "PBXShellScriptBuildPhase":
                if let shellScriptBuildPhase = ShellScriptBuildPhase(id: key, dict: object) {
                    shellScriptBuildPhases.insert(shellScriptBuildPhase)
                }
            case "PBXSourcesBuildPhase":
                if let sourcesBuildPhase = SourcesBuildPhase(id: key, dict: object) {
                    sourcesBuildPhases.insert(sourcesBuildPhase)
                }
            case "PBXTargetDependency":
                if let targetDependency = TargetDependency(id: key, dict: object) {
                    targetDependencys.insert(targetDependency)
                }
            case "PBXVariantGroup":
                if let variantGroup = VariantGroup(id: key, dict: object) {
                    variantGroups.insert(variantGroup)
                }
            case "XCBuildConfiguration":
                if let buildConfiguration = BuildConfiguration(id: key, dict: object) {
                    buildConfigurations.insert(buildConfiguration)
                }
            case "XCConfigurationList":
                if let configurationList = ConfigurationList(id: key, dict: object) {
                    configurationLists.insert(configurationList)
                }
            default: continue
            }
        }

    }

    func filePathsOfTarget(_ name: String) -> [String] {
        fileReferencesOfTarget(name).map(\.id).compactMap { fileReferencePaths[$0] }
    }

    private func fileReferencesOfTarget(_ name: String) -> [FileReference] {
        guard let target = getTarget(withName: name)
        else { print("Target \(name) not found in xcodeproj"); exit(-1) }

        guard let buildPhase = getSourcesBuildPhase(from: target)
        else { print("Sources BuildPhase for target \(name) do not found in xcodeproj"); exit(-1) }

        let filesOfTarget = buildFiles.filter { buildPhase.files.contains($0.id) }
        let fileReferencesIdsOfTarget = filesOfTarget.compactMap(\.fileRef)
        let fileReferencesOfTarget = fileReferences
            .filter { fileReferencesIdsOfTarget.contains($0.id) }
        return Array(fileReferencesOfTarget)
    }

    private func getTarget(withName name: String) -> NativeTarget? {
        var searchedTarget: NativeTarget?
        project.targets.forEach { id in
            guard let target = nativeTargets.first(where: { $0.id == id }) else { return }
            if target.name == name { searchedTarget = target }
        }
        return searchedTarget
    }

    private func getSourcesBuildPhase(from target: NativeTarget) -> SourcesBuildPhase? {
        Array(sourcesBuildPhases.filter { target.buildPhases.contains($0.id) }).first
    }

    fileprivate func addPath(path: String, forFileReferenceId id: String) {
        fileReferencePaths[id] = "'\(projectDirectoryPath)\(path)'"
    }
}

class Node {
    let isa: String
    let id: String
    let path: String?
    let name: String?
    let fileReference: FileReference?
    var children: [Node] = []
    private(set) weak var parent: Node?

    init(isa: String, id: String, path: String?, name: String?, fileReference: FileReference?, parent: Node?) {
        self.isa = isa
        self.id = id
        self.path = path
        self.name = name
        self.fileReference = fileReference
        self.parent = parent
    }

    func add(child: Node) {
        children.append(child)
        child.parent = self
    }
}

extension Node {
    var computedPath: String {
        if let parentPath = parent?.computedPath {
            if let currentPath = path {
                return "\(parentPath)/\(currentPath)"
            } else {
                return parentPath
            }
        } else {
            return path ?? ""
        }
    }
}

extension Node {
    static func create(group: Group, parent: Node?, inContainer container: Container) -> Node {
        let node = Node(isa: Group.isa, id: group.id, path: group.path, name: group.name, fileReference: nil, parent: parent)
        group.children.forEach { childId in
            if let groupChild = container.group(withId: childId) {
                let groupNode = Node.create(group: groupChild, parent: node, inContainer: container)
                node.add(child: groupNode)
            } else if let fileReferenceChild = container.fileReference(withId: childId) {
                let fileReferenceNode = Node.create(fileReference: fileReferenceChild, parent: node, inContainer: container)
                node.add(child: fileReferenceNode)
                container.addPath(path: fileReferenceNode.computedPath, forFileReferenceId: fileReferenceChild.id)
            }
        }
        return node
    }

    static func create(fileReference: FileReference, parent: Node?, inContainer: Container) -> Node {
        let node = Node(isa: FileReference.isa, id: fileReference.id, path: fileReference.path, name: fileReference.name, fileReference: fileReference, parent: parent)
        return node
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        var text = "\(id)"
        if !children.isEmpty {
            text += " {" + children.map { $0.description }.joined(separator: ", ") + "} "
        }
        return text
    }
}
