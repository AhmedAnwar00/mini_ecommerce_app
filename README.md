# Mini Ecommerce App

A Flutter demo that signs in with fixed credentials, lists a local product catalog, and keeps a cart in memory for the current session.

## Project Overview

The app opens on a login screen. A successful login replaces that route with a product grid. Products come from an in-memory list. Adding a product updates a cart that stays available while the user moves between Home and Cart. There is no backend, persistence, or checkout.

## Features

- Login with required email and password fields, a loading indicator, and success or error feedback.
- Product grid with name, price, and an add-to-cart action.
- Empty, loading, and error layouts for the product list.
- Cart screen with quantity increase and decrease, item removal, item count, and price total.
- Empty-cart message when no items are present.
- Image fallback when a product asset cannot be loaded.

## Architecture

The project uses MVC inside feature folders.

- **Model** holds `Product` and `CartItem`, plus the mock product list. Models do not depend on widgets.
- **View** is the `presentation` layer: screens and widgets render state and forward actions.
- **Controller** is the `logic` layer: Cubits validate login, load products, and update the cart.

Shared navigation lives in `lib/core/routes`. `MaterialApp` uses named routes through `AppRouter`.

## State Management (Cubit)

`flutter_bloc` Cubits own UI state.

| Cubit | Scope | States |
| --- | --- | --- |
| `LoginCubit` | Created on the login screen | `LoginInitial`, `LoginLoading`, `LoginSuccess`, `LoginError` |
| `HomeCubit` | Created on the home screen | `HomeInitial`, `HomeLoading`, `HomeSuccess`, `HomeError` |
| `CartCubit` | Provided above `MaterialApp` | `CartState` with an unmodifiable item list |

`LoginCubit` accepts only `test@test.com` / `123456`. The screen checks empty fields before calling the Cubit. `HomeCubit` emits the mock list immediately after a loading state. `CartCubit` merges duplicate product ids by increasing quantity, removes an item when quantity reaches zero, and exposes `totalItems` and `totalPrice`.

## Project Structure

```text
lib/
├── main.dart
├── core/routes/
│   ├── app_routes.dart
│   └── app_router.dart
└── features/
    ├── auth/log_in/
    │   ├── logic/cubit/login_cubit.dart
    │   ├── logic/state/login_state.dart
    │   └── presentation/screen/login_screen.dart
    ├── home/
    │   ├── model/product.dart
    │   ├── model/data/mock/products.dart
    │   ├── logic/cubit/home_cubit.dart
    │   ├── logic/state/home_state.dart
    │   └── presentation/
    │       ├── screen/home_screen.dart
    │       └── widgets/
    ├── cart/
    │   ├── model/cart_item.dart
    │   ├── logic/cubit/cart_cubit.dart
    │   ├── logic/state/cart_state.dart
    │   └── presentation/
    │       ├── screen/cart_screen.dart
    │       └── widgets/cart_item_card.dart
```

Routes: `/login`, `/home`, `/cart`. An unknown route name opens Home.

## Important Technical Decisions

- `CartCubit` is created once at the app root so the cart survives route changes. Login and home Cubits are created with their screens.
- Login and home use sealed state classes. The cart uses one state class and emits a new unmodifiable list on every change.
- Login success uses `pushReplacementNamed`, so the back button does not return to the login screen. The cart icon uses `pushNamed`.
- Product cards pass the whole `Product`. Cart rows pass the whole `CartItem`.
- Missing images use `Image.asset` `errorBuilder` and show a placeholder icon.

## Challenges

- Authentication and the catalog are local. `HomeCubit` wraps the mock load in `try/catch`, but the current list does not fail at runtime.
- Product image paths point at `assets/images/`, and those files are not declared in `pubspec.yaml`. Cards and cart rows show the placeholder.
- The cart exists only in memory and is cleared when the process ends.
- `test/widget_test.dart` still expects the default counter app, so it does not cover the current screens.

## Production Improvements

- Replace the fixed login check with a real authentication API and session handling.
- Load products from a remote source and register or host product images.
- Persist the cart and add checkout.
- Replace the default widget test with login, catalog, and cart coverage.

## Demo Flow

1. Launch the app. The login screen is the initial route.
2. Submit empty fields. The screen shows which fields are required and does not call the Cubit.
3. Enter any other email or password. A snack bar shows `Invalid email or password`.
4. Enter `test@test.com` and `123456`. The button shows a progress indicator, then a success snack bar, and the app opens the product grid.
5. Tap **Add to Cart** on a product. A snack bar confirms the add. Adding the same product again increases its quantity.
6. Open the cart from the app bar icon. Change quantity, remove a line, and check the item count and total. Decreasing a quantity to zero removes that line.
7. Remove every item. The cart shows `Your cart is empty`.
