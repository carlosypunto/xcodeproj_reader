//
//  ContainerItemProxy.swift
//  xcodeproj_reader
//
//  Created by Carlos Garcia on 12/11/21.
//

struct ContainerItemProxy: Element {
    static let isa = "PBXContainerItemProxy"
    let id: String
    let containerPortal: String // id
    let proxyType: String
    let remoteGlobalIDString: String // id
    let remoteInfo: String

    init?(id: String, dict: [String:Any]) {
        guard
            let containerPortal = dict["containerPortal"] as? String,
            let proxyType = dict["proxyType"] as? String,
            let remoteGlobalIDString = dict["remoteGlobalIDString"] as? String,
            let remoteInfo = dict["remoteInfo"] as? String
        else { return nil }

        self.id = id
        self.containerPortal = containerPortal
        self.proxyType = proxyType
        self.remoteGlobalIDString = remoteGlobalIDString
        self.remoteInfo = remoteInfo
    }
}
