# Project Details — Plusmart Store App

This document describes the **plusmart_store_app** repository: a Flutter e-commerce style client that consumes the public [Fake Store API](https://fakestoreapi.com/).

---

## Overview

| Item | Value |
|------|--------|
| **Repository folder** | `plusmart_store_app` |
| **Flutter package name** | `store_app` (see `pubspec.yaml`) |
| **Version** | `1.0.0+1` |
| **Dart SDK** | `^3.7.2` |
| **Primary platforms** | Android and iOS (splash and launcher icons configured) |
| **Branding** | Plus Mart — launcher icon asset: `assets/plus_mart_logo.png`; splash image: `assets/logo_icon.png` |

The app presents a **Discover** home experience with category tabs, a product grid, navigation to **update** a product, and placeholder tabs for search, cart, favorites, and profile.

---

## Tech Stack

- **Framework:** [Flutter](https://flutter.dev/) (Material 3–style widgets: `NavigationBar`, `FilledButton`, `ThemeData`, etc.)
- **Language:** Dart
- **Networking:** [`http`](https://pub.dev/packages/http) (`package:http/http.dart`)
- **JSON:** `dart:convert` (`jsonDecode` in `Api` helper)
- **UI assets:** [`flutter_svg`](https://pub.dev/packages/flutter_svg) for bottom navigation and home app bar icons
- **Loading overlay:** [`modal_progress_hud_nsn`](https://pub.dev/packages/modal_progress_hud_nsn) on the update-product screen
- **Icons (dependency):** [`cupertino_icons`](https://pub.dev/packages/cupertino_icons), [`font_awesome_flutter`](https://pub.dev/packages/font_awesome_flutter) — *Font Awesome is declared in `pubspec.yaml` but not referenced under `lib/` at the time of this document*
- **Dev tooling:** `flutter_test`, [`flutter_launcher_icons`](https://pub.dev/packages/flutter_launcher_icons), [`flutter_native_splash`](https://pub.dev/packages/flutter_native_splash)
- **Static analysis:** `analysis_options.yaml` includes [`flutter_lints`](https://pub.dev/packages/flutter_lints) (recommended Flutter lint set)

---

## Dependencies (`pubspec.yaml`)

### Runtime (`dependencies`)

| Package | Purpose |
|---------|---------|
| `flutter` (SDK) | UI framework |
| `cupertino_icons` | iOS-style icon font (Material companion) |
| `http` | REST calls to Fake Store API |
| `font_awesome_flutter` | Icon pack (listed; no current `lib` usage) |
| `modal_progress_hud_nsn` | Full-screen loading HUD on update flow |
| `flutter_svg` | SVG icons from `assets/icons/` |

### Development (`dev_dependencies`)

| Package | Purpose |
|---------|---------|
| `flutter_test` | Widget/unit tests |
| `flutter_launcher_icons` | App icon generation |
| `flutter_native_splash` | Native splash screen generation |

---

## Native Branding Configuration

### `flutter_native_splash`

- **Background color:** `#1A1A1A`
- **Image:** `assets/logo_icon.png`
- **Platforms:** Android and iOS enabled

### `flutter_icons` (launcher)

- **Image:** `assets/plus_mart_logo.png`
- **Platforms:** Android and iOS enabled

---

## Assets

### Images

- `assets/logo_icon.png` — splash
- `assets/plus_mart_logo.png` — launcher (via `flutter_launcher_icons` config)

### SVG icons (`assets/icons/`)

| File | Typical use |
|------|-------------|
| `home.svg` | Bottom nav — Home |
| `search.svg` | Bottom nav — Search |
| `cart.svg` | Bottom nav — Cart |
| `favorite.svg` | Bottom nav — Favorite |
| `user.svg` | Bottom nav — Profile |
| `notifi.svg` | Home `SliverAppBar` action |

### Fonts

| Family | File |
|--------|------|
| `RationalDisplayLight` | `assets/fonts/RationalDisplayDEMO-Light.otf` |
| `RationalDisplaySemiBold` | `assets/fonts/RationalDisplayDEMO-SemiBold.otf` |

Global theme sets `fontFamily: 'RationalDisplayLight'`; titles use `RationalDisplaySemiBold` where specified.

---

## Architecture & Folder Structure

```
lib/
├── main.dart                 # App entry, MaterialApp, routes, NavigationContainer home
├── constants.dart            # Grayscale palette (kColor900 … kColor0)
├── theme.dart                # ThemeData (tabs, buttons, ColorScheme)
├── helper/
│   └── api.dart              # HTTP GET / POST / PUT wrapper + JSON decode
├── models/
│   └── product_model.dart    # ProductModel + RatingModel (fromJson)
├── services/
│   ├── get_all_product_service.dart   # GET /products
│   ├── categories_service.dart        # GET /products/category/{category}
│   ├── all_categories_service.dart    # GET /products/categories
│   ├── add_products_service.dart      # POST /products
│   └── update_product_service.dart    # PUT /products/{id}
├── views/
│   ├── home_view.dart        # Discover + category TabBar + product grid
│   ├── search_view.dart      # Placeholder
│   ├── cart_view.dart        # Placeholder
│   ├── favorites_view.dart   # Placeholder
│   ├── profile_view.dart     # Placeholder
│   ├── login_view.dart       # Minimal placeholder (“Login to your account”)
│   ├── update_product_view.dart  # Form + ModalProgressHUD + UpdateProductService
│   └── test.dart             # Commented experimental code
└── widgets/
    ├── bottom_navigation.dart    # NavigationContainer + BottomNavigation (SVG)
    ├── custom_card.dart          # Product tile → navigates to UpdateProductView
    ├── custom_text_field.dart
    └── custom_text_form_field.dart
```

**Pattern:** thin **service** classes call **`Api`**, map JSON with **`ProductModel.fromJson`**, and **views** own UI state (e.g. `Future`, loading flags, `TabController`).

---

## Backend / API Integration

All live traffic targets **Fake Store API** (`https://fakestoreapi.com`).

| Service | HTTP | Endpoint pattern |
|---------|------|------------------|
| `AllProductsService` | GET | `/products` |
| `CategoriesService` | GET | `/products/category/{categoryName}` |
| `AllCategoriesService` | GET | `/products/categories` |
| `AddProductsService` | POST | `/products` (body: title, price, description, image, category) |
| `UpdateProductService` | PUT | `/products/{id}` (same fields) |

The shared **`Api`** class (`lib/helper/api.dart`):

- Sends optional `Authorization: Bearer {token}` when a token is provided (POST/PUT); GET always builds a Bearer header from the `token` argument as written in code.
- Treats **HTTP 200** as success and parses JSON; other status codes throw `Exception` with status (and body where implemented).

**Data model:** `ProductModel` fields align with Fake Store product JSON: `id`, `title`, `price`, `description`, `image`, `category`, optional nested `rating` (`rate`, `count`).

---

## Features (Current Behavior)

1. **Home — “Discover”**
   - `SliverAppBar` with title and notification icon (SVG).
   - **Category tabs:** `all`, `men's clothing`, `women's clothing`, `jewelery`, `electronics` (hardcoded list; `AllCategoriesService` exists but is not wired here).
   - Loads products via `AllProductsService` or `CategoriesService` depending on tab.
   - Grid of **`CustomCard`** widgets; tap opens **Update Product** with `ProductModel` as route arguments.

2. **Update product**
   - Route id: `UpdateProductView.id` (`'update'`).
   - Fields: name, description, price, image URL; submits with `UpdateProductService` and shows **`ModalProgressHUD`** while loading.

3. **Bottom navigation**
   - Five tabs: Home, Search, Cart, Favorite, Profile — implemented with Material **`NavigationBar`** and SVG assets.

4. **Login**
   - Named route `LoginView.id` (`'login'`); UI is a minimal placeholder.

5. **Search / Cart / Favorites / Profile**
   - Placeholder centered `Text` widgets.

---

## Application Entry & Routing (`main.dart`)

- **`StoreApp`** → `MaterialApp` with `theme: themeData()`, `home: NavigationContainer()`.
- **Named routes:** `UpdateProductView`, `LoginView`.
- **`initialRoute`:** `HomeView.id` — note this is defined alongside `home: NavigationContainer()`; verify behavior matches intent (Flutter resolves `home` vs `initialRoute` per framework rules).

---

## Testing

- **`test/widget_test.dart`** — default Flutter widget test scaffold (counter app template may still be present unless updated).

---

## Notable Implementation Notes

- **`lib/widgets/bottom_navigation.dart`** ends with an extra **`main()`** and **`MyApp`** example class — likely copy-paste residue; the real entry point is `lib/main.dart`.
- **`AllCategoriesService`** fetches categories from the API but the home screen uses a **fixed** category list.
- **`AddProductsService`** is implemented for POST `/products` but may not be bound to a visible screen in the current UI.
- **`font_awesome_flutter`** is in dependencies without imports in `lib/`.
- **`pubspec.yaml`** structure: `flutter_lints` appears nested under the `flutter_icons:` mapping in the file as checked in-repo — you may want to move `flutter_lints` under `dev_dependencies` if the analyzer or `pub get` reports issues.

---

## How to Run

From the project root:

```bash
flutter pub get
flutter run
```

Regenerate splash / icons after asset changes (when configured):

```bash
dart run flutter_native_splash:create
dart run flutter_launcher_icons
```

(Exact commands follow each package’s current documentation.)

---

## Summary

**Plusmart Store App** is a Flutter **storefront-style** mobile app using **custom typography**, **SVG navigation**, a **neutral gray palette**, and **Fake Store API** for listing and updating products. Several tabs and packages are **scaffolds or unused hooks** for future work (search, cart, favorites, profile, login, add product UI, dynamic categories, Font Awesome).
