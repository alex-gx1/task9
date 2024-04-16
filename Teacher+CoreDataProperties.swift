//
//  Teacher+CoreDataProperties.swift
//  task9
//
//  Created by Алексей Кононенко on 16.04.24.
//
//

import Foundation
import CoreData


@objc(Teacher)
public class Teacher: NSManagedObject {

}

extension Teacher {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Teacher> {
        return NSFetchRequest<Teacher>(entityName: "Teacher")
    }

    @NSManaged public var name: String?
    @NSManaged public var lastName: String?
    @NSManaged public var student: Student?

}

extension Teacher : Identifiable {

}
