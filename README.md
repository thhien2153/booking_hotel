# Hotel Booking Application Documentation
>
>
>
The Hotel Booking Application is a comprehensive mobile app built using Flutter for the frontend and Firebase for the backend. It offers a seamless platform for users to search, book, and manage hotel reservations while providing administrators tools to oversee bookings and manage hotel data. The application is developed using Android Studio and the Flutter framework.
>
>
## Features
>
1. User Management 
>
> - Browse and search for hotels with advanced filters (price, rating, location, and amenities).
>
> - Book hotels with secure and real-time booking confirmation.
>
> - User account creation, login, and profile management.
>
> - Integration with Google and Facebook for social login.
>
> - Booking history and cancellation options.
>
2. Admin Panel
> 
> - Hotel management: Add, update, or remove hotel listings.
> 
> - Booking monitoring and status updates.
> 
> - Dashboard for analytics and user management.
>
>
## Technology Stack
>
### Frontend Libraries
>
> - Flutter: Cross-platform mobile development framework.
> 
> - Provider: State management.
> 
> - HTTP: For API integration.
>
> - Google Maps API: Location-based hotel search.
>
> - Flutter Image Picker: Profile image uploads.
>
>
### Backend Services
>
> - Firebase Authentication: Secure user login and account management.
> 
> - Firebase Firestore: Real-time database for managing hotel data and bookings.
> 
> - Firebase Storage: Media storage for hotel images and user profiles.
>
> - Firebase Cloud Messaging (FCM): Push notifications for booking confirmations and updates.
>
>
>
## Testing Instructions
>
### For Android Users
>
> - Open Android Studio and connect an Android emulator or device.
> 
> - Run the app using flutter run from the terminal.
>
>
### For iOS Users
>
> - Ensure Xcode is installed and configured.
> 
> - Use flutter run to run the app on an iOS simulator or connected iPhone.
>
>
>
## Backend Setup
>
### Environment Variables
>
Set the following Firebase configurations in the project:
>
> - FIREBASE_API_KEY
> 
> - FIREBASE_AUTH_DOMAIN
>
> - FIREBASE_PROJECT_ID
>
> - FIREBASE_STORAGE_BUCKET
>
> - FIREBASE_MESSAGING_SENDER_ID
>
> - FIREBASE_APP_ID
>
>
### Important Notes
>
> - Ensure the Firebase project is properly linked to the Flutter app.
> 
> - Update the google-services.json (for Android) and GoogleService-Info.plist (for iOS) files with the correct Firebase configuration.
>
>
>
## Running the Application
>
### Frontend Setup
>
1. Navigate to the app's root directory.
>
2. Run flutter pub get to install all dependencies.
>
3. Launch the app using flutter run in Android Studio or the terminal
>
>
### Backend Integration
>
> - Firebase backend services are automatically linked with the frontend through the Firebase SDK.
