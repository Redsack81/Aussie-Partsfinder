# PartFinder — starter app

A Flutter starter for an Australian-first universal vehicle-parts search app.

## What this version does
- Cars / 4WD
- Motorcycles
- Trucks
- Boats / marine
- New / used / all
- Year, make, model, part and part-number search
- Opens multiple marketplaces with the search pre-filled
- Designed so more marketplaces can be added without changing the core UI

## Important next development step
This version intentionally does NOT scrape websites. It sends users to each marketplace. That is safer and more maintainable because marketplace search endpoints, robots rules, terms, and APIs can change.

For true live stock aggregation later, add official APIs/feeds where permitted.

## Run
1. Install Flutter.
2. Run `flutter pub get`.
3. Run `flutter run`.

For Android:
`flutter build apk --release`

## Suggested next features
- VIN / rego vehicle identification
- Saved vehicles
- Saved searches and notifications
- Marketplace availability tracking
- Distance/location filtering
- Seller ratings
- Part compatibility database
- OEM cross-reference database
- Image-based part identification
- Dedicated supplier connectors/APIs
- Admin screen for adding/editing marketplaces without rebuilding the app


## VIN / Rego identification

The UI now supports:
- VIN entry
- Australian registration plate + state
- Automatic vehicle identity lookup by rego
- Populating year/make/model from the returned vehicle data
- A PPSR button for official vehicle-history/security checks

The starter uses a rego lookup API abstraction so the provider can be swapped later. For production, put the API key behind your own backend rather than shipping a secret API key inside the mobile app.

Important: a rego lookup identifies the vehicle for parts searching; it should not be treated as a substitute for an official PPSR check. PPSR searches use the VIN/chassis identifier for the official check.
