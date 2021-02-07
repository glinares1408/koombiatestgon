//
//  ProxyFile.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 7/02/21.
//

import Foundation
import UIKit

enum ProxyFileError: Error {
    case failedCreatingFile
    case failedConvertPath
    case failedWritingFile
    case noExist
}

typealias ProxyFileSaveImageCompletionClosure = (_ success: Bool, _ error: Error?) -> Void
typealias ProxyFileFetchImageCompletionClosure = (_ image: UIImage?,_ currentPath: String, _ error: Error?) -> Void

class ProxyFile {
    static let share = ProxyFile()
    
    let defaultFolder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first ?? URL(fileURLWithPath: String())
    
    func writeFileTo(path: String, data: Data, directory: String, completion: @escaping ProxyFileSaveImageCompletionClosure) {
        guard let customPath = path.convertToFilePath() else {
            completion(false, ProxyFileError.failedConvertPath)
            return
        }
        
        let folder = defaultFolder.appendingPathComponent(directory)
        
        if !FileManager.default.fileExists(atPath: folder.path) {
            try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true, attributes: nil)
        }
        
        let fileURL = folder.appendingPathComponent(customPath)
        
        guard let _ = try? data.write(to: fileURL) else {
            completion(false, ProxyFileError.failedWritingFile)
            return
        }
        
        completion(true, nil)
        
    }
    
    func readFileFrom(path: String, directory: String, completion: @escaping ProxyFileFetchImageCompletionClosure) {
        guard let customPath = path.convertToFilePath() else {
            completion(nil, path, ProxyFileError.failedConvertPath)
            return
        }
        
        let folder = defaultFolder.appendingPathComponent(directory)
        let fileURL = folder.appendingPathComponent(customPath)
        
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            completion(nil, path, ProxyFileError.noExist)
            return
        }
        
        let image = UIImage(contentsOfFile: fileURL.relativePath)
        
        completion(image, path, nil)
    }
}
