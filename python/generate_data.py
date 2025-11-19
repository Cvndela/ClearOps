import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import random
import os

# Create /data directory if it doesn't exist
os.makedirs("../data", exist_ok=True)

# -------------------------------
# 1. Generate MARKETS
# -------------------------------

market_names = [
    "Will it rain in NYC tomorrow?",
    "Will CPI exceed expectations?",
    "Will unemployment fall next month?",
    "Will Bitcoin exceed 60k?",
    "Will the S&P 500 close higher?",
    "Will home sales increase?",
    "Will initial jobless claims drop?",
    "Will gold close above $2,500?",
    "Will ETH outperform BTC?",
    "Will GDP beat forecasts?"
]

markets = []
market_id = 1

for name in market_names:
    # Expiry is between 5–10 days from now
    expiry = datetime.now() + timedelta(days=random.randint(5, 10))

    # opens_at: exchange begins trading 2 days before expiry
    opens_at = expiry - timedelta(days=2)

    # closes_at: last trading moment is 1 hour before expiry
    closes_at = expiry - timedelta(hours=1)

    markets.append([
        market_id,
        name,
        opens_at.isoformat(),
        closes_at.isoformat(),
        expiry.date().isoformat(),
        ""
    ])

    market_id += 1

markets_df = pd.DataFrame(markets, columns=[
    "market_id", "name", "opens_at", "closes_at", "expiry", "outcome"
])
markets_df.to_csv("../data/markets.csv", index=False)

# -------------------------------
# 2. Generate USERS
# -------------------------------

users = []
for i in range(1, 301):  # 300 users
    balance = round(random.uniform(50, 5000), 2)
    users.append([i, f"user_{i}", balance])

users_df = pd.DataFrame(users, columns=["user_id", "username", "cash_balance"])
users_df.to_csv("../data/users.csv", index=False)


# -------------------------------
# 3. Generate TRADES
# -------------------------------

start_date = datetime.now() - timedelta(days=3)

trades = []
trade_id = 1

for _ in range(2500):  # 2500 trades
    user_id = random.randint(1, 300)
    market_id = random.randint(1, len(market_names))
    contract = random.choice(["YES", "NO"])
    price = round(random.uniform(0.05, 0.95), 2)
    quantity = random.randint(1, 25)

    # Random timestamp within 3-day window
    timestamp = start_date + timedelta(
        minutes=random.randint(1, 3 * 24 * 60)  # 3 days worth of minutes
    )

    trades.append([
        trade_id,
        user_id,
        market_id,
        contract,
        price,
        quantity,
        timestamp.isoformat()
    ])

    trade_id += 1

trades_df = pd.DataFrame(trades, columns=[
    "trade_id", "user_id", "market_id", "contract_type",
    "price", "quantity", "timestamp"
])
trades_df.to_csv("../data/trades.csv", index=False)

print("Data generation complete! CSVs saved in /data")

