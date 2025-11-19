RCA #2 – Conflicting Positions (Directional Exposure Conflict)
Incident Category: Exposure Integrity / Position Limit Breach
Exception Count: 33 cases
Sample Rows:
- user_id 144, market_id 8
- user_id 12, market_id 3
- user_id 87, market_id 5

All detected at: 2025-11-18 20:36:27.463592.

Executive Summary
The surveillance system identified 33 instances where users held both YES and NO exposure above threshold in the same market. This represents directional conflict and violates standard exposure modeling assumptions for event-based markets.

Issue Description
The position engine flagged cases where:
- yes_position > 20 AND
- no_position > 20

This indicates directional overexposure, common in:
- Hedging misconfigurations
- High-frequency strategy drift
- Incorrect client order routing

Duplicate ingestion of inbound trades

- Users 144, 12, and 87 are representative samples with exposure conflicts spanning multiple markets.

Impact Analysis
- Artificial inflation of open interest
- Distorted user-level risk scoring
- Increased capital requirements
- Inconsistent clearing behavior
- Potential for settlement disputes if exposure appears mismatched

Root Cause
- The source dataset introduces deliberate conflict scenarios through synthetic generation:
- Randomized direction assignment
- No enforcement preventing immediate offsetting trades
- Jittered quantities that may stack unintentionally

Contributing Factors
- Absence of pre-trade risk checks (common in real trading venues)
- No exposure caps during generation
- Lack of self-cross prevention logic

Corrective Actions
- Add exposure caps aligned with market liquidity.
- Introduce side-consistency checks.
- Add throttling for rapid direction flips.

Preventive Controls
- Implement pre-trade risk checks
- Add circuit breakers for directional drift
- Continuous monitor of YES/NO distribution per user
