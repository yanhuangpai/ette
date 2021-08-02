-- Note : This file is never going to be used by `ette`
--
-- This is provided more sake of better human readability

create table blocks (
    hash char(66) PRIMARY KEY,
    number varchar(255)NOT NULL UNIQUE,
    time bigint NOT NULL,
    parenthash char(66) NOT NULL,
    difficulty varchar(255) NOT NULL,
    gasused bigint NOT NULL,
    gaslimit bigint NOT NULL,
    nonce varchar(255) NOT NULL,
    miner char(42) NOT NULL,
    size float(8) NOT NULL,
    stateroothash char(66) NOT NULL,
    unclehash char(66) NOT NULL,
    txroothash char(66) NOT NULL,
    receiptroothash char(66) NOT NULL,
    extradata BLOB
);

create index on blocks(number asc);
create index on blocks(time asc);

create table transactions (
    hash char(66) PRIMARY KEY,
    `from` char(42) NOT NULL,
    `to` char(42),
    contract char(42),
    value varchar(255),
    data BLOB,
    gas bigint NOT NULL,
    gasprice varchar(255) NOT NULL,
    cost varchar(255) NOT NULL,
    nonce bigint NOT NULL,
    state smallint NOT NULL,
    blockhash char(66) NOT NULL
);

create index on transactions(from);
create index on transactions(to);
create index on transactions(contract);
create index on transactions(nonce);
create index on transactions(blockhash);

create table events (
    origin char(42) NOT NULL,
    `index` bigint NOT NULL,
    topics text(16) NOT NULL,
    data BLOB,
    txhash char(66) NOT NULL,
    blockhash char(66) NOT NULL
);

create index on events(origin);
create index on events(txhash);
create index on events using gin(topics);

create table users (
    address char(42) NOT NULL,
    apikey char(66) PRIMARY KEY,
    ts timestamp NOT NULL,
    enabled boolean default true
);

create index on users(address);

create table delivery_history (
    id uuid DEFAULT uuid() PRIMARY KEY,
    client char(42) NOT NULL,
    ts timestamp NOT NULL,
    endpoint varchar(255)(100) NOT NULL,
    datalength bigint NOT NULL
);

create index on delivery_history(client);
create index on delivery_history(ts asc);

create table subscription_plans (
    id serial PRIMARY KEY,
    name varchar(255)(20) NOT NULL UNIQUE,
    deliverycount bigint NOT NULL UNIQUE
);

create table subscription_details (
    address char(42) PRIMARY KEY,
    subscriptionplan int NOT NULL
);

create index on subscription_details(subscriptionplan);
