//
//  CreateView.swift
//  SwiftUIWithMVVMHomeAssistantExmple
//
//  Created by zuri cohen on 12/9/22.
//

import SwiftUI

struct CreateView: View {
    
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?
    @StateObject private var vm = CreateViewModel()
    let successfulAction: () -> Void
    
    var body: some View {
        
        NavigationView {
            
            Form {
                Section {
                    fistname
                    lastname
                    job
                } footer: {
                    if case .validation(let err) = vm.error,
                       let errorDesc = err.errorDescription {
                        Text(errorDesc)
                            .foregroundStyle(.red)
                    }
                }
                
                Section {
                    submit
                }
            }
            .disabled(vm.state == .submitting)
            .navigationTitle("Create")
            
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    done
                }
            }
            
            .onChange(of: vm.state) { formState in
                if formState == .successful {
                    dismiss()
                    successfulAction()
                }
            }
            .alert(isPresented: $vm.hasError, error: vm.error) { }
            
            .overlay {
                if vm.state == .submitting {
                    ProgressView()
                }
            }
        }
    }
}

extension CreateView {
    
    enum Field: Hashable {
        case firstName
        case lastName
        case job
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView(successfulAction: {} )
    }
}

private extension CreateView {
    
    var done: some View {
        Button("Done") {
            dismiss()
        }
    }
    
    var fistname: some View {
        TextField("First name", text: $vm.user.firstName)
            .focused($focusedField, equals: .firstName)
    }
    
    var lastname: some View {
        TextField("Last name", text: $vm.user.lastName)
            .focused($focusedField, equals: .lastName)
    }
    
    var job: some View {
        TextField("Job", text: $vm.user.job)
            .focused($focusedField, equals: .job)
    }
    
    var submit: some View {
        Button("Submit") {
            focusedField = nil
            Task {
                await vm.create()
            }
        }
    }
}
