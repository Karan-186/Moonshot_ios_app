//
//  MissionView.swift
//  Project_8_Moonshot
//
//  Created by KARAN  on 15/06/22.
//

import SwiftUI

struct MissionView: View {
    
    struct crewMember{
        let role : String
        let astronaut : Astronaut
    }
    
    let mission : Mission
    let crew : [crewMember]
    
    var body: some View {
        GeometryReader{ geometry in
            ScrollView{
                VStack{
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth : geometry.size.width * 0.6)
                        .padding(.top)
                    
                    Text(mission.formattedLaunchDate)
                        .foregroundColor(.white)
                    
                    VStack(alignment : .leading ){
                        Rectangle()
                            .frame(height : 2)
                            .foregroundColor(.lightBackground)
                            .padding()
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding()
                        
                        Text(mission.description)
                        
                        Rectangle()
                            .frame(height : 2)
                            .foregroundColor(.lightBackground)
                            .padding()
                        
                        Text("Crew")
                            .font(.title.bold())
                            .padding()
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal , showsIndicators: false){
                        HStack{
                            ForEach(crew , id : \.role){ crewmember in
                                NavigationLink{
                                    AstronautView(astronaut: crewmember.astronaut)                                }label: {
                                        HStack{
                                            Image(crewmember.astronaut.id)
                                                .resizable()
                                                .frame(width: 104, height: 72)
                                                .clipShape(Capsule())
                                                .overlay(
                                                    Capsule()
                                                        .strokeBorder(.white,lineWidth: 1)
                                                )
                                            VStack(alignment: .leading) {
                                                Text(crewmember.astronaut.name)
                                                    .foregroundColor(.white)
                                                    .font(.headline)
                                                
                                                Text(crewmember.role)
                                                    .foregroundColor(.secondary)
                                            }
                                            
                                        }
                                        .padding(.horizontal)
                                    }
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    init(mission : Mission , astronauts : [String :Astronaut] ){
        self.mission = mission
        
        self.crew = mission.crew.map{ member in
            if let astronaut = astronauts[member.name]{
                return crewMember(role: member.role, astronaut: astronaut)
            } else{
                fatalError("Coudn't find astronaut")
            }
        }
        
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions : [Mission] = Bundle.main.decode("missions.json")
    static let astronauts : [String : Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
