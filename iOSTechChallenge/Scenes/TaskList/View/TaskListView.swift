//
//  TaskListView.swift
//  iOSTechChallenge
//
//  Created by Raphael Pedrini on 26/02/2021.
//

import SwiftUI

struct TaskListView: View {
    
    @ObservedObject var viewModel = TaskListViewModel(service: TaskListService())
    
    var body: some View {
        
        NavigationView {
            ZStack {
                VStack {
                    List(viewModel.filteredList) { task in
                        HStack {
                            Image(task.type).padding()
                            VStack (alignment: .leading, spacing: 5) {
                                Text(task.name)
                                    .fontWeight(.bold)
                                Text(task.description)
                                    .fontWeight(.light)
                            }
                        }.padding()
                    }.accessibility(identifier: "taskList")
                    HStack(spacing: 15) {
                        ForEach(0..<viewModel.taskTypes.count) { index in
                            Button(action: {
                                viewModel.toggleFilter(viewModel.taskTypes[index])
                            }) {
                                Image(viewModel.taskTypes[index].rawValue)
                            }.frame(width: 30, height: 30, alignment: .center).scaledToFill()
                            .accessibility(identifier: viewModel.taskTypes[index].rawValue)
                        }
                    }.frame(height: 100)
                }.navigationBarTitle("Tasks", displayMode: .inline)
                VStack {
                    Text("YOU ARE OFFLINE")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(Color.red)
                        .isHidden(viewModel.isOnline ?? true)
                        .accessibility(identifier: "offlineBanner")
                    Spacer()
                }
            }
        }
    }
}
