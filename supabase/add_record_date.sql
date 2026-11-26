-- Run once in Supabase: Dashboard -> SQL Editor -> New query -> paste -> Run.
-- Adds the date a record belongs to (can differ from when it was typed in).

alter table public.expenses add column if not exists record_date date;

-- Existing records: use the Hong Kong date they were entered on.
update public.expenses
set record_date = (created_at at time zone 'Asia/Hong_Kong')::date
where record_date is null;

-- New rows without a date fall back to today's Hong Kong date.
alter table public.expenses
  alter column record_date set default (now() at time zone 'Asia/Hong_Kong')::date;
