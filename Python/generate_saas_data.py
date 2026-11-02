import pandas as pd
import random
from faker import Faker
from datetime import datetime, timedelta


# PART 1 ----CREATE USER BASE

# Number of users
NUM_USERS = 100000

# Make results reproducible
random.seed(42)
Faker.seed(42)

fake = Faker()


# Business dimensions

countries = [
    "India",
    "United States",
    "United Kingdom",
    "Canada",
    "Australia",
    "Germany",
    "Singapore",
    "UAE"
]

devices = [
    "Desktop",
    "Mobile",
    "Tablet"
]

acquisition_channels = [
    "Organic",
    "Google Ads",
    "Meta Ads",
    "Referral",
    "YouTube"
]



# Signup date range

start_date = datetime(2025, 1, 1)
end_date = datetime(2025, 12, 31)

date_range_days = (end_date - start_date).days



# Generate users

users = []

for i in range(1, NUM_USERS + 1):

    signup_date = start_date + timedelta(
        days=random.randint(0, date_range_days)
    )

    user = {
        "user_id": f"U{i:06d}",
        "signup_date": signup_date.date(),
        "country": random.choice(countries),
        "device_type": random.choice(devices),
        "acquisition_channel": random.choice(acquisition_channels),
        "plan_type": "Free"
    }

    users.append(user)


# Create DataFrame

users_df = pd.DataFrame(users)



# Basic validation

print("Number of users:", len(users_df))

print("\nFirst 5 users:")
print(users_df.head())

print("\nMissing values:")
print(users_df.isnull().sum())

print("\nDuplicate user IDs:")
print(users_df["user_id"].duplicated().sum())

print("\nCountry distribution:")
print(users_df["country"].value_counts())

print("\nAcquisition channel distribution:")
print(users_df["acquisition_channel"].value_counts())

print("\nDevice distribution:")
print(users_df["device_type"].value_counts())


# Save user dataset
users_df.to_csv(
    r"users_csv_file_path",
    index=False
)

print("\nUser dataset saved successfully.")