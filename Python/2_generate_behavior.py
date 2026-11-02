import pandas as pd
import random



# PART 2 ---BEHAVIORAL JOURNEY

# Keep results reproducible
random.seed(42)



# Load existing users

users_df = pd.read_csv(
    r"users csv file path"
)

print("Users loaded:", len(users_df))



# Behavioral probabilities

ONBOARDING_START_PROB = 0.90
ONBOARDING_COMPLETE_PROB = 0.75
ACTIVATION_PROB = 0.65
FEATURE_USE_PROB = 0.70
TRIAL_PROB = 0.40
PAID_PROB = 0.25


# Channel influence
channel_effect = {
    "Organic": 0.05,
    "Referral": 0.08,
    "Google Ads": 0.00,
    "Meta Ads": -0.04,
    "YouTube": -0.02
}


# Device influence

device_effect = {
    "Desktop": 0.04,
    "Mobile": 0.00,
    "Tablet": -0.02
}



# Generate journey

journeys = []

for _, user in users_df.iterrows():

    user_id = user["user_id"]

    channel = user["acquisition_channel"]
    device = user["device_type"]

    
    # 1. Onboarding started
    
    onboarding_started = (
        random.random() < ONBOARDING_START_PROB
    )

    
    # 2. Onboarding completed
   
    onboarding_completed = False

    if onboarding_started:

        probability = (
            ONBOARDING_COMPLETE_PROB
            + channel_effect[channel]
            + device_effect[device]
        )

        probability = max(0, min(probability, 1))

        onboarding_completed = (
            random.random() < probability
        )


    # 3. Activated
    
    activated = False

    if onboarding_completed:

        probability = (
            ACTIVATION_PROB
            + channel_effect[channel]
            + device_effect[device]
        )

        probability = max(0, min(probability, 1))

        activated = random.random() < probability

    
    # 4. Key feature used
  
    feature_used = False

    if activated:

        probability = (
            FEATURE_USE_PROB
            + channel_effect[channel]
            + device_effect[device]
        )

        probability = max(0, min(probability, 1))

        feature_used = random.random() < probability

    
    # 5. Trial started
   
    trial_started = False

    if feature_used:

        probability = (
            TRIAL_PROB
            + channel_effect[channel]
            + device_effect[device]
        )

        probability = max(0, min(probability, 1))

        trial_started = random.random() < probability

    
    # 6. Paid subscription
   
    paid = False

    if trial_started:

        probability = (
            PAID_PROB
            + channel_effect[channel]
            + device_effect[device]
        )

        probability = max(0, min(probability, 1))

        paid = random.random() < probability

  
    # Store journey
    
    journeys.append({
        "user_id": user_id,
        "onboarding_started": onboarding_started,
        "onboarding_completed": onboarding_completed,
        "activated": activated,
        "feature_used": feature_used,
        "trial_started": trial_started,
        "paid": paid
    })


# Create DataFrame

journey_df = pd.DataFrame(journeys)


# Basic validation

print("\n===== BEHAVIORAL JOURNEY RESULTS =====")

print("Total users:", len(journey_df))

print(
    "Onboarding started:",
    journey_df["onboarding_started"].sum()
)

print(
    "Onboarding completed:",
    journey_df["onboarding_completed"].sum()
)

print(
    "Activated:",
    journey_df["activated"].sum()
)

print(
    "Feature used:",
    journey_df["feature_used"].sum()
)

print(
    "Trial started:",
    journey_df["trial_started"].sum()
)

print(
    "Paid:",
    journey_df["paid"].sum()
)



# Save behavioral journey

journey_df.to_csv(
    r"user_journey csv file path",
    index=False
)

print("\nBehavioral journey saved successfully.")