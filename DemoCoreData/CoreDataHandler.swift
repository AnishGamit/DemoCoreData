//
//  CoreDataHandler.swift
//  DemoCoreData
//
//  Created by DCS on 17/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//
import UIKit
import Foundation
import  CoreData

class coredatahandler {
    static let shared = coredatahandler()
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    let manageOnjectContext:NSManagedObjectContext?
    
    private init(){
        manageOnjectContext = appdelegate.persistentContainer.viewContext
    }
    
    func save(){
        appdelegate.saveContext()
    }
    func insert(name:String,age:Int,phone:String,completion: @escaping() -> Void ){
        let emp = Employee(context:manageOnjectContext!)
        
        emp.ename = name
        emp.age = Int32(Int64(age))
        emp.phone = phone
        
        save()
        completion()
    }
    func update(emp:Employee,ename:String,age:Int,phone:String,completion: @escaping() -> Void ){
        emp.ename = ename
        emp.age = Int32(Int64(age))
        emp.phone = phone
        
        save()
        completion()
    }
    
    func delete(emp:Employee,completion: @escaping() -> Void ){
        manageOnjectContext!.delete(emp)
        
        save()
        completion()
    }
    
    func fetch() -> [Employee]{
        let FetchRequest:NSFetchRequest<Employee> = Employee.fetchRequest()
        do{
            let empArray = try manageOnjectContext?.fetch(FetchRequest)
            return empArray!
        }catch{
            print(error)
            return [Employee]()
        }
    }
}
