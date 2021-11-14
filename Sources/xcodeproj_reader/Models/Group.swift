//
//  Group.swift
//  xcodeproj_reader
//
//  Created by Carlos Garcia on 12/11/21.
//

/*
sourceTree

"\"<group>\""
"SOURCE_ROOT"
*/

struct Group: Element {
    static let isa = "PBXGroup"
    let id: String
    let children: [String] // ids
    let sourceTree: String
    let path: String?
    let name: String?

    init?(id: String, dict: [String:Any]) {
        guard
            let children = dict["children"] as? [String],
            let sourceTree = dict["sourceTree"] as? String
        else { return nil }

        self.id = id
        self.children = children
        self.sourceTree = sourceTree
        self.path = dict["path"] as? String
        self.name = dict["name"] as? String
    }
}
