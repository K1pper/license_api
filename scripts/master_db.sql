/*
  First create a GHALicensePortal database
*/

use master;

do $SCHEME$
declare
  _database tex = 'GHALicensePortal';
  _role_name text = 'jubilee';
  _user_name text = 'jub';
begin
  raise notice 'Updating schema...';

  if exists (select from pg_roles where rolname = _role_name and rolcanlogin = false) then
      raise notice 'Role % already exists...', _role_name;
  else
    execute 'create role '||_role_name||'';
    raise notice 'Role % created...', _role_name;
  end if;

  grant connect on database master to jubilee;
  grant usage on schema public to jubilee;
  
  if exists (select from pg_roles where rolname = _user_name and rolcanlogin = true) then
    raise notice 'Role % already exists...', _user_name;
  else
    execute 'create user '||_user_name||' with password ''password''';
    raise notice 'Role % created...', _user_name;
  end if;

  execute 'grant '||_role_name||' to '||_user_name;

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
  create index application_name ON Applications(Name);
    execute 'grant all on applications to '||main_role_name;
  end if;

  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'AppVersion') then
    alter table applications add column AppVersion text not null default ''; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'CabVersion') then
    alter table applications add column CabVersion text not null default ''; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'WebVersion') then
    alter table applications add column WebVersion text not null default ''; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'AppStoreUrl') then
    alter table applications add column AppStoreUrl text not null default ''; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'PlayStoreUrl') then
    alter table applications add column PlayStoreUrl text not null default ''; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'BrochureUrl') then
    alter table applications add column BrochureUrl text not null default ''; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'Icon') then
    alter table applications add column Icon text not null default ''; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'TermsUrl') then
    alter table applications add column TermsUrl text not null default ''; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'ShowSettings') then
    alter table applications add column ShowSettings boolean not null default false; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'WikiLinks') then
    alter table applications add column WikiLinks boolean not null default false; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'IsSession') then
    alter table applications add column IsSession boolean not null default false; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'SessionParameter') then
    alter table applications add column SessionParameter text not null default ''; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'HideIfNotLicensed') then
    alter table applications add column HideIfNotLicensed boolean not null default false; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'SendCabEmail') then
    alter table applications add column SendCabEmail boolean not null default false; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'SendUpdateEmail') then
    alter table applications add column SendUpdateEmail boolean not null default false; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'SendUserGuidesEmail') then
    alter table applications add column SendUserGuidesEmail boolean not null default false; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'SendAPIImprovementsEmail') then
    alter table applications add column SendAPIImprovementsEmail boolean not null default false; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'SendFieldCabEmail') then
    alter table applications add column SendFieldCabEmail boolean not null default false; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'SendParamScreen') then
    alter table applications add column SendParamScreen boolean not null default false; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'SendWebEmail') then
    alter table applications add column SendWebEmail boolean not null default false; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'VersionBAQ') then
    alter table applications add column VersionBAQ text not null default ''; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'WebVersion') then
    alter table applications add column WebVersion text not null default ''; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'ImageData') then
    alter table applications add column ImageData text not null default ''; end if;
  if not exists (select from information_schema.columns where table_schema = 'public' and table_name = 'applications' and column_name = 'AppVersion') then
    alter table applications add column AppRelease date null; end if;

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
