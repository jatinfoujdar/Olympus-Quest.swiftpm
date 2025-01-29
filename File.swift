import SwiftUI

struct Content: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(0..<10) { item in
                        NavigationLink(destination: DetailView(item: item)) {
                            HStack {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                VStack(alignment: .leading) {
                                    Text("Item (item)")
                                        .font(.headline)
                                    Text("Description for item (item)")
                                        .font(.subheadline)
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle("Home")
        }
    }
}

struct DetailView: View {
    let item: Int
    
    var body: some View {
        VStack {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .padding()
            Text("Item (item)")
                .font(.largeTitle)
            Text("Detailed description for item (item).")
                .padding()
        }
        .navigationTitle("Detail")
    }
}

struct ProfileView: View {
    @State private var username: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User Info")) {
                    TextField("Username", text: $username)
                }
                Section {
                    Button("Logout") {
                        // Handle logout functionality
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

struct SettingsView: View {
    @State private var notificationsEnabled: Bool = true
    @State private var selectedOption: Int = 1
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Preferences")) {
                    Toggle(isOn: $notificationsEnabled) {
                        Text("Enable Notifications")
                    }
                    
                    Picker(selection: $selectedOption, label: Text("Select Option")) {
                        Text("Option 1").tag(1)
                        Text("Option 2").tag(2)
                        Text("Option 3").tag(3)
                    }
                }
                Section(header: Text("Account")) {
                    Button("Sign Out") {
                        // Handle sign out
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}


#Preview{
    Content()
}
