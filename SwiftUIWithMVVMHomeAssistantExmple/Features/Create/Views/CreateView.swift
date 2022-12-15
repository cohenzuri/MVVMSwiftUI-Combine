//
//  CreateView.swift
//  SwiftUIWithMVVMHomeAssistantExmple
//
//  Created by zuri cohen on 12/9/22.
//

import SwiftUI

struct CreateView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = CreateViewModel()
    let successfulAction: () -> Void
    
    var body: some View {
        
        NavigationView {
            
            Form {
                fistname
                lastname
                job
                
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
    }
    
    var lastname: some View {
        TextField("Last name", text: $vm.user.lastName)
    }
    
    var job: some View {
        TextField("Job", text: $vm.user.job)
    }
    
    var submit: some View {
        Button("Submit") {
            vm.create()
        }
    }
}
