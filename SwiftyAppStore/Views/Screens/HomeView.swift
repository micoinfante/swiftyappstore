//
//  Home.swift
//  SwiftyAppStore
//
//  Created by Mico Infante on 7/30/22.
//

import SwiftUI
import Combine

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()


    @State var currentItem: StoreApp?
    @State var showDetailPage: Bool = false

    @Namespace var animation

    @State var animateView: Bool = false
    @State var animateContent: Bool = false
    @State var scrollOffset: CGFloat = 0

    var body: some View { content }

    @ViewBuilder private var content: some View {
        switch viewModel.apps {
        case .notRequested:
            Text("").onAppear { viewModel.loadApps() }
        case let .isLoading(apps, _):
            loadingView(apps)
        case let .loaded(apps):
            loadedView(apps)
        case let .failed(error):
            failedView(error)
        }
    }


    @ViewBuilder
    func CardView(item: StoreApp) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            ZStack(alignment: .topLeading) {

                GeometryReader { proxy in
                    let size = proxy.size
                    AsyncImage(url: item.artworkURL.toURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: size.width, height: size.height)
                        case let .success(image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                                .clipShape(Curves(corners: [.topLeft, .topRight], radius: 15))
                        default:
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                                .clipShape(Curves(corners: [.topLeft, .topRight], radius: 15))
                        }
                    }

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
                        .foregroundColor(Color(uiColor: .lightGray))

                    Text(item.bannerTitle)
                        .font(.largeTitle.bold())

                        .multilineTextAlignment(.leading)
                }
                .foregroundColor(.primary)
                .padding()
                .offset(y: currentItem?.id == item.id && animateView ? safeArea().top : 0)
            }

            HStack(spacing: 12) {
                Image(item.logoURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))

                VStack(alignment: .leading, spacing: 4) {
                    Text(item.platformTitle.uppercased())
                        .font(.caption)
                        .foregroundColor(.gray)

                    Text(item.name)
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
        }
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color("bg"))
        }
        .matchedGeometryEffect(id: item.id, in: animation)
    }
}

extension HomeView {
    // MARK: Detail View
    func DetailView(item: StoreApp) -> some View{
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                CardView(item: item)
                    .scaleEffect(animateView ? 1 : 0.93)

                VStack(spacing: 15) {
                    Text("Lorem ipsum")
                        .multilineTextAlignment(.leading)
                        .lineSpacing(10)
                        .padding(.bottom, 20)

                    Divider()

                    Button(action: {

                    }){
                        Label(title: {
                            Text("Share Story")
                        }, icon: {
                            Image(systemName: "square.and.arrow.up.fill")
                        })
                            .foregroundColor(.primary)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 25)
                            .background {
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .fill(.ultraThinMaterial)
                            }
                    }
                }
                .padding()
                .offset(y: scrollOffset > 0 ? scrollOffset : 0)
                .opacity(animateContent ? 1 : 0)
                .scaleEffect(animateView ? 1 : 0, anchor: .top)
            }
            .offset(y: scrollOffset > 0 ? -scrollOffset : 0)
            .offset(offset: $scrollOffset)
        }
        .coordinateSpace(name: "SCROLL")
        .overlay(alignment: .topTrailing) {
            Button {
                // CLose view
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                    animateView = true
                    animateContent = false
                }

                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.05)) {
                    currentItem = nil
                    showDetailPage = false
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .padding()
            .padding(.top, safeArea().top)
            .offset(y: -10)
            .opacity(animateView ? 1 : 0)
        }
        .onAppear {
            withAnimation(.interactiveSpring(response: 0.6,
                                             dampingFraction: 0.7,
                                             blendDuration: 0.7)) {
                animateView = true
            }

            withAnimation(.interactiveSpring(response: 0.6,
                                             dampingFraction: 0.7,
                                             blendDuration: 0.7).delay(0.1)) {
                animateContent = true
            }
        }
        .transition(.identity)
    }
}

// MARK: Displaying Content
private extension HomeView {

    var notRequestedView: some View {
        Text("").onAppear(perform: {
            viewModel.loadApps()
        })
    }

    @ViewBuilder
    func loadedView(_ apps: [StoreApp]) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 30) {
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(Date().today().uppercased())
                            .font(.caption)
                            .fontWeight(.semibold)
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
                .padding(.bottom)
                .opacity(showDetailPage ? 0 : 1)

                ForEach(apps) { item in
                    Button {
                        withAnimation(.interactiveSpring(response: 0.6,
                                                         dampingFraction: 0.7,
                                                         blendDuration: 0.7)) {
                            currentItem = item
                            showDetailPage = true
                        }
                    } label: {
                        CardView(item: item)
                            .scaleEffect(currentItem?.id == item.id && showDetailPage ? 1 : 0.93)
                    }
                    .buttonStyle(ScaledButtonStyle())
                    .opacity(showDetailPage ? (currentItem?.id == item.id ? 1 : 0) : 1)
                }

            }
            .padding(.vertical)
        }
        .overlay {
            if let currentItem = currentItem, showDetailPage {
                DetailView(item: currentItem)
                    .ignoresSafeArea(.container, edges: .top)
            }
        }
        .background(alignment: .top) {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color("bg"))
                .frame(height: animateView ? nil : 350, alignment: .top)
                .opacity(showDetailPage ? 1 : 0)
                .ignoresSafeArea()
        }
    }

    func loadingView(_ last: [StoreApp]?) -> some View {
        if let apps = last {
            return AnyView(loadedView(apps))
        } else {
            return AnyView(ProgressView())
        }
    }

    func failedView(_ error: Error) -> some View {
        // TODO: Create better error screen
        return Text(error.localizedDescription)
    }
}

// FIXME: Pass param apps
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//            .preferredColorScheme(.dark)
//    }
//}
