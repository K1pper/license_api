do $SCHEME$
declare
  main_role_name text = 'jubilee';
  main_user_name text = 'jub';
begin
  raise notice 'Updating schema...';

  if exists (select from pg_database where datname = 'master') then
    raise notice 'Database master already exists...';
  else
    create DATABASE master;
    raise notice 'Database master created...';
  end if;

  if exists (select from pg_roles where rolname = main_role_name and rolcanlogin = false) then
      raise notice 'Role % already exists...', main_role_name;
  else
    execute 'create role '||main_role_name||'';
    raise notice 'Role % created...', main_role_name;
  end if;

  grant connect on database master to jubilee;
  grant usage on schema public to jubilee;
  
  if exists (select from pg_roles where rolname = 'jub' and rolcanlogin = true) then
    raise notice 'Role jub already exists...';
  else
    create user jub with password 'password';
    raise notice 'Role jub created...';
  end if;

  grant jubilee to jub;

/**********************************************************************************************************************************************************************************
***********************************************************************************************************************************************************************************
**
**    Applications
**
***********************************************************************************************************************************************************************************
**********************************************************************************************************************************************************************************/

  if exists (select from information_schema.tables where table_schema = 'public' and table_name = 'applications' and table_type = 'BASE TABLE') then
    raise notice 'Table applications already exists...';
  else
  create table Applications (
    ApplicationId uuid primary key default gen_random_uuid(),  --non clustered...
    Name text not null default '',
    LicenceKey text not null default '',
    CreateDate timestamp not null default now(),  --utc is difficult - will this mess up my stuff?
    Suspended bool not null default false
  );
    execute 'grant all on applications to '||main_role_name;
  end if;

  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'AppVersion') then
    alter table applications add column AppVersion text not null default ''; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'CabVersion') then
    alter table applications add column CabVersion text not null default ''; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'WebVersion') then
    alter table applications add column WebVersion text not null default ''; end if;

/**********************************************************************************************************************************************************************************
***********************************************************************************************************************************************************************************
**
**    Customers
**
***********************************************************************************************************************************************************************************
**********************************************************************************************************************************************************************************/

  if exists (select from information_schema.tables where table_schema = 'public' and table_name = 'customers' and table_type = 'BASE TABLE') then
    raise notice 'Table customers already exists...';
  else
  create table customers (
    CustomerId uuid primary key default gen_random_uuid(),  --non clustered...
    Name text not null default '',
    LicenceKey text not null default '',
    CreateDate timestamp not null default now(),  
    Suspended bool not null default false
  );
    execute 'grant all on customers to '||main_role_name;
  end if;

/**********************************************************************************************************************************************************************************
***********************************************************************************************************************************************************************************
**
**    Customer Applications
**
***********************************************************************************************************************************************************************************
**********************************************************************************************************************************************************************************/

  if exists (select from information_schema.tables where table_schema = 'public' and table_name = 'customerapps' and table_type = 'BASE TABLE') then
    raise notice 'Table customerapps already exists...';
  else
  create table customerapps (
    CustomerAppId uuid primary key default gen_random_uuid(),  --non clustered...
    ApplicationId uuid not null,
    CustomerId uuid not null,
    LicenceKey text not null default '',
    CreateDate timestamp not null default now(),  
    Suspended bool not null default false
  );
    execute 'grant all on customerapps to '||main_role_name;
  end if;

end$SCHEME$;

do $SEED$
declare
  mfs_application_name text = 'Mobile Field Service';
  licensekey text;
begin
  licensekey = right('0000' || (trunc(random() * 9999 + 1))::text, 4) || '-' || 
               right('0000' || (trunc(random() * 9999 + 1))::text, 4) || '-' || 
               right('0000' || (trunc(random() * 9999 + 1))::text, 4) || '-' || 
               right('0000' || (trunc(random() * 9999 + 1))::text, 4) || '-' || 
               right('0000' || (trunc(random() * 9999 + 1))::text, 4) || '-' || 
               right('0000' || (trunc(random() * 9999 + 1))::text, 4) || '-' || 
               right('0000' || (trunc(random() * 9999 + 1))::text, 4) || '-' || 
               right('0000' || (trunc(random() * 9999 + 1))::text, 4) ;
  raise notice '%', licensekey;

  if not exists (select from applications where name = mfs_application_name) then 
    insert into applications (name, licencekey) values (mfs_application_name, licensekey); 
  end if;
end$SEED$;

select * from applications;
select * from customers;
select * from customerapps;
select * from users;
select * from userapplications;
select * from usercustomers;
select * from devices;

drop table applications;
drop table customers;
drop table customerapps;
drop table users;
drop table userapplications;
drop table usercustomers;
drop table devices;

drop role jub;
drop owned by jubilee;
drop role jubilee;