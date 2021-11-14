//
//  BuildFile.swift
//  xcodeproj_reader
//
//  Created by Carlos Garcia on 12/11/21.
//

struct BuildFile: Element {
    static let isa = "PBXBuildFile"
    let id: String
    let fileRef: String? // id

    init?(id: String, dict: [String:Any]) {
        self.id = id
        fileRef = dict["fileRef"] as? String
    }
}
