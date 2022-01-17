//
//  WARealmManager.swift
//  popularMovieMVVM
//
//  Created by Tayseer Anwar on 1/16/22.
//

import Foundation
import Realm
import RealmSwift

class WARealmManager: NSObject {
    // MARK: - property
    static let shared = WARealmManager()
    private let realm = try? Realm()
    //MARK: Realm CRUDs
    /*
     Saves an object or an array of objects to realm with update, object type needs to have a primary key.
     */
    func saveWithUpdate(model : Object) {
        do {
            try realm?.write {
                realm?.add(model, update: .modified)
            }
        }catch{
            
        }
    }
    
    func saveWithUpdateArr(model : [Object]) {
        do {
            try realm?.write {
                realm?.add(model, update: .all)
            }
        }catch{
            
        }
    }
    
    /*
    deletes an object or an array of objects in realm
    */
    func deleteAllinTable(model : Object) {
        do {
//            print(realm?.configuration.fileURL as Any)
            try realm?.write {
                realm?.delete(model)
            }
        }catch{
            
        }
    }
    
    func deleteAllinTableArr(model : [Object]) {
        do {
            try realm?.write {
                realm?.delete(model)
            }
        }catch{
            
        }
    }
    
    //MARK: CRUD Movies
    func getMovies() -> [Movie]{
        if let results = self.realm?.objects(Movie.self) {
            return Array(results)
        }
        return []
    }
    
    func createMoviesTable(movieArray:[Movie]) {
        self.saveWithUpdateArr(model: movieArray)
    }
}
