//
//  main.swift
//  xcodeproj_reader
//
//  Created by Carlos Garcia on 12/11/21.
//

import Foundation
import ArgumentParser

struct Command: ParsableCommand {
    @Argument(help: "The xcodeproj to read.")
    var xcodeproj: String

    @Option(name: .shortAndLong, help: "The target where search paths.")
    var target: String
}

let options = Command.parseOrExit()
guard options.xcodeproj.hasSuffix("xcodeproj") else { print("Wrong xcodeproj path provided"); exit(-1) }

let container = Container(xcodeprojPath: options.xcodeproj)
let filePaths = container.filePathsOfTarget(options.target)
filePaths.forEach { print($0) }
