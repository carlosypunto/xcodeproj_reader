//
//  FileReference.swift
//  xcodeproj_reader
//
//  Created by Carlos Garcia on 12/11/21.
//

/*
sourceTree

"\"<group>\""
"BUILT_PRODUCTS_DIR"
"SOURCE_ROOT"
"SDKROOT"
*/


/*
 lastKnownFileType

text.xcconfig
sourcecode.swift
image.jpeg
file.storyboard
text.plist.xml
folder.assetcatalog
file.xib
text.json
audio.mp3
file
folder.skatlas
text.plist.entitlements
text.plist.strings
wrapper.framework
sourcecode.c.h
net.daringfireball.markdown
net.daringfireball.markdown
text.plist.stringsdict
 */

/*
fileEncoding

4
*/

/*
 includeInIndex

0
1
*/

/*
 wrapsLines

0
*/

/*
 explicitFileType

wrapper.application; 7
wrapper.framework; 9
wrapper.cfbundle; 2
*/

struct FileReference: Element {
    static let isa = "PBXFileReference"
    let id: String
    let sourceTree: String
    let path: String
    let lastKnownFileType: String?
    let fileEncoding: String?
    let includeInIndex: String?
    let explicitFileType: String?
    let name: String?
    let wrapsLines: String?

    init?(id: String, dict: [String:Any]) {
        guard
            let sourceTree = dict["sourceTree"] as? String,
            let path = dict["path"] as? String
        else { return nil }

        self.id = id
        self.sourceTree = sourceTree
        self.path = path
        self.lastKnownFileType = dict["lastKnownFileType"] as? String
        self.fileEncoding = dict["fileEncoding"] as? String
        self.includeInIndex = dict["includeInIndex"] as? String
        self.explicitFileType = dict["explicitFileType"] as? String
        self.name = dict["name"] as? String
        self.wrapsLines = dict["wrapsLines"] as? String
    }
}
