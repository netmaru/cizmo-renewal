-- CIZMO notices CMS — run once in Supabase SQL editor
create table if not exists public.notices (
  id uuid primary key default gen_random_uuid(),
  published_on date not null default current_date,
  category text not null default 'News',
  title_ja text not null,
  title_ko text,
  title_en text,
  url text,
  created_at timestamptz not null default now()
);

alter table public.notices enable row level security;

-- anyone can read
create policy "public read" on public.notices
  for select using (true);

-- only logged-in users (admin) can write
create policy "auth insert" on public.notices
  for insert to authenticated with check (true);
create policy "auth update" on public.notices
  for update to authenticated using (true);
create policy "auth delete" on public.notices
  for delete to authenticated using (true);

-- seed (optional)
insert into public.notices (published_on, category, title_ja, title_ko, title_en) values
  ('2026-07-01','AI','生成AIによる業務自動化（RPA）導入支援を開始','생성AI 업무자동화(RPA) 도입 지원 서비스 개시','Launched gen-AI office automation (RPA) support'),
  ('2026-06-20','NOMAD CAMP','『NOMAD CAMP』提供エリアを拡大','『NOMAD CAMP』제공 에리어 확대','NOMAD CAMP expands coverage');
