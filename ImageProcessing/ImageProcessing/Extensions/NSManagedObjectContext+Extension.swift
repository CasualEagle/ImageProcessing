//
//  NSManagedObjectContext+Extension.swift
//  ImageProcessing
//
//  Created by Zstudent on 03/05/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {

    func saveOrRollback() {
        do {
            try save()
        } catch {
            rollback()
        }
    }

    func performChanges(block: @escaping () -> ()) {
        perform {
            block()
            self.saveOrRollback()
        }
    }
}
