-- Catálogo de instrumentos de inversión (ETF y fondos) disponibles en la simulación
create table instruments (
    id               bigint generated always as identity primary key,
    name             varchar(200) not null,
    isin             char(12)     not null,
    ticker           varchar(20)  not null,
    -- Tipo de instrumento; los fondos tradicionales entran en la Fase 8
    instrument_type  varchar(20)  not null,
    -- Índice que replica (por ejemplo S&P 500); opcional
    tracked_index    varchar(100),
    -- Bolsa de cotización en código MIC (por ejemplo XETR)
    exchange_mic     char(4)      not null,
    -- Divisa de cotización en código ISO 4217 (por ejemplo EUR)
    currency         char(3)      not null,
    -- Emisor del instrumento (por ejemplo iShares)
    issuer           varchar(100) not null,
    -- Fecha y hora de alta en el catálogo
    created_at       timestamptz  not null default now(),
    constraint uq_instruments_isin_exchange unique (isin, exchange_mic),
    constraint ck_instruments_type check (instrument_type in ('ETF', 'FUND')),
    -- Formato ISIN: 2 letras de país, 9 alfanuméricos y 1 dígito de control
    constraint ck_instruments_isin_format check (isin ~ '^[A-Z]{2}[A-Z0-9]{9}[0-9]$')
);