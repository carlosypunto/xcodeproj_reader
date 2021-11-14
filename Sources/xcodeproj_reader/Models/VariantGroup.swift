//
//  VariantGroup.swift
//  xcodeproj_reader
//
//  Created by Carlos Garcia on 13/11/21.
//

struct VariantGroup: Element { // similar to group
    static let isa = "PBXVariantGroup"
    let id: String
    let children: [String] // ids
    let name: String
    let sourceTree: String

    init?(id: String, dict: [String:Any]) {
        guard
            let children = dict["children"] as? [String],
            let sourceTree = dict["sourceTree"] as? String,
            let name = dict["name"] as? String
        else { return nil }

        self.id = id
        self.children = children
        self.sourceTree = sourceTree
        self.name = name
    }
}
