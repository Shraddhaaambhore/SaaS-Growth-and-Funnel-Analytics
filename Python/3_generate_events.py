import pandas as pd
import random
from datetime import datetime, timedelta



# PART 3 --EVENT GENERATION

random.seed(42)


# Load existing data
users_df = pd.read_csv(
    r"users csv file path"
)

journey_df = pd.read_csv(
    r"user_journey csv file path"
)

print("Users loaded:", len(users_df))
print("Journeys loaded:", len(journey_df))



# Feature list
features = [
    "Dashboard",
    "Task Management",
    "File Sharing",
    "Team Collaboration",
    "Analytics"
]



# Event storage
events = []

event_counter = 1


# Generate events for each user


for _, user in users_df.iterrows():

    user_id = user["user_id"]

    signup_date = pd.to_datetime(
        user["signup_date"]
    )

    journey = journey_df[
        journey_df["user_id"] == user_id
    ].iloc[0]

    current_time = signup_date + timedelta(
        hours=random.randint(1, 12)
    )

    session_number = 1

    
    # Signup

    events.append({
        "event_id": f"E{event_counter:08d}",
        "user_id": user_id,
        "event_timestamp": current_time,
        "event_type": "Signup",
        "feature_name": None,
        "session_id": f"{user_id}_S{session_number:03d}",
        "revenue": 0
    })

    event_counter += 1



    # Onboarding Started

    if journey["onboarding_started"]:

        current_time += timedelta(
            hours=random.randint(1, 24)
        )

        events.append({
            "event_id": f"E{event_counter:08d}",
            "user_id": user_id,
            "event_timestamp": current_time,
            "event_type": "Onboarding_Started",
            "feature_name": None,
            "session_id": f"{user_id}_S{session_number:03d}",
            "revenue": 0
        })

        event_counter += 1


    
    # Onboarding Completed
   
    if journey["onboarding_completed"]:

        current_time += timedelta(
            hours=random.randint(1, 48)
        )

        session_number += 1

        events.append({
            "event_id": f"E{event_counter:08d}",
            "user_id": user_id,
            "event_timestamp": current_time,
            "event_type": "Onboarding_Completed",
            "feature_name": None,
            "session_id": f"{user_id}_S{session_number:03d}",
            "revenue": 0
        })

        event_counter += 1


    
    # Activated

    if journey["activated"]:

        current_time += timedelta(
            hours=random.randint(1, 72)
        )

        events.append({
            "event_id": f"E{event_counter:08d}",
            "user_id": user_id,
            "event_timestamp": current_time,
            "event_type": "Activated",
            "feature_name": None,
            "session_id": f"{user_id}_S{session_number:03d}",
            "revenue": 0
        })

        event_counter += 1


    # Feature usage

    if journey["feature_used"]:

        number_of_feature_events = random.randint(2, 8)

        for _ in range(number_of_feature_events):

            current_time += timedelta(
                hours=random.randint(1, 72)
            )

            feature = random.choice(features)

            session_number += 1

            events.append({
                "event_id": f"E{event_counter:08d}",
                "user_id": user_id,
                "event_timestamp": current_time,
                "event_type": "Feature_Used",
                "feature_name": feature,
                "session_id": f"{user_id}_S{session_number:03d}",
                "revenue": 0
            })

            event_counter += 1


   
    # Trial Started
   
    if journey["trial_started"]:

        current_time += timedelta(
            hours=random.randint(1, 72)
        )

        session_number += 1

        events.append({
            "event_id": f"E{event_counter:08d}",
            "user_id": user_id,
            "event_timestamp": current_time,
            "event_type": "Trial_Started",
            "feature_name": None,
            "session_id": f"{user_id}_S{session_number:03d}",
            "revenue": 0
        })

        event_counter += 1


    # Subscription Started
   
    if journey["paid"]:

        current_time += timedelta(
            days=random.randint(3, 14)
        )

        session_number += 1

        events.append({
            "event_id": f"E{event_counter:08d}",
            "user_id": user_id,
            "event_timestamp": current_time,
            "event_type": "Subscription_Started",
            "feature_name": None,
            "session_id": f"{user_id}_S{session_number:03d}",
            "revenue": random.choice([
                19.99,
                29.99,
                49.99
            ])
        })

        event_counter += 1


# Create event DataFrame

events_df = pd.DataFrame(events)


# Basic validation

print("\n===== EVENT DATA RESULTS =====")

print("Total events:", len(events_df))

print(
    "Unique users with events:",
    events_df["user_id"].nunique()
)

print("\nEvent type distribution:")
print(events_df["event_type"].value_counts())

print("\nMissing values:")
print(events_df.isnull().sum())


# Save events


events_df.to_csv(
    r"your file path",
    index=False
)

print("\nEvent dataset saved successfully.")