# README

## usersテーブル

| Column             | Type    | Options                   |
|--------------------|---------|---------------------------|
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| first_name_kanji   | string  | null: false               |
| last_name_kanji    | string  | null: false               |
| first_name_kana    | string  | null: false               |
| last_name_kana     | string  | null: false               |
| year_of_birth      | string  | null: false               |
| month_of_birth     | string  | null: false               |
| date_of_birth      | string  | null: false               |

## Association

- has_many :items
- has_many :purchases

## itemsテーブル

| Column             | Type       | Options                        |
|--------------------|------------|--------------------------------|
| name               | string     | null: false                    |
| description        | text       | null: false                    |
| category           | string     | null: false                    |
| condition          | string     | null: false                    |
| shipping_charge    | string     | null: false                    |
| ship_from          | string     | null: false                    |
| shipping_days      | string     | null: false                    |
| price              | integer    | null: false                    |
| user_id            | references | null: false, foreign_key: true |

## Association

  belongs_to :user
  has_one :purchase

## purchasesテーブル
| Column             | Type       | Options                        |
|--------------------|------------|--------------------------------|
| user_id            | references | null: false, foreign_key: true |
| item_id            | references | null: false, foreign_key: true |

## Association

  belongs_to :user
  belongs_to :item
  has_one :destination

## destinationsテーブル

| Column          | Type       | Options                        |
|-----------------|------------|--------------------------------|
| post_code       | string     | null: false                    |
| prefectures     | string     | null: false                    |
| city            | string     | null: false                    |
| block           | string     | null: false                    |
| phone_no        | string     | null: false                    |
| purchase_id     | references | null: false, foreign_key: true |

## Association

  belongs_to :purchase
