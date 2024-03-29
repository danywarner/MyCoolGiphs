//
//  StorageManager.swift
//  MyCoolGiphs
//
//  Created by daniel.warner on 22/02/22.
//

import Foundation

final class StorageManager {
    
    fileprivate let filemanager: FileManager = FileManager.default;
    
    fileprivate func filePath(forKey key: String) -> URL? {
        guard let docURL = filemanager.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first else {
            return nil;
        }
        
        return docURL.appendingPathComponent(key);
    }
    
    func writeToStorage(identifier: String, object: GiphEntity, completion: @escaping () -> ()) {
        guard let path = filePath(forKey: identifier) else {
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(object) {
                do {
                    try data.write(to: path)
                    DispatchQueue.main.async {
                        completion()
                    }
                } catch {
                    print("ERROR writing")
                }
            }
        }
    }
    
    func deleteFavoriteFromStorage(identifier: String, completion: @escaping () -> ()) {
        guard let path = filePath(forKey: identifier) else {
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            do {
                try self?.filemanager.removeItem(at: path)
                DispatchQueue.main.async {
                    completion()
                }
            } catch {
                print("ERROR deleting favorite")
            }
        }
    }
    
    func readFromStorage(identifier: String) -> GiphEntity? {
        guard let url = filePath(forKey: identifier) else {
            return nil
        }
        
        do {
            let data = try Data.init(contentsOf: url)
            let decoder = JSONDecoder()
            let entity = try decoder.decode(GiphEntity.self, from: data)
            return entity
        } catch {
            print("ERROR reading")
        }
        return nil
    }
    
    func readAllFromStorage() throws -> [URL] {
        let docsURL = filemanager.urls(for: .documentDirectory, in: .userDomainMask)[0];
        
        do {
            let fileURLs = try filemanager.contentsOfDirectory(at: docsURL, includingPropertiesForKeys: nil);
            
            return fileURLs;
        } catch {
            return []
        }
    }
    
    func getFavoriteGifsFromStorage() -> [GiphEntity] {
        do {
            let fileURLS = try readAllFromStorage()
            let favoriteIds = fileURLS.map { $0.lastPathComponent }
            let favoriteGifs = favoriteIds.compactMap { favoriteId in
                return readFromStorage(identifier: favoriteId)
            }
            return favoriteGifs
        } catch {
            print("NO FILES IN STORAGE")
        }
        return []
    }
}
