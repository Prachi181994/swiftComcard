//
//  DBManager.swift
//  SwiftComcard
//
//  Created by Andesoft on 24/01/17.
//  Copyright © 2017 Andesoft. All rights reserved.
//

import UIKit

class DBManager: NSObject {
    
    
    var databasePath = String()
    var database: FMDatabase!
    
    override init() {
        super.init()
        
        databasePath = prepareDatabaseFile()
        database = FMDatabase(path: databasePath)
        
        
    }
    
    
    func prepareDatabaseFile() -> String{
        
        
        let bundlePath = Bundle.main.path(forResource: "AlesiaPhotoEditor", ofType: ".db")
        let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        let fullDestPath = URL(fileURLWithPath: destPath).appendingPathComponent("AlesiaPhotoEditor.db")
        if fileManager.fileExists(atPath: fullDestPath.path){
            print("Database file is exist")
            print(fileManager.fileExists(atPath: bundlePath!))
            
        }else{
            do{
                try fileManager.copyItem(atPath: bundlePath!, toPath: fullDestPath.path)
                
            }catch{
                print("\n",error)
            }
            
            
        }
        return fullDestPath.path
        
        
    }
    
    
    
    
    func openDatabase() -> Bool {
        if database == nil {
            if FileManager.default.fileExists(atPath: databasePath) {
                database = FMDatabase(path: databasePath)
            }
        }
        
        if database != nil {
            if database.open() {
                return true
            }
        }
        
        return false
    }
    
    func saveData(insertSQL:String) -> Bool{
        // insert update
        if openDatabase() {
            
           // let InsertQry = ""
            let result = database.executeUpdate(insertSQL, withArgumentsIn: nil)
            if !result {
                print(database.lastErrorMessage())
                return false
            }
            else
            {
                print("Success")
                
            }
            
            database.close()
            
        }
        return true
    }
    
    
    func queryExecute(sqlQuery:String) -> NSMutableArray{
        
        let resultArray:NSMutableArray = NSMutableArray()
        
        if openDatabase() {
            
          
            
            do {
                print(database)
                
                let results:FMResultSet  = try database.executeQuery(sqlQuery, values: nil)
                
                while results.next() {
                    
                    resultArray.addObjects(from:[results.resultDictionary()])
                    
                    
                }
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return resultArray
    }
    
}
