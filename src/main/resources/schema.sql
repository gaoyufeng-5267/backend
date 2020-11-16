drop table if exists mst_prefectures;
drop table if exists tbl_delivery_addresses;
drop table if exists tbl_shipping_fee;
drop table if exists tbl_products;
drop table if exists tbl_images;
drop table if exists trn_images;
drop table if exists trn_product_category;
drop table if exists trn_product_tag;
drop table if exists tbl_distrib_products;
drop table if exists tbl_sales_products;
drop table if exists tbl_sales_products_sku;
drop table if exists tbl_sales_price_maps;
drop table if exists hst_products;
drop table if exists tbl_order;
drop table if exists tbl_order_detail;
drop table if exists mst_sku;
drop table if exists trn_category_sku;
drop table if exists trn_product_sku;
drop table if exists trn_settlement;
drop table if exists mst_toa_staffs;
drop table if exists mst_toa_screens;
drop table if exists mst_toa_manages;
drop table if exists mst_distributors;
drop table if exists mst_distributor_staffs;
drop table if exists mst_distributor_screens;
drop table if exists mst_distributor_manages;
drop table if exists mst_members;
drop table if exists tbl_creditcard;
drop table if exists tbl_withdrawal;
drop table if exists mst_banners;
drop table if exists mst_categories;
drop table if exists mst_tags;
drop table if exists mst_tax;
drop table if exists mst_mails;
drop table if exists mst_terms_use;
drop table if exists tbl_privacy_policy;
drop table if exists tbl_like;
drop table if exists tbl_forbidden;
drop table if exists tbl_distributor_csv_items;

-- 県名
CREATE TABLE mst_prefectures (
     prefecture_id   varchar(32)  NOT NULL
    ,prefecture_name varchar(64)  NOT NULL
    ,create_user     varchar(32)  NOT NULL
    ,create_time     timestamp     DEFAULT now() NOT NULL
    ,update_user     varchar(32)  NOT NULL
    ,update_time     timestamp     DEFAULT now() NOT NULL
    ,version         int8     DEFAULT 1 NOT NULL
    ,PRIMARY KEY(prefecture_id)
);

-- 届き先
CREATE TABLE tbl_delivery_addresses (
     delivery_id       varchar(32)    NOT NULL
    ,member_code       varchar(32)    NOT NULL
    ,post_code_front   varchar(10)    NOT NULL
    ,post_code_back    varchar(10)    NOT NULL
    ,prefecture_id     varchar(32)    NOT NULL
    ,city              varchar(128)   NOT NULL
    ,address1          varchar(1024)  NOT NULL
    ,last_name         varchar(64)    NOT NULL
    ,first_name        varchar(64)    NOT NULL
    ,last_name_kana    varchar(64)    NOT NULL
    ,first_name_kana   varchar(64)    NOT NULL
    ,company_name      varchar(256)   NOT NULL
    ,phone_number      varchar(32)    NOT NULL
    ,defualt_address   boolean         DEFAULT False NOT NULL
    ,create_user       varchar(32)    NOT NULL
    ,create_time       timestamp       DEFAULT now() NOT NULL
    ,update_user       varchar(32)    NOT NULL
    ,update_time       timestamp       DEFAULT now() NOT NULL
    ,version           int8       DEFAULT 1 NOT NULL
    ,PRIMARY KEY(delivery_id)
);

-- 送料
CREATE TABLE tbl_shipping_fee (
     shipping_fes_id        varchar(32)   NOT NULL
    ,distributor_id         varchar(32)   NOT NULL
    ,shipping_pattern       smallint       NOT NULL
    ,shipping__pattern_name varchar(512)  NOT NULL
    ,prefecture_id          varchar(32)  NOT NULL
    ,fee                    bigint     NOT NULL
    ,create_user            varchar(32)   NOT NULL
    ,create_time            timestamp      DEFAULT now() NOT NULL
    ,update_user            varchar(32)   NOT NULL
    ,update_time            timestamp      DEFAULT now() NOT NULL
    ,version                int8      DEFAULT 1 NOT NULL
    ,PRIMARY KEY(shipping_fes_id)
);

-- 商品
CREATE TABLE tbl_products (
     product_id       varchar(32)    NOT NULL
    ,product_code     varchar(32)    NOT NULL
    ,product_number   varchar(64)    NOT NULL
    ,jan_code         varchar(20)
    ,product_nane     varchar(32)    NOT NULL
    ,brand_name       varchar(512)
    ,general_price    bigint     NOT NULL
    ,product_lp_url   varchar(1024)
    ,youtube_url      varchar(1024)
    ,introduction_seo varchar(1024)
    ,introduction     varchar(4096)  NOT NULL
    ,product_info     varchar(4096)
    ,tax_id           varchar(32)    NOT NULL
    ,create_user      varchar(32)    NOT NULL
    ,create_time      timestamp       DEFAULT now() NOT NULL
    ,update_user      varchar(32)    NOT NULL
    ,update_time      timestamp       DEFAULT now() NOT NULL
    ,version          int8        DEFAULT 1 NOT NULL
    ,PRIMARY KEY(product_id)
);

-- 画像
CREATE TABLE tbl_images (
     image_id            varchar(32)   DEFAULT 1 NOT NULL
    ,image_original_name varchar(64)   NOT NULL
    ,image_middle_name   varchar(64)   NOT NULL
    ,image_small_name    varchar(64)   NOT NULL
    ,image_original_path varchar(512)  NOT NULL
    ,image_middle_path   varchar(512)  NOT NULL
    ,image_small_path    varchar(512)  NOT NULL
    ,create_time         timestamp      DEFAULT now() NOT NULL
    ,update_user         varchar(32)   NOT NULL
    ,update_time         timestamp      DEFAULT now() NOT NULL
    ,version             int8      DEFAULT 1 NOT NULL
    ,PRIMARY KEY(image_id)
);

-- 商品画像
CREATE TABLE trn_images (
     product_image_id varchar(32)  NOT NULL
    ,product_id       varchar(32)  NOT NULL
    ,image_id         varchar(32)  NOT NULL
    ,show_order       smallint     NOT NULL
    ,create_user      varchar(32)  NOT NULL
    ,create_time      timestamp     DEFAULT now() NOT NULL
    ,update_user      varchar(32)  NOT NULL
    ,update_time      timestamp     DEFAULT now() NOT NULL
    ,version          int8     DEFAULT 1 NOT NULL
    ,PRIMARY KEY(product_image_id)
);

-- 商品カテゴリ
CREATE TABLE trn_product_category (
     produce_cotegory_id varchar(32)  DEFAULT 1 NOT NULL
    ,product_id          varchar(32)  NOT NULL
    ,category_id         varchar(32)  NOT NULL
    ,create_user         varchar(32)  NOT NULL
    ,create_time         timestamp     DEFAULT now() NOT NULL
    ,update_user         varchar(32)  NOT NULL
    ,update_time         timestamp     DEFAULT now() NOT NULL
    ,version             int8     DEFAULT 1 NOT NULL
    ,PRIMARY KEY(produce_cotegory_id)
);

-- 商品タグ
CREATE TABLE trn_product_tag (
     produce_tag_id varchar(32)  NOT NULL
    ,product_id     varchar(32)  NOT NULL
    ,tag_id         varchar(32)  NOT NULL
    ,create_user    varchar(32)  NOT NULL
    ,create_time    timestamp     DEFAULT now() NOT NULL
    ,update_user    varchar(32)  NOT NULL
    ,update_time    timestamp     DEFAULT now() NOT NULL
    ,version        int8     DEFAULT 1 NOT NULL
    ,PRIMARY KEY(produce_tag_id)
);

-- 出品者の商品
CREATE TABLE tbl_distrib_products (
     distrib_products_id varchar(36)  NOT NULL
    ,distributor_id      varchar(32)  NOT NULL
    ,product_id          varchar(32)  NOT NULL
    ,create_user         varchar(32)  NOT NULL
    ,create_time         timestamp     DEFAULT now() NOT NULL
    ,update_user         varchar(32)  NOT NULL
    ,update_time         timestamp     DEFAULT now() NOT NULL
    ,version             int8     DEFAULT 1 NOT NULL
    ,PRIMARY KEY(distrib_products_id)
);

-- 出品
CREATE TABLE tbl_sales_products (
     sales_id                  varchar(32)  NOT NULL
    ,distributor_id            varchar(32)  NOT NULL
    ,product_id                varchar(32)  NOT NULL
    ,announce_date             timestamp     NOT NULL
    ,start_date                timestamp     NOT NULL
    ,finish_date               timestamp     NOT NULL
    ,delivery_schedule         timestamp
    ,product_total_amount      bigint    NOT NULL
    ,product_sold_total_amount bigint    NOT NULL
    ,off_shelf                 boolean       DEFAULT True NOT NULL
    ,limit_flag                boolean       DEFAULT false NOT NULL
    ,limit_amount              bigint
    ,current_price             bigint    NOT NULL
    ,create_user               varchar(32)  NOT NULL
    ,create_time               timestamp     DEFAULT now() NOT NULL
    ,update_user               varchar(32)  NOT NULL
    ,update_time               timestamp     DEFAULT now() NOT NULL
    ,version                   int8     DEFAULT 1 NOT NULL
    ,PRIMARY KEY(sales_id)
);

-- 出品SKU
CREATE TABLE tbl_sales_products_sku (
     sales_sku_id              varchar(32)  NOT NULL
    ,sales_id                  varchar(32)  NOT NULL
    ,sku_group                 text
    ,product_total_amount      bigint    NOT NULL
    ,product_sold_total_amount bigint    NOT NULL
    ,create_user               varchar(32)  NOT NULL
    ,create_time               timestamp     DEFAULT now() NOT NULL
    ,update_user               varchar(32)  NOT NULL
    ,update_time               timestamp     DEFAULT now() NOT NULL
    ,version                   int8     DEFAULT 1 NOT NULL
    ,PRIMARY KEY(sales_sku_id)
);

-- 出品値引き
CREATE TABLE tbl_sales_price_maps
 (
     sales_price_id varchar(32)  NOT NULL
    ,sales_id       varchar(32)  NOT NULL
    ,product_id     varchar(32)   NOT NULL
    ,amount         bigint    NOT NULL
    ,percent        bigint     NOT NULL
    ,create_user    varchar(32)  NOT NULL
    ,create_time    timestamp     DEFAULT now() NOT NULL
    ,update_user    varchar(32)  NOT NULL
    ,update_time    timestamp     DEFAULT now() NOT NULL
    ,version        int8     DEFAULT 1 NOT NULL
    ,PRIMARY KEY(sales_price_id)
);

-- 商品履歴（出品用）
CREATE TABLE hst_products (
     product_history_id varchar(32)  NOT NULL
    ,sales_id           varchar(32)  NOT NULL
    ,product_info       text
    ,sales_info         text
    ,last_flag          boolean       DEFAULT True
    ,create_user        varchar(32)  NOT NULL
    ,create_time        timestamp     DEFAULT now() NOT NULL
    ,update_user        varchar(32)  NOT NULL
    ,update_time        timestamp     DEFAULT now() NOT NULL
    ,version            int8     DEFAULT 1 NOT NULL
    ,PRIMARY KEY(product_history_id)
);

-- 注文
CREATE TABLE tbl_order (
     order_id              varchar(32)    NOT NULL
    ,order_code            varchar(32)    NOT NULL
    ,member_code           varchar(32)    NOT NULL
    ,registration_date     timestamp       NOT NULL
    ,coupon_payment_amount bigint      NOT NULL
    ,cash_payment_amount   bigint      NOT NULL
    ,total_payment_amount  bigint      NOT NULL
    ,total_payment_tax     bigint      NOT NULL
    ,post_code_front       varchar(10)    NOT NULL
    ,post_code_back        varchar(10)    NOT NULL
    ,prefecture_id         varchar(32)    NOT NULL
    ,city                  varchar(128)   NOT NULL
    ,address1              varchar(1024)  NOT NULL
    ,last_name             varchar(64)    NOT NULL
    ,first_name            varchar(64)    NOT NULL
    ,last_name_kana        varchar(64)    NOT NULL
    ,first_name_kana       varchar(64)    NOT NULL
    ,company_name          varchar(256)   NOT NULL
    ,phone_number          varchar(32)    NOT NULL
    ,payment_method        varchar(32)    NOT NULL
    ,settlement_amount     bigint      NOT NULL
    ,total_settlement_tax  bigint      NOT NULL
    ,create_user           varchar(32)    NOT NULL
    ,create_time           timestamp       DEFAULT now() NOT NULL
    ,update_user           varchar(32)    NOT NULL
    ,update_time           timestamp       DEFAULT now() NOT NULL
    ,version               int8       DEFAULT 1 NOT NULL
    ,PRIMARY KEY(order_id)
);

-- 注文詳細
CREATE TABLE tbl_order_detail (
     order_detail_id         varchar(32)    NOT NULL
    ,order_code              varchar(32)    NOT NULL
    ,product_history_id      varchar(32)        NOT NULL
    ,sku_group               text
    ,order_status            smallint        NOT NULL
    ,product_purchase_amount bigint       NOT NULL
    ,order_price             bigint     NOT NULL
    ,slip_number             varchar(32)
    ,slip_memo               varchar(1024)
    ,payment_shipping_fee    bigint      NOT NULL
    ,settlement_price        bigint      NOT NULL
    ,settlement_id           varchar(32)    NOT NULL
    ,create_user             varchar(32)    NOT NULL
    ,create_time             timestamp       DEFAULT now() NOT NULL
    ,update_user             varchar(32)    NOT NULL
    ,update_time             timestamp       DEFAULT now() NOT NULL
    ,version                 int8       DEFAULT 1 NOT NULL
    ,PRIMARY KEY(order_detail_id)
);

-- 属性（SKU）
CREATE TABLE mst_sku (
     sku_id      varchar(32)   NOT NULL
    ,sku_key     varchar(32)   NOT NULL
    ,sku_name    varchar(256)  NOT NULL
    ,sku_value   text
    ,create_user varchar(32)   NOT NULL
    ,create_time timestamp      DEFAULT now() NOT NULL
    ,update_user varchar(32)   NOT NULL
    ,update_time timestamp      DEFAULT now() NOT NULL
    ,version     int8      DEFAULT 1 NOT NULL
    ,PRIMARY KEY(sku_id)
);

-- カテゴリ属性（SKU）
CREATE TABLE trn_category_sku (
     category_sku_id varchar(32)  NOT NULL
    ,sku_id          varchar(32)  NOT NULL
    ,category_id     varchar(32)  NOT NULL
    ,create_user     varchar(32)  NOT NULL
    ,create_time     timestamp     DEFAULT now() NOT NULL
    ,update_user     varchar(32)  NOT NULL
    ,update_time     timestamp     DEFAULT now() NOT NULL
    ,version         int8     DEFAULT 1 NOT NULL
    ,PRIMARY KEY(category_sku_id)
);

-- 商品属性（SKU）
CREATE TABLE trn_product_sku (
     product_sku_id varchar(32)  NOT NULL
    ,sku_id         varchar(32)  NOT NULL
    ,product_id     varchar(32)  NOT NULL
    ,create_user    varchar(32)  NOT NULL
    ,create_time    timestamp     DEFAULT now() NOT NULL
    ,update_user    varchar(32)  NOT NULL
    ,update_time    timestamp     DEFAULT now() NOT NULL
    ,version        int8     DEFAULT 1 NOT NULL
    ,PRIMARY KEY(product_sku_id)
);

-- 決済
CREATE TABLE trn_settlement (
     settlement_id     varchar(32)  NOT NULL
    ,settlement_status smallint      NOT NULL
    ,settlement_amount bigint   NOT NULL
    ,access_id         varchar(32)
    ,access_pass       varchar(32)
    ,error_code        varchar(64)
    ,limit_date        timestamp
    ,payment_date      timestamp
    ,create_user       varchar(32)  NOT NULL
    ,create_time       timestamp     DEFAULT now() NOT NULL
    ,update_user       varchar(32)  NOT NULL
    ,update_time       timestamp     DEFAULT now() NOT NULL
    ,version          int8     DEFAULT 1 NOT NULL
    ,PRIMARY KEY(settlement_id)
);

-- 東亜スタッフ
CREATE TABLE mst_toa_staffs (
     toa_staff_id varchar(32)
    ,email        varchar(255)  NOT NULL
    ,password     varchar(32)   NOT NULL
    ,name         varchar(64)   NOT NULL
    ,admin_flg    boolean    DEFAULT false NOT NULL
    ,memo         varchar(512)
    ,status       boolean
    ,create_time  timestamp      DEFAULT now() NOT NULL
    ,update_user  varchar(32)
    ,update_time  timestamp      DEFAULT now()
    ,version      int8      DEFAULT 1 NOT NULL
    ,deleted      boolean        NOT NULL
    ,PRIMARY KEY(toa_staff_id)
);

-- 東亜画面
CREATE TABLE mst_toa_screens (
     screen_id   varchar(32)    NOT NULL
    ,name        varchar(255)   NOT NULL
    ,path        varchar(1024)  NOT NULL
    ,create_user varchar(32)    NOT NULL
    ,create_time timestamp       DEFAULT now() NOT NULL
    ,update_user varchar(32)
    ,update_time timestamp       DEFAULT now()
    ,version     int8       DEFAULT 1 NOT NULL
    ,deleted     boolean         NOT NULL
    ,PRIMARY KEY(screen_id)
);

-- 東亜スタッフ管理
CREATE TABLE mst_toa_manages (
     manage_id        varchar(32)  NOT NULL
    ,screen_id        varchar(32)  NOT NULL
    ,toa_staff_id     varchar(32)  NOT NULL
    ,create_user      varchar(32)  NOT NULL
    ,create_time      timestamp     DEFAULT now() NOT NULL
    ,update_user      varchar(32)
    ,update_time      timestamp     DEFAULT now()
    ,version          int8     DEFAULT 1 NOT NULL
    ,PRIMARY KEY(manage_id)
);

-- 出品者
CREATE TABLE mst_distributors (
     distributor_id  varchar(32)    NOT NULL
    ,email           varchar(255)   NOT NULL
    ,password        varchar(32)    NOT NULL
    ,name            varchar(64)    NOT NULL
    ,company         varchar(512)   NOT NULL
    ,phone_number    varchar(20)    NOT NULL
    ,post_code_front varchar(10)
    ,post_code_back  varchar(10)
    ,prefecture      varchar(32)
    ,city            varchar(128)
    ,address         varchar(1024)
    ,company_tel     varchar(20)
    ,homepage_url    varchar(1024)
    ,shop_url        varchar(1024)
    ,memo            varchar(1024)
    ,transaction_low text
    ,status          char(1)       DEFAULT 0 NOT NULL
    ,create_user     varchar(32)    NOT NULL
    ,create_time     timestamp       DEFAULT now() NOT NULL
    ,update_user     varchar(32)
    ,update_time     timestamp       DEFAULT now()
    ,version         int8       DEFAULT 1 NOT NULL
    ,deleted         boolean         NOT NULL
    ,PRIMARY KEY(distributor_id)
);

-- 出品者スタッフ
CREATE TABLE mst_distributor_staffs (
     distributor_staff_id varchar(32)   NOT NULL
    ,distributor_id       varchar(32)   NOT NULL
    ,email                varchar(255)  NOT NULL
    ,password             varchar(32)   NOT NULL
    ,name                 varchar(64)   NOT NULL
    ,admin_flg            boolean     Default false NOT NULL
    ,memo                 varchar(255)
    ,status               CHAR(1)        DEFAULT 0 NOT NULL
    ,create_time          timestamp      DEFAULT now() NOT NULL
    ,update_user          varchar(32)
    ,update_time          timestamp      DEFAULT now()
    ,version              int8      DEFAULT 1 NOT NULL
    ,deleted              boolean        NOT NULL
    ,PRIMARY KEY(distributor_staff_id)
);

-- 出品者画面
CREATE TABLE mst_distributor_screens (
     screen_id   varchar(32)   NOT NULL
    ,name        varchar(64)   NOT NULL
    ,path        varchar(255)  NOT NULL
    ,create_user varchar(32)   NOT NULL
    ,create_time timestamp      DEFAULT now()  NOT NULL
    ,update_user varchar(32)   NOT NULL
    ,update_time timestamp DEFAULT now() NOT NULL
    ,version     int8       DEFAULT 1 NOT NULL
    ,deleted     boolean       DEFAULT false  NOT NULL
    ,PRIMARY KEY(screen_id)
);

-- 出品者スタッフ管理
CREATE TABLE mst_distributor_manages (
     manage_id                varchar(32)  NOT NULL
    ,screen_id                varchar(32)  NOT NULL
    ,distributor_staff_id     varchar(32)  NOT NULL
    ,create_user              varchar(32)  NOT NULL
    ,create_time              timestamp     DEFAULT now() NOT NULL
    ,update_user              varchar(32)
    ,update_time              timestamp     DEFAULT now()
    ,version                  int8     DEFAULT 1 NOT NULL
    ,PRIMARY KEY(manage_id)
);

-- 会員
CREATE TABLE mst_members (
     member_id         varchar(32)    NOT NULL
    ,member_code       varchar(32)    NOT NULL
    ,email             varchar(255)   NOT NULL
    ,password          varchar(32)    NOT NULL
    ,name              varchar(64)    NOT NULL
    ,name_kana         varchar(64)
    ,birthday          date            NOT NULL
    ,gender            varchar(10)    NOT NULL
    ,phone_number      varchar(20)    NOT NULL
    ,post_code_front   varchar(10)    NOT NULL
    ,post_code_back    varchar(10)    NOT NULL
    ,prefecture        varchar(64)    NOT NULL
    ,city              varchar(128)   NOT NULL
    ,address           varchar(1024)  NOT NULL
    ,term_was_read     boolean         NOT NULL
    ,payment_member_id varchar(64)
    ,leave             boolean
    ,create_user       varchar(32)    NOT NULL
    ,create_time       timestamp       DEFAULT now() NOT NULL
    ,update_user       varchar(32)
    ,update_time       timestamp       DEFAULT now()
    ,version           int8       DEFAULT 1 NOT NULL
    ,PRIMARY KEY(member_id)
);

-- クレジットカード
CREATE TABLE tbl_creditcard (
     card_info_id      varchar(32)  NOT NULL
    ,member_code       varchar(32)  NOT NULL
    ,card_seq          bigint     NOT NULL
    ,payment_member_id varchar(60)  NOT NULL
    ,create_user       varchar(32)  NOT NULL
    ,create_time       timestamp     DEFAULT now() NOT NULL
    ,update_user       varchar(32)
    ,update_time       timestamp     DEFAULT now()
    ,version           int8     DEFAULT 1 NOT NULL
    ,PRIMARY KEY(card_info_id)
);

-- 退会
CREATE TABLE tbl_withdrawal (
     withdrawal_id   varchar(32)  NOT NULL
    ,member_code     varchar(32)  NOT NULL
    ,withdrawal_date DATE          NOT NULL
    ,reason          text          NOT NULL
    ,create_user     varchar(32)  NOT NULL
    ,create_time     timestamp     DEFAULT now() NOT NULL
    ,update_user     varchar(32)
    ,update_time     timestamp     DEFAULT now()
    ,version         int8     DEFAULT 1 NOT NULL
    ,PRIMARY KEY(withdrawal_id)
);

-- バーナー
CREATE TABLE mst_banners (
     banner_id     varchar(32)    NOT NULL
    ,display_order bigint       NOT NULL
    ,name          varchar(64)    NOT NULL
    ,image_id      varchar(32)    NOT NULL
    ,link_url      varchar(1024)  NOT NULL
    ,display_flg   boolean         NOT NULL
    ,start_date    timestamp       NOT NULL
    ,end_date      timestamp       NOT NULL
    ,create_user   varchar(32)    NOT NULL
    ,create_time   timestamp       DEFAULT now() NOT NULL
    ,update_user   varchar(32)
    ,update_time   timestamp       DEFAULT now()
    ,version       int8       DEFAULT 1 NOT NULL
    ,PRIMARY KEY(banner_id)
);

-- カテゴリー
CREATE TABLE mst_categories (
     category_id   varchar(32)  NOT NULL
    ,name          varchar(64)  NOT NULL
    ,parent_id     varchar(32)    NOT NULL
    ,display_order smallint     NOT NULL
    ,create_user   varchar(32)  NOT NULL
    ,create_time   timestamp     DEFAULT now() NOT NULL
    ,update_user   varchar(32)
    ,update_time   timestamp     DEFAULT now()
    ,version       int8     DEFAULT 1 NOT NULL
    ,PRIMARY KEY(category_id)
);

-- タグ
CREATE TABLE mst_tags (
     tag_id        varchar(32)  NOT NULL
    ,name          varchar(64)  NOT NULL
    ,display_order smallint     NOT NULL
    ,create_user   varchar(32)  NOT NULL
    ,create_time   timestamp     DEFAULT now() NOT NULL
    ,update_user   varchar(32)
    ,update_time   timestamp     DEFAULT now()
    ,version       int8     DEFAULT 1 NOT NULL
    ,PRIMARY KEY(tag_id)
);

-- 税率
CREATE TABLE mst_tax (
     tax_id         varchar(32)  NOT NULL
    ,tax_percent    smallint     NOT NULL
    ,tax_rule       smallint     NOT NULL
    ,apply_datetime timestamp     NOT NULL
    ,create_user    varchar(32)  NOT NULL
    ,create_time    timestamp     DEFAULT now() NOT NULL
    ,update_user    varchar(32)
    ,update_time    timestamp     DEFAULT now()
    ,version        int8     DEFAULT 1 NOT NULL
    ,PRIMARY KEY(tax_id)
);

-- メールテンプレート
CREATE TABLE mst_mails (
     mail_template_id   varchar(32)   NOT NULL
    ,mail_template_name varchar(64)   NOT NULL
    ,mail_subject       varchar(256)  NOT NULL
    ,mail_body          text           NOT NULL
    ,create_user        varchar(32)   NOT NULL
    ,create_time        timestamp      DEFAULT now() NOT NULL
    ,update_user        varchar(32)
    ,update_time        timestamp      DEFAULT now()
    ,version            int8      DEFAULT 1 NOT NULL
    ,PRIMARY KEY(mail_template_id)
);

-- 利用規約
CREATE TABLE mst_terms_use (
     terms_use_id varchar(32)  NOT NULL
    ,title_name   varchar(64)  NOT NULL
    ,content      text          NOT NULL
    ,create_user  varchar(32)  NOT NULL
    ,create_time  timestamp     DEFAULT now() NOT NULL
    ,update_user  varchar(32)
    ,update_time  timestamp     DEFAULT now()
    ,version      int8     DEFAULT 1 NOT NULL
    ,PRIMARY KEY(terms_use_id)
);

-- プライバシーポリシー
CREATE TABLE tbl_privacy_policy (
     privacy_id  varchar(32)  NOT NULL
    ,title_name  varchar(64)  NOT NULL
    ,content     text          NOT NULL
    ,create_user varchar(32)  NOT NULL
    ,create_time timestamp     DEFAULT now() NOT NULL
    ,update_user varchar(32)
    ,update_time timestamp     DEFAULT now()
    ,version     int8     DEFAULT 1 NOT NULL
    ,PRIMARY KEY(privacy_id)
);

-- 欲しいリスト
CREATE TABLE tbl_like (
     like_id     varchar(32)  NOT NULL
    ,member_code varchar(32)
    ,product_id  varchar(32)  NOT NULL
    ,create_user varchar(32)   NOT NULL
    ,create_time timestamp     DEFAULT now() NOT NULL
    ,update_user varchar(32)
    ,update_time timestamp     DEFAULT now()
    ,version     int8     DEFAULT 1 NOT NULL
    ,PRIMARY KEY(like_id)
);

-- 禁止出品リスト
CREATE TABLE tbl_forbidden_items (
     forbidden_item_id varchar(32)  NOT NULL
    ,product_id        varchar(32)  NOT NULL
    ,reason            text
    ,create_user       varchar(32)   NOT NULL
    ,create_time       timestamp     DEFAULT now() NOT NULL
    ,update_user       varchar(32)
    ,update_time       timestamp     DEFAULT now()
    ,version           int8     DEFAULT 1 NOT NULL
    ,PRIMARY KEY(forbidden_item_id)
);

-- CSV出力項目（出品者）
CREATE TABLE tbl_distributor_csv_items (
     csv_item_id    varchar(32)   NOT NULL
    ,distributor_id varchar(32)   NOT NULL
    ,csv_item_key   varchar(32)   NOT NULL
    ,csv_item_name  varchar(128)  NOT NULL
    ,output_flg     boolean        NOT NULL
    ,display_order  smallint     NOT NULL
    ,create_user    varchar(32)   NOT NULL
    ,create_time    timestamp      DEFAULT now() NOT NULL
    ,update_user    varchar(32)
    ,update_time    timestamp      DEFAULT now()
    ,version        int8      DEFAULT 1 NOT NULL
    ,PRIMARY KEY(csv_item_id)
);
