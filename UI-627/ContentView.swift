//
//  ContentView.swift
//  UI-627
//
//  Created by nyannyan0328 on 2022/08/02.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    @State var currentID : String = ""
    @State var currentSelection : Status = .received
    var body: some View {
        NavigationStack{
            
            VStack{
                
                Picker(selection: $currentSelection) {
                    
                    Text("Recivied")
                        .tag(Status.received)
                    
                    Text("progress")
                        .tag(Status.progress)
                    
                    Text("ready")
                        .tag(Status.ready)
                    
                } label: {
                    
                }
                .labelsHidden()
                .pickerStyle(.segmented)

                
                Button("Active"){
                    
                    
                    addLiveActivity()
                }
                .padding(.top)
                
                
                
                Button("Remove Activity"){
                    
                    
                  removeActivity()
                }
                .padding(.top)
            }
            .navigationTitle("Live Activity")
            .padding(15)
            .onChange(of: currentSelection) { newValue in
                
                if let activity = Activity.activities.first(where: { (activity : Activity<OrderAttributes>) in
                    
                    activity.id == currentID
                }){
                    
                    print("Activity Found")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        
                        var updateState = activity.contentState
                        
                        
                        updateState.status = currentSelection
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                            
                            
                            Task{
                                
                                await activity.update(using:updateState)
                            }
                        }
                    }
                }
                
                
            }
        }
    }
    func removeActivity(){
        
        if let activity = Activity.activities.first(where: { (activity : Activity<OrderAttributes>) in
            
            activity.id == currentID
        }){
            
            Task{
                
                await activity.end(using:activity.contentState, dismissalPolicy:.immediate)
            }
            
        }
        
        
        
    }
    func addLiveActivity(){
        
        let orderAtributes = OrderAttributes(orderNumber: 26383, orderItems: "Bubger & Milk")
        
        let initialContentState = OrderAttributes.ContentState()
        
        do{
            
            let activity = try Activity<OrderAttributes>.request(attributes: orderAtributes, contentState: initialContentState,pushType: nil)
            
            currentID = activity.id
            
            print("a\(activity.id)")
            
            
        }
        catch{
            
            print(error.localizedDescription)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
