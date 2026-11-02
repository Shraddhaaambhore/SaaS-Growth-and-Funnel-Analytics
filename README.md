# SaaS Growth & Funnel Analytics

## Project Overview
Analyzed a synthetic SaaS product dataset to understand user acquisition, onboarding, product engagement, and paid conversion. Used Python for data generation and validation, PostgreSQL for SQL-based analysis, and Power BI to build interactive dashboards.

## Business Objectives
- Evaluate the user journey from signup to paid subscription.
- Identify conversion drop-offs across the funnel.
- Compare acquisition channel performance.
- Understand product feature usage and its relationship with paid conversion.
- Explore user activity and engagement patterns.

## Tools & Technologies
- **Python:** Data generation, inspection, and validation using pandas.
- **PostgreSQL:** Data storage, validation, and business analysis using SQL.
- **Power BI:** Interactive dashboards and visual analysis.

## Dataset
The project uses a synthetic dataset containing:
- `users` — 100,000 records
- `user_journey` — 100,000 records
- `events` — 494,097 records

## Key Findings
- Overall signup-to-paid conversion was **4.21%**.
- The largest user loss by count occurred between onboarding completion and activation: **22,821 users**.
- The highest percentage drop-off occurred between trial start and paid subscription: **71.55%**.
- Referral had the highest signup-to-paid conversion at **7.34%**, while Meta Ads had the lowest at **2.17%**.
- Analytics had the highest paid conversion among the analyzed features at **12.66%**.
- **33.66%** of users had a feature-use event on a later calendar date within seven days of signup. This is a project-specific activity measure, not strict Day-7 retention.

## Power BI Dashboards

### Dashboard 1 — Growth & Conversion Analysis
![Growth & Conversion Analysis](Power%20BI/dasboard_2_Growth%20%26%20Conversion%20Analysis..png)

### Dashboard 2 — User Engagement & Conversion Insights
![User Engagement & Conversion Insights](Power%20BI/dashboard_1_Interactive%20User%20%26%20Product%20Exploration.png)

## Repository Structure
- `Python/` — Data generation scripts
- `SQL/` — SQL analysis files
- `data/` — CSV datasets
- `Power BI/` — Power BI report and dashboard screenshots

## Important Note
This project uses synthetic data and is intended for portfolio and analytical demonstration. The findings represent patterns in the generated dataset; they should not be interpreted as actual company performance or causal relationships.