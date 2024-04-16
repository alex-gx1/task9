import Foundation
import CoreData
import UIKit

public final class StorageManager: NSObject {
    public static let shared = StorageManager()
    private override init() {}
    
    private var appDelegate: AppDelegate {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unable to access AppDelegate")
        }
        return delegate
    }
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    public func getTeacherName(for student: Student) -> String? {
        guard let teacher = student.teacher else {
            print("Student has no assigned teacher")
            return nil
        }
        return teacher.name
    }
    public func fetchStudents(for teacher: Teacher) -> [Student]? {
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "teacher == %@", teacher)
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching students: \(error)")
            return nil
        }
    }
    public func addStudentToTeacher(_ student: Student, teacher: Teacher) {
        teacher.student = student
        appDelegate.saveContext()
    }
    public func addTeacher(_ name: String?, lastname: String?, student: Student) {
        guard let teacherEntityDescription = NSEntityDescription.entity(forEntityName: "Teacher", in: context) else { return }
        let teacher = Teacher(entity: teacherEntityDescription, insertInto: context)
        teacher.name = name
        teacher.lastName = lastname
        teacher.student = student
        appDelegate.saveContext()
    }
    public func addTeacher(_ name: String?, lastname: String?) {
        guard let teacherEntityDescription = NSEntityDescription.entity(forEntityName: "Teacher", in: context) else { return }
        let teacher = Teacher(entity: teacherEntityDescription, insertInto: context)
        teacher.name = name
        teacher.lastName = lastname
        appDelegate.saveContext()
    }
    public func fetchTeachers() -> [Teacher]? {
        let fetchRequest = NSFetchRequest<Teacher>(entityName: "Teacher")
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching notes: \(error)")
            return nil
        }
    }
    public func fetchTeacher(with name: String?) -> Teacher? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Teacher")
        do {
            guard let teachers = try? context.fetch(fetchRequest) as? [Teacher] else { return nil }
            return teachers.first(where: { $0.name == name})
        }
    }
    public func addStudent(_ studentName: String?, studentAge: Int16) {
        guard let studentEntityDescription = NSEntityDescription.entity(forEntityName: "Student", in: context) else { return }
        let student = Student(entity: studentEntityDescription, insertInto: context)
        student.studentName = studentName
        student.studentAge = studentAge
        appDelegate.saveContext()
    }
    public func fetchStudents() -> [Student]? {
        let fetchRequest = NSFetchRequest<Student>(entityName: "Student")
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching notes: \(error)")
            return nil
        }
    }
    public func fetchStudent(with studentName: String?) -> Student? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        do {
            guard let students = try? context.fetch(fetchRequest) as? [Student] else { return nil }
            return students.first(where: { $0.studentName == studentName})
        }
    }
}
