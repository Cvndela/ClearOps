RCA #3 – Settlement Mismatch (Outcome vs Exposure Conflict)
Incident Category: Clearing Integrity / Settlement Validation
Exception Count: 3 cases
Sample Rows:
- user_id 167, market_id 6
- user_id 182, market_id 6
- user_id 284, market_id 6

All detected at: 2025-11-18 20:36:27.479844.

Executive Summary

ClearOps identified 3 cases where user exposure was inconsistent with the final market outcome. Although infrequent, settlement mismatches represent one of the most critical risk factors in exchange operations and clearing.

Issue Description
The settlement engine checks:
- If market outcome = “YES”, but user holds significant NO exposure
- If market outcome = “NO”, but user holds significant YES exposure

Threshold: >20 contracts
Market 6 was the only market with injected mismatches.

These users held structurally incorrect exposures relative to final settlement state.

Impact Analysis
- Incorrect customer P/L
- Settlement fund misallocation
- Potential for customer disputes
- Clearing capital misestimation
- Risk-weighted asset distortion

Even with only 3 occurrences, the severity is high.

Root Cause
The anomaly injection script intentionally flipped outcomes for Market 6, creating mismatches where exposures should not align.

This mimics real incidents such as:
- Delayed settlement updates
- Incorrect market state ingestion
- Partial event processing during cutoff windows

Contributing Factors
- Missing post-settlement reconciliation pass
- No cross-check with trade history
- Lack of double-entry settlement rules

Corrective Actions
- Require post-settlement reconciliation before publishing outcomes.
- Add cross-check between exposure table and market outcome state.
- Enforce dual confirmation before settlement state is committed.

Preventive Controls
- Introduce settlement pipeline validation
- Add market-level finality checks
- Include exposure-consistency tests in clearing engine
