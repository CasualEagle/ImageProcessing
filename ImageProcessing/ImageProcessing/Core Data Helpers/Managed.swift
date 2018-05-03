//
//  Managed.swift
//  ImageProcessing
//
//  Created by Zstudent on 03/05/2018.
//  Copyright © 2018 ArtemOrlov. All rights reserved.
//

import CoreData

protocol Managed: class, NSFetchRequestResult {
    static var entityName: String { get }
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
}

extension Managed {

    static var sortedFetchRequest: NSFetchRequest<Self> {
        let request = NSFetchRequest<Self>(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
    }
}
