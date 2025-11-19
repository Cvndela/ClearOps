------------------------------
-- ClearOps Database Schema --
------------------------------
DROP TABLE IF EXISTS risk_exceptions CASCADE;
DROP TABLE IF EXISTS positions CASCADE;
DROP TABLE IF EXISTS trades CASCADE;
DROP TABLE IF EXISTS markets CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-----------------
-- USERS TABLE --
-----------------
create table users (
    user_id     BIGINT PRIMARY KEY,
    username    TEXT NOT NULL
);

-------------------
-- MARKETS TABLE --
-------------------
create table markets (
    market_id   BIGINT PRIMARY KEY,
    name        TEXT NOT NULL,
    opens_at    TIMESTAMP NOT NULL,
    closes_at   TIMESTAMP NOT NULL,
    expiry      DATE NOT NULL,
    outcome     TEXT  -- NULL until market resolves
);

------------------
-- TRADES TABLE --
------------------
create table trades (
    trade_id       BIGINT PRIMARY KEY,
    user_id        BIGINT NOT NULL REFERENCES users(user_id),
    market_id      BIGINT NOT NULL REFERENCES markets(market_id),
    price          NUMERIC(6,4) NOT NULL,
    quantity       INT NOT NULL,
    contract_type  TEXT NOT NULL CHECK (contract_type IN ('YES','NO')),
    timestamp      TIMESTAMP NOT NULL
);

---------------------
-- POSITIONS TABLE --
---------------------
create table positions (
    position_id    BIGSERIAL PRIMARY KEY,
    user_id        BIGINT NOT NULL REFERENCES users(user_id),
    market_id      BIGINT NOT NULL REFERENCES markets(market_id),

    yes_position   INT DEFAULT 0,
    no_position    INT DEFAULT 0
);

---------------------------
-- RISK EXCEPTIONS TABLE --
---------------------------
create table risk_exceptions (
    exception_id   BIGSERIAL PRIMARY KEY,
    exception_type TEXT NOT NULL,
    description    TEXT NOT NULL,
    user_id        BIGINT,
    trade_id       BIGINT,
    market_id      BIGINT,
    detected_at    TIMESTAMP DEFAULT NOW()
);
