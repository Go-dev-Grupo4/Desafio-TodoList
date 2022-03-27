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
    
    
    static func getData() -> [Task] {
        let tasks: [Task] = [
            Task(id: UUID(), title: "Tarefa 1", description: "Descrição da tarefa. Fazer tal coisa, também outra coisa, ver aquilo ali que falta, esse tipo de coisa", completed: false),
            Task(id: UUID(), title: "Tarefa 2", description: "Descrição da tarefa. Fazer tal coisa, também outra coisa, ver aquilo ali que falta, esse tipo de coisa", completed: false),
            Task(id: UUID(), title: "Tarefa 3", description: "Descrição da tarefa. Fazer tal coisa, também outra coisa, ver aquilo ali que falta, esse tipo de coisa", completed: false),
            Task(id: UUID(), title: "Tarefa 4", description: "Descrição da tarefa. Fazer tal coisa, também outra coisa, ver aquilo ali que falta, esse tipo de coisa", completed: false),
            Task(id: UUID(), title: "Tarefa 5", description: "Descrição da tarefa. Fazer tal coisa, também outra coisa, ver aquilo ali que falta, esse tipo de coisa", completed: false),
            Task(id: UUID(), title: "Tarefa 6", description: "Descrição da tarefa. Fazer tal coisa, também outra coisa, ver aquilo ali que falta, esse tipo de coisa", completed: false),
            Task(id: UUID(), title: "Tarefa 7", description: "Descrição da tarefa. Fazer tal coisa, também outra coisa, ver aquilo ali que falta, esse tipo de coisa", completed: false)
        ]
        return tasks
    }
}


