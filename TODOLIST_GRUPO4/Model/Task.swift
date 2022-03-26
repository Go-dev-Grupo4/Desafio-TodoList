//
//  Task.swift
//  TODOLIST_GRUPO4
//
//  Created by Matheus Lenke on 26/03/22.
//

import Foundation

struct Task: Codable {
    let id: UUID
    let title: String
    let description: String
    let completed: Bool
}
