//
//  OrderStatus.swift
//  OrderStatus
//
//  Created by nyannyan0328 on 2022/08/02.
//

import WidgetKit
import SwiftUI
import Intents
import ActivityKit

@main
struct OrderStatus : Widget{
    
    var body: some WidgetConfiguration{
        
        
        ActivityConfiguration(attributesType:OrderAttributes.self) { context in
            
            
            ZStack{
                
                RoundedRectangle(cornerRadius: 10,style: .continuous)
                    .fill(Color("Green").gradient)
                
                
                VStack{
                    
                    HStack{
                        
                        Image("Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                         .frame(width: 40,height: 40)
                        
                        Text("In Store Picke up")
                            .foregroundColor(.white.opacity(0.3))
                              .frame(maxWidth: .infinity,alignment: .leading)
                        
                        
                        HStack(spacing:-2){
                            
                            ForEach(["Burger","Shake"],id:\.self){image in
                                
                                
                                Image(image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                 .frame(width: 30,height: 30)
                                 .background{
                                  
                                     Circle()
                                         .fill(Color("Green"))
                                         .padding(-2)
                                 }
                                 .background{
                                  
                                     Circle()
                                         .stroke(.white,lineWidth: 1.5)
                                         .padding(-2)
                                         
                                 }
                                
                            }
                            
                    
                            
                            
                            
                        }
                    }
                    
                    HStack(alignment:.bottom){
                        
                        
                        VStack(alignment: .leading,spacing: 5) {
                            
                            
                            Text(message(status:context.state.status))
                                .font(.title3)
                                .foregroundColor(.white)
                            
                            
                            Text(subMessage(status:context.state.status))
                                .font(.caption2)
                                .foregroundColor(.gray)
                            
                            
                            
                        }
                          .frame(maxWidth: .infinity,alignment: .leading)
                          .offset(y:15)
                        
                        HStack(alignment: .bottom,spacing: 0) {
                            
                            ForEach(Status.allCases,id:\.self){type in
                                
                                Image(systemName: type.rawValue)
                                    .font(context.state.status == type ? .title2 : .body)
                                    .foregroundColor((context.state.status == type ? Color("Green") : .white))
                                    .frame(width: context.state.status == type ? 45 : 32,height: context.state.status == type ? 45 : 32)
                                    .background{
                                     
                                        Circle()
                                            .fill((context.state.status == type ? .white : .gray))
                                    }
                                    .background(alignment:.bottom){
                                     
                                        BottomArrow(status:context.state.status, type: type)
                                    
                                    }
                                
                            }
                            .frame(maxWidth: .infinity,alignment: .center)
                            
                        }
                        .overlay(alignment:.bottom) {
                            
                            Rectangle()
                                .fill(.white.opacity(0.6))
                                .frame(height:2)
                                .offset(y:13)
                                .padding(.horizontal,27.5)
                        }
                          .frame(maxWidth: .infinity,alignment: .center)
                          .padding(.leading,15)
                          .padding(.trailing,-10)
                          
                        
                        
                    }
                    .frame(maxHeight: .infinity,alignment:.bottom)
                    .padding(.bottom,15)
                    
                }
                .padding(15)
            }
        }
        
        
    }
    @ViewBuilder
    func BottomArrow(status : Status,type : Status)->some View{
        
        
        Image(systemName: "arrowtriangle.up.fill")
            .font(.system(size: 15))
            .scaleEffect(1.3)
            .opacity(status == type ? 1 : 0)
            .foregroundColor(.white)
            .overlay(alignment: .bottom){
                
                
                Circle()
                    .fill(.white)
                 .frame(width: 5,height: 5)
                 .offset(y:13)
                
            }
        
    }
   
    func message(status : Status)->String{
        
        switch status {
        case .received:
            return "Order Received"
            
        case .progress:
            
            return "Order Progress"
            
        case .ready:
            
            return "Order Ready"
        
        }
        
    }
    func subMessage(status : Status)->String{
        
        switch status {
        case .received:
            return "We just your order"
            
        case .progress:
            
            return "We are handcarfting your order"
            
        case .ready:
            
            return "We crafted your order"
        
        }
        
    }
    
    
    
}
