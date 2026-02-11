# Gamblr-App
> Play. Bet. Win. Repeat.

A complete Flutter implementation of the Gamblr app UI, covering all auth and onboarding screens.
NB: This is a demo project and functions are going seamlessly without any issues, during Production, certain functions will need to be refactored based on my preference.

---

## 📁 Project Structure (Main part that I altered during the period of working on this)
```
assets/
├── images/
    ├── gamblr_icon.png
    ├── gamblr_mini.png
│   └── verify_icon.png
lib/
├── main.dart                        ← App entry point
├── theme/
│   └── app_theme.dart               ← Colors, fonts, ThemeData
├── widgets/
│   └── reusable_widgets.dart          ← Reusable components
└── screens/
    ├── splash_screen.dart           ← Animated 2-phase splash
    ├── onboarding_screen.dart       ← 3-slide onboarding carousel
    ├── signup_screen.dart           ← Sign up form
    ├── otp_verify_screen.dart       ← OTP entry + Account created success
    ├── create_pin_screen.dart       ← Create PIN + Confirm PIN (with numpad)
    ├── bvn_verify_screen.dart       ← BVN identity verification
    ├── login_screen.dart            ← Sign in + Returning user (biometrics)
    └── forgot_password_screen.dart  ← Forgot password → OTP → New password flow
```
---
## 🚀 Setup Instructions

### 1. Prerequisites
- Flutter SDK ≥ 3.0.0 ([install](https://flutter.dev/docs/get-started/install))
- Android Studio with Flutter & Dart plugins
- Android Emulator or physical device

### 2. Create the project

```bash
flutter create gamblr || fvm flutter create gamblr (if you install flutter using Flutter Version Management
cd gamblr
```

### 3. Install dependencies

```bash
flutter pub get || fvm flutter pub get
```

### 4. Run the app

```bash
flutter run || fvm flutter run
```

## 🚀 App Preview
https://github.com/user-attachments/assets/786a46ad-4acc-452e-ae28-11032539edd9




## 📱 Screen Flow

```
Splash → Onboarding → Sign Up → OTP Verify → Account Created
                                           → Create PIN → Confirm PIN → BVN Verify → Login

Login → (returning user) → Welcome Back → Home
     → Forgot Password → Reset OTP → New Password → Password Updated → Login
```

