//
//  TargetDependency.swift
//  xcodeproj_reader
//
//  Created by Carlos Garcia on 13/11/21.
//

struct TargetDependency: Element {
    static let isa = "PBXTargetDependency"
    let id: String
    let target: String // id
    let targetProxy: String // id

    init?(id: String, dict: [String:Any]) {
        guard
            let target = dict["target"] as? String,
            let targetProxy = dict["targetProxy"] as? String
        else { return nil }

        self.id = id
        self.target = target
        self.targetProxy = targetProxy
    }
}
