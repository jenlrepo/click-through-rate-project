#################################################
#												#
# 			Mid-Term CTR project 				#
#												#
#################################################


set global local_infile = true; -- allow for local file upload create databases


drop database if exists ctr;
create database ctr;

use ctr;


############## TRANSACTIONS TABLE ##############

drop table if exists transactions;
-- to make sure nothing is appended on to an existing table

-- ###### CREATE the transactions table (an empty table) ######
create table transactions
(
    maid         varchar(20) not null, #user_id
    payment_time timestamp   not null, #or datetime
    money        int,
    kind_pay     varchar(10),
    kind_card    varchar(10),
    mid          varchar(50),          #store_id
    network      varchar(10),
    industry     int,
    gender       varchar(20),
    address      varchar(250),
    primary key (maid, payment_time)
);

truncate transactions;
-- avoid appending extra


###### LOAD transactions table ######
load data local infile 'C:\\Desktop\\DS Bootcamp\\Mid-term\\trans_4.csv'
    into table transactions
    fields terminated by ','
    enclosed by '"' -- data enclosed by " "
    lines terminated by '\n'
    (maid, @payment_time, money, kind_pay, kind_card, mid, network, industry, gender, address)
    SET payment_time = STR_TO_DATE(@payment_time, '%Y-%m-%d %H:%i:%s');


load data local infile 'C:\\Desktop\\DS Bootcamp\\Mid-term\\trans_5.csv'
    into table transactions
    fields terminated by ','
    enclosed by '"' -- data enclosed by " "
    lines terminated by '\n'
    (maid, @payment_time, money, kind_pay, kind_card, mid, network, industry, gender, address)
    SET payment_time = STR_TO_DATE(@payment_time, '%Y-%m-%d %H:%i:%s');


load data local infile 'C:\\Desktop\\DS Bootcamp\\Mid-term\\trans_6.csv'
    into table transactions
    fields terminated by ','
    enclosed by '"' -- data enclosed by " "
    lines terminated by '\n'
    (maid, @payment_time, money, kind_pay, kind_card, mid, network, industry, gender, address)
    SET payment_time = STR_TO_DATE(@payment_time, '%Y-%m-%d %H:%i:%s');


-- Check that the data was loaded
select *
from transactions
limit 10;


############## VIEWS TABLE ##############

drop table if exists views;

-- ###### Create the views table (an empty table) ######
create table views
(
    view_time    datetime,
    payment_time datetime    not null,
    maid         varchar(20) not null,
    mid          varchar(10),
    ad_id        varchar(20),
    primary key (payment_time, maid)
);

truncate views;

###### LOAD views table ######
load data local infile 'C:\\Desktop\\DS Bootcamp\\Mid-term\\aug-view-01-09.csv'
    into table views
    fields terminated by ','
    enclosed by '"' -- data enclosed by " "
    lines terminated by '\n'
    (@view_time, @payment_time, maid, mid, ad_id)
    SET view_time = STR_TO_DATE(REPLACE(@view_time, '"', ''), '%Y-%m-%d %H:%i:%s'),
        payment_time = STR_TO_DATE(REPLACE(@payment_time, '"', ''), '%Y-%m-%d %H:%i:%s');
;

load data local infile 'C:\\Desktop\\DS Bootcamp\\Mid-term\\aug-view-10.csv'
    into table views
    fields terminated by ','
    enclosed by '"' -- data enclosed by " "
    lines terminated by '\n'
    (@view_time, @payment_time, maid, mid, ad_id)
    SET view_time = STR_TO_DATE(REPLACE(@view_time, '"', ''), '%Y-%m-%d %H:%i:%s'),
        payment_time = STR_TO_DATE(REPLACE(@payment_time, '"', ''), '%Y-%m-%d %H:%i:%s');

load data local infile 'C:\\Desktop\\DS Bootcamp\\Mid-term\\aug-view-11-31.csv'
    into table views
    fields terminated by ','
    enclosed by '"' -- data enclosed by " "
    lines terminated by '\n'
    (@view_time, @payment_time, maid, mid, ad_id)
    SET view_time = STR_TO_DATE(REPLACE(@view_time, '"', ''), '%Y-%m-%d %H:%i:%s'),
        payment_time = STR_TO_DATE(REPLACE(@payment_time, '"', ''), '%Y-%m-%d %H:%i:%s');

-- Check that the data was loaded
select *
from views
limit 10;

-- counting rows
select count(*) as count
from views;
#it has 30339957 rows


############## CLICKS TABLE ##############

drop table if exists clicks;

-- ###### CREATE the clicks table (an empty table) ######
create table clicks
(
    click_time   datetime,
    payment_time datetime    not null,
    maid         varchar(20) not null,
    mid          varchar(10),
    ad_id        varchar(20),
    primary key (payment_time, maid)
);

truncate clicks;

###### LOAD clicks table ######
load data local infile 'C:\\Desktop\\DS Bootcamp\\Mid-term\\aug-click-01-09.csv'
    into table clicks
    fields terminated by ','
    enclosed by '"' -- data enclosed by " "
    lines terminated by '\n'
    (@click_time, @payment_time, maid, mid, ad_id)
    SET click_time = STR_TO_DATE(REPLACE(@click_time, '"', ''), '%Y-%m-%d %H:%i:%s'),
        payment_time = STR_TO_DATE(REPLACE(@payment_time, '"', ''), '%Y-%m-%d %H:%i:%s');

load data local infile 'C:\\Desktop\\DS Bootcamp\\Mid-term\\aug-click-10.csv'
    into table clicks
    fields terminated by ','
    enclosed by '"' -- data enclosed by " "
    lines terminated by '\n'
    (@click_time, @payment_time, maid, mid, ad_id)
    SET click_time = STR_TO_DATE(REPLACE(@click_time, '"', ''), '%Y-%m-%d %H:%i:%s'),
        payment_time = STR_TO_DATE(REPLACE(@payment_time, '"', ''), '%Y-%m-%d %H:%i:%s');

load data local infile 'C:\\Desktop\\DS Bootcamp\\Mid-term\\aug-click-11-31.csv'
    into table clicks
    fields terminated by ','
    enclosed by '"' -- data enclosed by " "
    lines terminated by '\n'
    (@click_time, @payment_time, maid, mid, ad_id)
    SET click_time = STR_TO_DATE(REPLACE(@click_time, '"', ''), '%Y-%m-%d %H:%i:%s'),
        payment_time = STR_TO_DATE(REPLACE(@payment_time, '"', ''), '%Y-%m-%d %H:%i:%s');

-- Check that the data was loaded
select *
from clicks
limit 10;

-- counting rows
select count(*) as count
from clicks;
#it has 2398968 rows


############## AD INFO TABLE ##############

drop table if exists ad_info;

-- ###### CREATE the ad_info table (an empty table) ######
create table ad_info
(
    row_id       int,
    ad_id        varchar(30) not null,
    ad_loc       int,
    ad_label     varchar(30),
    begin_time   datetime,
    end_time     datetime,
    pic_url      varchar(200),
    ad_url       varchar(300),
    ad_desc_url  varchar(300),
    ad_copy      varchar(100),
    min_money    float,
    mid          text,
    order_num    varchar(100),
    maid         text,
    city_id      text,
    idu_category varchar(300),
    click_hide   int,
    price        float,
    sys          int,
    network      varchar(10),
    user_gender  varchar(20),
    payment_kind varchar(20),
    primary key (ad_id)
);

truncate ad_info;

###### LOAD ad_info table ######
load data local infile 'C:\\Desktop\\DS Bootcamp\\Mid-term\\aug-ad-info-with-tags.csv'
    into table ad_info
    fields terminated by ','
    enclosed by '"' -- data enclosed by " "
    lines terminated by '\n'
    (row_id, ad_id, ad_loc, ad_label, @begin_time, @end_time, pic_url, ad_url, ad_desc_url, ad_copy, min_money, mid,
     order_num, maid, city_id, idu_category, click_hide, price, sys, network, user_gender, payment_kind)
    SET begin_time = STR_TO_DATE(REPLACE(@begin_time, '"', ''), '%Y-%m-%d %H:%i:%s'),
        end_time = STR_TO_DATE(REPLACE(@end_time, '"', ''), '%Y-%m-%d %H:%i:%s');


-- Check that the data was loaded
select *
from ad_info
limit 10;

############## EXTRACTING THE DATA ##############
# Only 2 days data is extracted due to my computer capability
-- Filter by Transactions with payment_time between Aug 1 to Aug 2
select *
from transactions
where payment_time between "2017-08-01 00:00:00" and "2017-08-02 23:59:59";

-- Create a table for filter by transactions with payment_time between Aug 1 to Aug 2
drop table if exists trans1;

CREATE TABLE trans1 as
select *
from transactions
where payment_time between "2017-08-01 00:00:00" and "2017-08-02 23:59:59";

select count(*) as count
from trans1;

-- Filter by Views with payment_time between "2017-08-01 00:00:00" and "2017-08-02 23:59:59"
select *
from views
where payment_time between "2017-08-01 00:00:00" and "2017-08-02 23:59:59"
  and view_time between "2017-08-01 00:00:00" and "2017-08-02 23:59:59"

-- Create a table for filter by views with payment_time and click_time between "2017-08-01 00:00:00" and "2017-08-02 23:59:59"
drop table if exists views1;

CREATE TABLE views1 as
select *
from views
where payment_time between "2017-08-01 00:00:00" and "2017-08-02 23:59:59"
  and view_time between "2017-08-01 00:00:00" and "2017-08-02 23:59:59";


-- Filter by Clicks with payment_time and click_time between "2017-08-01 00:00:00" and "2017-08-02 23:59:59"
select *
from clicks
where payment_time between "2017-08-01 00:00:00" and "2017-08-02 23:59:59"
  and click_time between "2017-08-01 00:00:00" and "2017-08-02 23:59:59";

-- Create a table for filter by clicks with payment_time and click_time between "2017-08-01 00:00:00" and "2017-08-02 23:59:59"
drop table if exists clicks1;

CREATE TABLE clicks1 as
select *
from clicks
where payment_time between "2017-08-01 00:00:00" and "2017-08-02 23:59:59"
  and click_time between "2017-08-01 00:00:00" and "2017-08-02 23:59:59"


############## PROCESSING THE DATA ##############
-- Create a views table with new feature
select *
from views1
limit 10;

# Create a new feature to count the total number of views for a payment made by a user
select maid, payment_time, COUNT(view_time) OVER (PARTITION BY maid, payment_time) as total_views_count
from views1
ORDER BY maid, payment_time;

drop table if exists views1_with_feature;

create table views1_with_feature
(
    view_time         datetime,
    payment_time      datetime    not null,
    maid              varchar(20) not null,
    mid               varchar(10),
    ad_id             varchar(20),
    total_views_count int,
    primary key (payment_time, maid)
);

truncate views1_with_feature;

#Load the dataset with new features into views1_with_feature table
insert into views1_with_feature (view_time, payment_time, maid, mid, ad_id, total_views_count)
    (select *, COUNT(view_time) OVER (PARTITION BY maid, payment_time) as total_views_count
     from views1
     ORDER BY maid, payment_time);


-- Create a clicks table with new features (3)
# A) Create a feature to find the total number of users who clicked an ad in the store
# Bi) Create a feature to count the total clicks by the no. of payments made by a user to click an ad
# Bii) Use Bi) to create a feature to label users who clicked and did not click the ad as target label

select *
from clicks1
limit 10;

# A) Create a feature to find the total number of users who clicked in the store
select *,
       count(click_time) OVER (PARTITION BY mid) as total_store_clicks
#        row_number() over (partition by mid, payment_time) as rnum
from clicks1
ORDER BY mid;


select *,
       COUNT(click_time) over (PARTITION BY maid) as total_user_clicks
from (select *,
             count(click_time) OVER (PARTITION BY mid) as total_store_clicks
      from clicks1
      ORDER BY mid) as sub
ORDER by maid;

# Bii) Use Bi) to create a feature to label users who clicked and did not click as target label
select *,
       CASE
           WHEN total_user_clicks is not null THEN 1
           ELSE 0
           END AS Clicked
from (
# Bi) Create a feature to count the total clicks by the no. of payments made by a user
         select *,
                COUNT(click_time) over (PARTITION BY maid) as total_user_clicks
         from (
                  # A) Create a feature to find the total number of users who clicked in the store
                  select *,
                         count(click_time) OVER (PARTITION BY mid) as total_store_clicks
                  from clicks1
                  ORDER BY mid) as sub1
         ORDER by maid) as sub2;


#check no. of clicks for a particular user (maid) and store (mid)
SELECT *,
       COUNT(click_time) OVER (PARTITION BY maid) AS total_maid_clicks
FROM clicks1
WHERE maid = '7B98VW'
ORDER BY maid;

select maid, count(click_time)
from clicks1
group by 1
having count(click_time) >= 6;

select mid, count(click_time)
from clicks1
group by 1
having count(click_time) >= 100;

select maid, count(view_time)
from views1
group by 1
having count(view_time) >= 10;
# select * from clicks1 where maid= 'ZVMw3';

drop table if exists clicks1_with_features;

create table clicks1_with_features
(
    click_time         datetime,
    payment_time       datetime    not null,
    maid               varchar(20) not null,
    mid                varchar(10),
    ad_id              varchar(20),
    total_store_clicks int,
    total_user_clicks  tinyint,
    Clicked            tinyint,
    primary key (payment_time, maid)
);

truncate clicks1_with_features;

#Load the dataset with new features into clicks1_with_features table
insert into clicks1_with_features (click_time, payment_time, maid, mid, ad_id, total_store_clicks, total_user_clicks, Clicked)
    (# Bii) Use Bi) to create a feature to label users who clicked and did not click the ad as target label
        select *,
               CASE
                   WHEN total_user_clicks is not null THEN 1
                   ELSE 0
                   END AS Clicked
        from (
# Bi) Create a feature to count the total clicks by the no. of payments made by a user to click an ad
                 select *,
                        COUNT(click_time) over (PARTITION BY maid) as total_user_clicks
                 from (
                          # A) Create a feature to find the total number of users who clicked an ad in the store
                          select *,
                                 count(click_time) OVER (PARTITION BY mid) as total_store_clicks
                          from clicks1
                          ORDER BY mid) as sub1
                 ORDER by maid) as sub2);


############## CREATE FINAL CTR_FINAL TABLE BY JOINING TRANS1 TABLE WITH views1_with_feature TABLE AND clicks1_with_features TABLE ##############
select *
from trans1
limit 10;

select count(*)
from trans1;

select t.*, v.*, c.*
from trans1 t
         # Use Left Join by 'using' instead of 'on'
         LEFT JOIN views1_with_feature v using (maid, payment_time)
         LEFT JOIN clicks1_with_features c using (maid, payment_time);

select count(*)
from trans1 t
         LEFT JOIN views1_with_feature v using (maid, payment_time)
         LEFT JOIN clicks1_with_features c using (maid, payment_time);


drop table if exists CTR_final;

# CREATE final CTR_final table by joining trans1 table with view1_with_feature table and clicks1_with_features table to store the results
create table CTR_final
(
    payment_hour       tinyint,
    money              int,
    kind_pay           varchar(10),
    kind_card          varchar(10),
    network            varchar(10),
    industry           int,
    gender             varchar(20),
    ad_id              varchar(20),
    total_views_count int,
    payment_view_time  int,
    total_store_clicks int,
    total_user_clicks  tinyint,
    Clicked            tinyint
);

truncate CTR_final;

insert into CTR_final(payment_hour, money, kind_pay, kind_card, network, industry, gender, ad_id, total_views_count, payment_view_time, total_store_clicks,
                      total_user_clicks, Clicked)
    (select HOUR(t.payment_time),
            t.money,
            t.kind_pay,
            t.kind_card,
            t.network,
            t.industry,
            t.gender,
            v.ad_id,
            v.total_views_count,
            timestampdiff(second, v.payment_time, v.view_time) as payment_view_time,
            c.total_store_clicks,
            c.total_user_clicks,
            c.Clicked
     from trans1 t
              LEFT JOIN views1_with_feature v using (maid, payment_time)
              LEFT JOIN clicks1_with_features c using (maid, payment_time)
     );


############## UPDATING CTR_FINAL TABLE ##############
#Update records of 'Clicked' is null to 0 since all records when 'Clicked' is true should have been merged.
UPDATE CTR_final SET Clicked= 0 where Clicked is null;

#Update cases of 'total_views_count' is null to 0 since all cases when 'total_views_count' is >= 1 should have been merged.
UPDATE CTR_final SET total_views_count= 0 where total_views_count is null;


#To check for clicked is 0 when Clicked is null
select *
from CTR_final
where Clicked = 0 limit 100;


Questions:
1.What are the total transactions, views, and clicks in your final table (after Joins/unions for all or selected days)?

# To count the total transactions in CTR_final
select count(*)
from CTR_final;
Answer: 2491388

# To count total views in CTR_final
select count(total_views_count)
from CTR_final
where total_views_count is not null;
Answer: 1793032

# To count total clicks in CTR_final
select count(Clicked)
from CTR_final
where Clicked = 1;
Answer: 205145


2. What are the start
and end Datetime of the dataset?
Duration of dataset: "2017-08-01 00:00:00" to "2017-08-02 23:59:59"

