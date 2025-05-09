create table reservations (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references auth.users(id),
  property_id text not null,
  status text not null,
  created_at timestamp with time zone default now()
); 