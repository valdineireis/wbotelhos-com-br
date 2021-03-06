FactoryGirl.define do
  factory :user do
    name                  'Washington Botelho'
    sequence(:email)      { |i| "wbotelhos#{i}@gmail.com" }
    password              'password'
    password_confirmation 'password'
  end

  factory :category do
    sequence(:name) { |i| "category-#{i}" }
  end

  factory :article do
    sequence(:title)  { |i| "title #{i}" }
    sequence(:slug)   { |i| "title-#{i}" }
    body              'body <!--more--> body'
    association       :user
    categories        { |categories| [categories.association(:category)] }

    factory :article_draft do
      created_at    Time.zone.now
      updated_at    Time.zone.now
      published_at  nil
    end

    factory :article_published do
      created_at    Time.zone.local(1984, 10, 23)
      published_at  Time.zone.local(1984, 10, 23)
      updated_at    Time.zone.local(1984, 10, 23)
    end
  end

  factory :article_category do
    association :article
    association :category
  end

  factory :comment do
    sequence(:name)   { |i| "name #{i}" }
    sequence(:email)  { |i| "email#{i}@mail.com" }
    url               'http://url.com'
    body              'body'
    association       :article

    factory :comment_with_author do
      author          true
      email           'author@email.com'
    end
  end

  factory :lab do
    sequence(:name) { |i| "name #{i}" }
    sequence(:slug) { |i| "name-#{i}" }

    factory :lab_draft do
      created_at    Time.zone.now
      published_at  nil
      updated_at    Time.zone.now
    end

    factory :lab_published do
      created_at    Time.zone.local(1984, 10, 23)
      published_at  Time.zone.local(1984, 10, 23)
      updated_at    Time.zone.local(1984, 10, 23)
    end
  end

  factory :link do
    sequence(:name) { |i| "name #{i}" }
    url             'http://url.com'
  end

  factory :donator do
    name              'Donator'
    sequence(:email)  { |i| "donator#{i}@mail.com" }
    amount            10.00
  end
end
