import csv
import os
import firebase_admin
from firebase_admin import credentials, firestore

print("🚀 Starting Firestore import...")

# -----------------------------
# FIREBASE CONNECTION
# -----------------------------
cred = credentials.Certificate("serviceAccountKey.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

# -----------------------------
# CSV FILE
# -----------------------------
csv_file = "sports_access_data.csv"

if not os.path.exists(csv_file):
    print(f"❌ CSV file not found: {csv_file}")
    exit()

# -----------------------------
# IMPORT DATA
# -----------------------------
with open(csv_file, "r", encoding="utf-8-sig", newline="") as file:

    # IMPORTANT: CSV now uses semicolons
    reader = csv.DictReader(file, delimiter=";")

    # Clean header names
    reader.fieldnames = [header.strip() for header in reader.fieldnames]

    print("\n📋 Headers detected:")
    print(reader.fieldnames)
    print()

    count = 0

    for row in reader:

        # Clean keys and values
        row = {
            (key.strip() if key else ""):
            (value.strip() if value else "")
            for key, value in row.items()
            if key
        }

        data = {
            "name": row.get("Location Name", ""),
            "facilityType": row.get("Facility Type", ""),
            "city": row.get("City", ""),
            "address": row.get("Full Address", ""),
            "sport": row.get("Sport", ""),
            "programName": row.get("Program Name", ""),
            "category": row.get("Category", ""),
            "skillLevel": row.get("Skill Level", ""),
            "programType": row.get("Program Type", ""),
            "days": row.get("Days Running", ""),
            "time": row.get("Time", ""),
            "pricing": row.get("Pricing", ""),
            "membershipRequired": row.get("Membership Required", ""),
            "dropInAvailable": row.get("Drop-In Available", ""),
            "contact": row.get("Contact Number", ""),
            "website": row.get("Website", ""),
            "mapsAddress": row.get("Google Maps Friendly Address", ""),
            "indoorOutdoor": row.get("Indoor or Outdoor", ""),
            "popularity": row.get("Estimated Popularity", ""),
            "notes": row.get("Notes", ""),
            "lastVerifiedDate": row.get("Last Verified Date", ""),
            "sourceDocument": row.get("Source Document", "")
        }

        db.collection("locations").add(data)

        count += 1
        print(f"✅ Imported {count}: {data['name']}")

print("\n🎉 Import completed successfully!")
print(f"📄 Total locations imported: {count}")