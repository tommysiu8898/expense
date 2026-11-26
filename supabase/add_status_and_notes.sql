-- Run once in Supabase: Dashboard -> SQL Editor -> New query -> paste -> Run.
-- Adds credit card payment status and a notes field to the main table.

alter table public.expenses add column if not exists status text;
alter table public.expenses add column if not exists notes  text;

-- Existing credit card records start as unpaid.
update public.expenses
set status = '未還款'
where type = 'Credit Card' and status is null;


-- ---------------------------------------------------------------------------
-- OPTIONAL: copy records that were entered through the old add.html page.
-- add.html saved into three separate tables (expense, income, credit_cards),
-- which the main page never showed. Only run the blocks for tables that
-- actually exist in your project (check Table Editor first), and run each
-- block only once or you will get duplicates.
-- ---------------------------------------------------------------------------

-- insert into public.expenses (type, amount, category, status, created_at)
-- select 'Credit Card', bill_amount, card_name, coalesce(status, '未還款'), created_at
-- from public.credit_cards;

-- insert into public.expenses (type, amount, category, notes, created_at)
-- select 'Income', amount, category, description, created_at
-- from public.income;

-- add.html stored the expense "Notes" field in a column called currency.
-- insert into public.expenses (type, amount, category, notes, created_at)
-- select 'Expense', amount, category, currency, created_at
-- from public.expense;
