drop table if exists hst_account;
drop table if exists hst_agreement;
drop table if exists hst_already_read;
drop table if exists hst_auth_user;
drop table if exists hst_balance;
drop table if exists hst_coin;
drop table if exists hst_company;
drop table if exists hst_notice;
drop table if exists hst_preference;
drop table if exists hst_receive_coin;
drop table if exists hst_send_coin;
drop table if exists hst_send_notice;
drop table if exists hst_staff;
drop table if exists hst_staff_role;
drop table if exists hst_strategy;
drop table if exists hst_strategy_symbol;
drop table if exists hst_system_parameter;
drop table if exists hst_withdrawal_address;
drop table if exists mst_bidding_price;
drop table if exists mst_cfd_grade;
drop table if exists mst_coin;
drop table if exists mst_deviation_fee;
drop table if exists mst_external_symbol;
drop table if exists mst_leverage_grade;
drop table if exists mst_staff_authority;
drop table if exists mst_symbol;
drop table if exists mst_system_parameter;
drop table if exists tbl_account;
drop table if exists tbl_agreement;
drop table if exists tbl_already_read;
drop table if exists tbl_auth_user;
drop table if exists tbl_balance;
drop table if exists tbl_company;
drop table if exists tbl_sequence;
drop table if exists tbl_staff;
drop table if exists tbl_staff_role;
drop table if exists tbl_products;


drop table if exists trn_login;

create table hst_auth_user (
  id            varchar(36)  not null,
  email         varchar(255),
  password      varchar(250),
  account_id    varchar(32)  not null,
  secret_key    varchar(4),
  login_failed  int4         not null,
  locked        boolean      not null,
  unlocked_date timestamp,
  status        varchar(24),
  deleted       boolean      not null,
  create_user   varchar(255) not null,
  create_time   timestamp    not null,
  update_user   varchar(255) not null,
  update_time   timestamp    not null,
  version       int8,
  primary key (id)
);

create table hst_staff (
  id               varchar(36)  not null,
  staff_id         varchar(50)  not null,
  name             varchar(128) not null,
  password         varchar(250) not null,
  email            varchar(255) not null,
  login_failed     int4         not null,
  locked           boolean      not null,
  unlocked_date    timestamp,
  default_language varchar(10)  not null,
  role_id          varchar(50)  not null,
  deleted          boolean      not null,
  create_user      varchar(255) not null,
  create_time      timestamp    not null,
  update_user      varchar(255) not null,
  update_time      timestamp    not null,
  version          int8,
  primary key (id)
);
create table hst_staff_role (
  id           varchar(36)  not null,
  role_id      varchar(50)  not null,
  authority_id varchar(50)  not null,
  deleted      boolean      not null,
  create_user  varchar(255) not null,
  create_time  timestamp    not null,
  update_user  varchar(255) not null,
  update_time  timestamp    not null,
  version      int8,
  primary key (id)
);
create table hst_system_parameter (
  id          varchar(36)  not null,
  param_key   varchar(255),
  param_value varchar(255),
  deleted     boolean      not null,
  create_user varchar(255) not null,
  create_time timestamp    not null,
  update_user varchar(255) not null,
  update_time timestamp    not null,
  version     int8,
  primary key (id)
);
create table mst_staff_authority (
  id           varchar(36)  not null,
  authority_id varchar(50)  not null,
  description  text         not null,
  deleted      boolean      not null,
  create_user  varchar(255) not null,
  create_time  timestamp    not null,
  update_user  varchar(255) not null,
  update_time  timestamp    not null,
  version      int8,
  primary key (id)
);
create table mst_system_parameter (
  id          varchar(36)  not null,
  param_key   varchar(255) not null,
  param_value varchar(255),
  deleted     boolean      not null,
  create_user varchar(255) not null,
  create_time timestamp    not null,
  update_user varchar(255) not null,
  update_time timestamp    not null,
  version     int8,
  primary key (id)
);

create table tbl_account (
  id                         varchar(36)  not null,
  account_id                 varchar(32)  not null,
  company_code               varchar(50),
  sub_id                     varchar(50),
  group_id                   int4         not null,
  nationality                varchar(3),
  full_name                  varchar(255),
  gender                     varchar(10),
  birth_day                  date,
  country                    varchar(3),
  postal_code                varchar(50),
  state_province             varchar(255),
  city                       varchar(255),
  street                     varchar(255),
  building                   varchar(255),
  unit                       varchar(24),
  phone_number               varchar(24),
  certificate1_type          varchar(50),
  certificate1_picture1      text,
  certificate1_picture2      text,
  certificate2_type          varchar(50),
  certificate2_picture1      text,
  certificate2_picture2      text,
  selfie                     text,
  password_written_in_letter varchar(8),
  received_letter_flag       boolean      not null,
  mfa_setting                varchar(9),
  mfa_seed                   varchar(40),
  enable_cfd_trading         boolean      not null,
  enable_future_trading      boolean      not null,
  enable_spot_trading        boolean      not null,
  leverage_grade             varchar(10)  not null,
  deposit_grade              varchar(10)  not null,
  withdraw_grade             varchar(10)  not null,
  cfd_grade                  varchar(10)  not null,
  future_grade               varchar(10)  not null,
  spot_grade                 varchar(10)  not null,
  basic_information_check    varchar(10)  not null,
  certificate_check          varchar(10)  not null,
  residence_check            varchar(10)  not null,
  leave                      boolean      not null,
  deleted                    boolean      not null,
  create_user                varchar(255) not null,
  create_time                timestamp    not null,
  update_user                varchar(255) not null,
  update_time                timestamp    not null,
  version                    int8,
  primary key (id)
);

create table tbl_auth_user (
  id            varchar(36)  not null,
  email         varchar(255),
  password      varchar(250),
  account_id    varchar(32)  not null,
  secret_key    varchar(4),
  login_failed  int4         not null,
  locked        boolean      not null,
  unlocked_date timestamp,
  status        varchar(24),
  deleted       boolean      not null,
  create_user   varchar(255) not null,
  create_time   timestamp    not null,
  update_user   varchar(255) not null,
  update_time   timestamp    not null,
  version       int8,
  primary key (id)
);
create table tbl_company (
  id          varchar(36)  not null,
  code        varchar(50)  not null,
  name        varchar(255) not null,
  deleted     boolean      not null,
  create_user varchar(255) not null,
  create_time timestamp    not null,
  update_user varchar(255) not null,
  update_time timestamp    not null,
  version     int8,
  primary key (id)
);

create table tbl_staff (
  id               varchar(36)  not null,
  staff_id         varchar(50)  not null,
  name             varchar(128) not null,
  password         varchar(250) not null,
  email            varchar(255) not null,
  login_failed     int4         not null,
  locked           boolean      not null,
  unlocked_date    timestamp,
  default_language varchar(10)  not null,
  role_id          varchar(50)  not null,
  deleted          boolean      not null,
  create_user      varchar(255) not null,
  create_time      timestamp    not null,
  update_user      varchar(255) not null,
  update_time      timestamp    not null,
  version          int8,
  primary key (id)
);
create table tbl_staff_role (
  id           varchar(36)  not null,
  role_id      varchar(50)  not null,
  authority_id varchar(50)  not null,
  deleted      boolean      not null,
  create_user  varchar(255) not null,
  create_time  timestamp    not null,
  update_user  varchar(255) not null,
  update_time  timestamp    not null,
  version      int8,
  primary key (id)
);

create table tbl_products (
  id  varchar(36)  not null,
  distributor_id varchar(191) not null,
  brand_name varchar(191) not null,
  product_name varchar(191) not null,
  general_price bigint not null,
  price_amount_1 bigint DEFAULT NULL ,
  price_amount_2to10 bigint DEFAULT NULL,
  price_amount_11to20 bigint DEFAULT NULL ,
  price_amount_21to30 bigint DEFAULT NULL,
  price_amount_31to40 bigint DEFAULT NULL,
  price_amount_41to50 bigint DEFAULT NULL,
  price_amount_51to60 bigint DEFAULT NULL,
  price_amount_61to70 bigint DEFAULT NULL,
  price_amount_71to80 bigint DEFAULT NULL,
  price_amount_81to90 bigint DEFAULT NULL,
  price_amount_91to100 bigint DEFAULT NULL,
  image_url_1 varchar(191) not null,
  image_url_2 varchar(191) DEFAULT NULL,
  image_url_3 varchar(191) DEFAULT NULL,
  image_url_4 varchar(191) DEFAULT NULL,
  image_url_5 varchar(191) DEFAULT NULL,
  product_lp_url varchar(191) DEFAULT NULL,
  youtube_url varchar(191) DEFAULT NULL,
  discription varchar(3000) not null,
  product_number varchar(100) not null,
  introduction varchar(1000) DEFAULT null,
  announce_date datetime not null,
  start_date datetime not null,
  finish_date datetime not null,
  delivery_schedule date not null,
  sub_category_id bigint not null,
  product_total_amount integer not null,
  product_sold_total_amount integer not null,
  transporter_id bigint not null '1',
  tax smallint not null,
  current_price bigint NOT NULL DEFAULT '0' ,
  limit_item boolean NOT NULL,
  limit_quantity integer DEFAULT NULL,
  off_shelf boolean NOT NULL,
  registration_date date NOT NULL,
  settlement_date datetime DEFAULT NULL,
  population boolean NOT NULL,
  population_modify_datetime datetime NOT NULL,
  primary key (id)
) ;

create table trn_login (
  id          varchar(36)  not null,
  email       varchar(255),
  ip_address  varchar(255),
  agent       text,
  jti         varchar(36),
  location    varchar(128) not null,
  deleted     boolean      not null,
  create_user varchar(255) not null,
  create_time timestamp    not null,
  update_user varchar(255) not null,
  update_time timestamp    not null,
  version     int8,
  primary key (id)
);
create table trn_order_status (
  id            varchar(36)  not null,
  account_id    varchar(32)  not null,
  strategy_id   int4         not null,
  ord_status    varchar(24)  not null,
  symbol        varchar(10)  not null,
  side          varchar(10)  not null,
  price         decimal      not null,
  order_qty     decimal      not null,
  post_only     boolean      not null,
  time_in_force varchar(10),
  expire_date   timestamp,
  close_target  varchar(36),
  leverage      decimal      not null,
  ord_type      varchar(24)  not null,
  pending       boolean      not null,
  leaves_qty    decimal      not null,
  cum_qty       decimal      not null,
  avg_px        decimal      not null,
  amount        decimal      not null,
  transact_time timestamp    not null,
  receive_time  timestamp    not null,
  deleted       boolean      not null,
  create_user   varchar(255) not null,
  create_time   timestamp    not null,
  update_user   varchar(255) not null,
  update_time   timestamp    not null,
  version       int8,
  primary key (id)
);
