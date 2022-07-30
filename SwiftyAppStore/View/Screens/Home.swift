 //
//  Home.swift
//  SwiftyAppStore
//
//  Created by Mico Infante on 7/30/22.
//

import SwiftUI

struct Home: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 30) {
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Saturday 30 July")
                            .font(.callout)
                            .foregroundColor(.gray)
                            .textCase(.uppercase)

                        Text("Today")
                            .font(.largeTitle.bold())
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Button(action: {}) {
                        Image(systemName: "person.circle.fill")
                            .font(.largeTitle)
                    }
                }
                .padding(.horizontal)

                ForEach(todayItems) { item in
                    Button {

                    } label: {
                        CardView(item: item)
                    }
                }
            }
            .padding(.vertical)
        }
    }


    @ViewBuilder
    func CardView(item: Today) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            ZStack(alignment: .topLeading) {

                GeometryReader { proxy in
                    let size = proxy.size
                    Image(item.artwork)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipShape(Curves(corners: [.topLeft, .topRight], radius: 15))
                }
                .frame(height: 400)

                LinearGradient(colors: [
                    .black.opacity(0.5),
                    .black.opacity(0.2),
                    .clear
                ], startPoint: .top, endPoint: .bottom)

                VStack(alignment: .leading, spacing: 8) {
                    Text(item.platformTitle.uppercased())
                        .font(.callout)
                        .fontWeight(.semibold)

                    Text(item.bannerTitle)
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.leading)
                }
                .foregroundColor(.primary)
                .padding()
            }

            HStack(spacing: 12) {
                Image(item.appLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))

                VStack(alignment: .leading, spacing: 4) {
                    Text(item.platformTitle.uppercased())
                        .font(.caption)
                        .foregroundColor(.gray)

                    Text(item.appName)
                        .font(.caption)
                        .foregroundColor(.gray)

                    Text(item.appDescription)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)

                Button(action: {
                }) {
                    Text("GET")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        .background {
                            Capsule()
                                .fill(.ultraThinMaterial)
                        }
                }
            }
            .padding([.horizontal, .bottom])
        }.background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color("bg"))
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .preferredColorScheme(.dark)
    }
}
