# Mahindra University App 📱

A unified platform for students, parents, and teachers at Mahindra University. This app facilitates attendance management, assignment tracking, grade monitoring, and real-time location tracking.

## 📌 Overview

The Mahindra University App streamlines academic processes by providing a comprehensive platform where:
- Students can mark attendance, view assignments, and check grades
- Teachers can manage classes, create assignments, and update grades
- Parents can track their child's location and monitor academic progress

## 🌟 Features

### 🚀 For Teachers
- **Post Announcements**: Share updates and important information
- **Manage Attendance**: Take attendance for each class
- **Assign Homework**: Create and track student assignments 
- **Grades Management**: View and update student grades

### 🔠 For Parents
- **Track Child's Location**: View real-time location within campus
- **View Child's Progress**: Monitor grades and attendance

### ⚡ For Students
- **Mark Attendance**: Self-attendance functionality for classes
- **View Assignments**: Access all homework and assignments
- **Check Grades**: Track academic performance

## 🏡 Architecture

- **Frontend**: Built with Flutter for cross-platform compatibility
- **Backend**: 
  - Firebase Authentication for secure login
  - Firestore for data storage
  - Firebase Cloud Messaging for notifications
- **Location Services**: Google Maps API for real-time tracking

## ⚙️ Setup and Installation

### Prerequisites
- Flutter SDK: [Setup Guide](https://flutter.dev/docs/get-started/install)
- Firebase Account: Create a project on [Firebase Console](https://console.firebase.google.com)

### Installation Steps

1. **Clone the Repository**
```bash
git clone https://github.com/your-username/mahindra-university-app.git
cd mahindra-university-app
```

2. **Install Dependencies**
```bash
flutter pub get
```

3. **Configure Firebase**
   - Android: Add `google-services.json` in `android/app/`
   - iOS: Add `GoogleService-Info.plist` in `ios/Runner/`
   - Enable Firebase Authentication and Firestore in Firebase Console

4. **Run the App**
```bash
flutter run
```

## 🚀 How to Use

### For Teachers
1. Sign in with your teacher credentials
2. Navigate to the dashboard to:
   - Post announcements
   - Manage attendance
   - Update grades

### For Parents
1. Login using parent credentials
2. Access features to:
   - Track child's location
   - Monitor academic performance

### For Students
1. Login with student credentials
2. Use the app to:
   - Mark attendance
   - Submit assignments
   - View grades

## 🤝 Contributing

We welcome contributions! Here's how you can help:

1. Fork the repository
2. Create a feature branch:
```bash
git checkout -b feature-branch
```
3. Commit your changes:
```bash
git commit -m "Add feature X"
```
4. Push to the branch:
```bash
git push origin feature-branch
```
5. Open a Pull Request

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 💡 Tips

- Join the Mahindra University community to stay connected and organized
- Enable notifications for real-time updates
- Keep the app updated for the best experience

---
