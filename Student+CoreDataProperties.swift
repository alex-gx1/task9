//
//  Student+CoreDataProperties.swift
//  task9
//
//  Created by Алексей Кононенко on 16.04.24.
//
//

import Foundation
import CoreData

@objc(Student)
public class Student: NSManagedObject {

}

extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var studentName: String?
    @NSManaged public var studentAge: Int16
    @NSManaged public var teacher: Teacher?

}

extension Student : Identifiable {

}
